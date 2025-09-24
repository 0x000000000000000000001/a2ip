import { SourceMapConsumer } from 'source-map';
import fs from 'fs';
import path from 'path';

const moduleCounters = {};

// Cache des source maps pour éviter de les relire
const sourceMapCache = new Map();

// Charger une source map
function loadSourceMap(jsFilePath) {
    if (sourceMapCache.has(jsFilePath)) {
        return sourceMapCache.get(jsFilePath);
    }
    
    try {
        const mapPath = jsFilePath + '.map';
        if (fs.existsSync(mapPath)) {
            const rawMap = JSON.parse(fs.readFileSync(mapPath, 'utf8'));
            sourceMapCache.set(jsFilePath, rawMap);
            return rawMap;
        }
    } catch (e) {
        console.warn('Could not load source map for', jsFilePath);
    }
    
    return null;
}

// Convertir position JS → position PureScript
function jsLocationToPursLocation(jsFile, jsLine, jsColumn) {
    const sourceMap = loadSourceMap(jsFile);
    if (!sourceMap) {
        return null; // Pas de source map trouvée
    }
    
    try {
        return SourceMapConsumer.with(sourceMap, null, consumer => {
            const original = consumer.originalPositionFor({
                line: parseInt(jsLine),
                column: parseInt(jsColumn) || 0
            });
            
            if (original.source && original.line) {
                // Nettoyer le chemin pour avoir juste le nom du fichier
                const pursFile = path.basename(original.source);
                return {
                    file: pursFile,
                    line: original.line,
                    column: original.column || 0
                };
            }
            
            return null;
        });
    } catch (e) {
        console.warn('Error mapping JS to PureScript:', e.message);
        return null;
    }
}

// Capture the line number where the 'it' function is called
export const getItCallLine = function() {
    try {
        const stack = new Error().stack;
        const lines = stack.split('\n');
        
        // Look for the specific call to 'it' in a test module
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            
            // Look for the pattern that indicates a test file calling our it()
            const match = line.match(/output\/(Test\.[^\/]+)\/index\.js:(\d+):\d+/);
            if (match) {
                const moduleName = match[1];
                const jsLineNumber = parseInt(match[2], 10);
                
                // Skip our own Test.Utils.Spec module
                if (moduleName !== 'Test.Utils.Spec') {
                    // Initialize counter for this module if needed
                    if (!moduleCounters[moduleName]) {
                        moduleCounters[moduleName] = 0;
                    }
                    
                    // Increment counter
                    moduleCounters[moduleName]++;
                    const testIndex = moduleCounters[moduleName];
                    
                    // Try to use source maps to find the actual PureScript line
                    try {
                        const jsFile = path.join(process.cwd(), 'output', moduleName, 'index.js');
                        const pursLocation = jsLocationToPursLocation(jsFile, jsLineNumber, 0);
                        
                        if (pursLocation && pursLocation.line && pursLocation.line > 0) {
                            // We have the actual PureScript location!
                            console.log(`Source map: JS line ${jsLineNumber} → PureScript ${pursLocation.file}:${pursLocation.line}`);
                            return pursLocation.line;
                        }
                        
                        // Fallback: read the .purs file directly and count 'it' occurrences
                        const pathParts = moduleName.split('.');
                        pathParts[0] = 'test';
                        const filePath = path.join(process.cwd(), pathParts.join('/') + '.purs');
                        
                        // Read the file and find all 'it' lines
                        const content = fs.readFileSync(filePath, 'utf8');
                        const fileLines = content.split('\n');
                        
                        const itLines = [];
                        for (let j = 0; j < fileLines.length; j++) {
                            if (fileLines[j].trim().startsWith('it "')) {
                                itLines.push(j + 1); // 1-based line numbers
                            }
                        }
                        
                        // Return the line for this test index
                        if (itLines[testIndex - 1]) {
                            return itLines[testIndex - 1];
                        }
                    } catch (e) {
                        console.warn('Error getting source location:', e.message);
                        // Fallback to JS line if everything fails
                    }
                    
                    return 1;
                }
            }
        }
        
        return 1;
    } catch (e) {
        return 1;
    }
};
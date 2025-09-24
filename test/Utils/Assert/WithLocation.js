import { SourceMapConsumer } from 'source-map';
import fs from 'fs';
import path from 'path';

// Cache des source maps
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
        // Silencieux en cas d'échec
    }
    
    return null;
}

// Convertir position JS → position PureScript
function jsLocationToPursLocation(jsFile, jsLine, jsColumn) {
    const sourceMap = loadSourceMap(jsFile);
    if (!sourceMap) {
        return null;
    }
    
    try {
        return SourceMapConsumer.with(sourceMap, null, consumer => {
            const original = consumer.originalPositionFor({
                line: parseInt(jsLine),
                column: parseInt(jsColumn) || 0
            });
            
            if (original.source && original.line) {
                return original.line;
            }
            
            return null;
        });
    } catch (e) {
        return null;
    }
}

// Fonction qui capture la vraie ligne d'assertion
export const getCurrentAssertionLine = function() {
    try {
        const stack = new Error().stack;
        if (!stack) return "line:?";
        
        console.log("=== STACK TRACE DEBUG ===");
        console.log(stack);
        console.log("=========================");
        
        const lines = stack.split('\n');
        
        // Rechercher dans toute la stack trace les modules de test
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            console.log(`Line ${i}:`, line);
            
            // Chercher les références aux modules compilés
            const match = line.match(/file:\/\/.*?\/output\/(Test\.Utils\..*?)\/index\.js:(\d+):(\d+)/);
            if (match) {
                const moduleName = match[1];
                const jsLine = parseInt(match[2], 10);
                const jsColumn = parseInt(match[3], 10);
                
                // Construire le chemin vers la source map
                const sourceMapPath = `./output/${moduleName}/index.js.map`;
                
                if (fs.existsSync(sourceMapPath)) {
                    try {
                        const sourceMapContent = fs.readFileSync(sourceMapPath, 'utf8');
                        const sourceMap = JSON.parse(sourceMapContent);
                        
                        return SourceMapConsumer.with(sourceMap, null, consumer => {
                            const original = consumer.originalPositionFor({
                                line: jsLine,
                                column: jsColumn
                            });
                            
                            if (original && original.line) {
                                return `line:${original.line}`;
                            }
                            
                            return `js-line:${jsLine}`;
                        });
                    } catch (e) {
                        return `js-line:${jsLine}`;
                    }
                } else {
                    return `js-line:${jsLine}`;
                }
            }
        }
        
        // Fallback: analyser les lignes pour d'autres patterns
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            
            // Pattern alternatif sans file://
            const altMatch = line.match(/output\/(Test\.Utils\..*?)\/index\.js:(\d+):(\d+)/);
            if (altMatch) {
                const moduleName = altMatch[1];
                const jsLine = parseInt(altMatch[2], 10);
                const jsColumn = parseInt(altMatch[3], 10);
                
                const sourceMapPath = `./output/${moduleName}/index.js.map`;
                
                if (fs.existsSync(sourceMapPath)) {
                    try {
                        const sourceMapContent = fs.readFileSync(sourceMapPath, 'utf8');
                        const sourceMap = JSON.parse(sourceMapContent);
                        
                        return SourceMapConsumer.with(sourceMap, null, consumer => {
                            const original = consumer.originalPositionFor({
                                line: jsLine,
                                column: jsColumn
                            });
                            
                            if (original && original.line) {
                                return `line:${original.line}`;
                            }
                            
                            return `js-line:${jsLine}`;
                        });
                    } catch (e) {
                        return `js-line:${jsLine}`;
                    }
                } else {
                    return `js-line:${jsLine}`;
                }
            }
        }
        
        return "line:no-match";
    } catch (error) {
        return `line:error-${error.message.substring(0, 20)}`;
    }
};

// Fonction qui capture la ligne au moment exact de l'appel
export const captureLineAtCallSite = function() {
    try {
        const stack = new Error().stack;
        if (!stack) return "line:?";
        
        console.log("=== CALL SITE STACK TRACE DEBUG ===");
        console.log(stack);
        console.log("===================================");
        
        const lines = stack.split('\n');
        
        // Rechercher dans toute la stack trace les modules de test
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            console.log(`Call site line ${i}:`, line);
            
            // Chercher les références aux modules compilés de test
            const match = line.match(/file:\/\/.*?\/output\/(Test\.Utils\..*?)\/index\.js:(\d+):(\d+)/);
            if (match) {
                const moduleName = match[1];
                const jsLine = parseInt(match[2], 10);
                const jsColumn = parseInt(match[3], 10);
                
                console.log(`Found test module: ${moduleName}, JS line: ${jsLine}`);
                
                // Construire le chemin vers la source map
                const sourceMapPath = `./output/${moduleName}/index.js.map`;
                
                if (fs.existsSync(sourceMapPath)) {
                    try {
                        const sourceMapContent = fs.readFileSync(sourceMapPath, 'utf8');
                        const sourceMap = JSON.parse(sourceMapContent);
                        
                        return SourceMapConsumer.with(sourceMap, null, consumer => {
                            const original = consumer.originalPositionFor({
                                line: jsLine,
                                column: jsColumn
                            });
                            
                            console.log(`Source map result:`, original);
                            
                            if (original && original.line) {
                                return `line:${original.line}`;
                            }
                            
                            return `js-line:${jsLine}`;
                        });
                    } catch (e) {
                        console.log(`Source map error:`, e);
                        return `js-line:${jsLine}`;
                    }
                } else {
                    console.log(`Source map not found at: ${sourceMapPath}`);
                    return `js-line:${jsLine}`;
                }
            }
        }
        
        return "line:no-call-site-match";
    } catch (error) {
        return `line:call-error-${error.message.substring(0, 20)}`;
    }
};

// Version synchrone pure qui capture immédiatement
export const _captureStackTraceSync = function(unit) {
    try {
        const stack = new Error().stack;
        if (!stack) return "line:?";
        
        const lines = stack.split('\n');
        
        // Rechercher dans toute la stack trace les modules de test
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            
            // Chercher les références aux modules compilés de test
            const match = line.match(/file:\/\/.*?\/output\/(Test\.Utils\..*?)\/index\.js:(\d+):(\d+)/);
            if (match) {
                const moduleName = match[1];
                const jsLine = parseInt(match[2], 10);
                
                // Ignorer nos propres modules utilitaires pour chercher le vrai module de test
                if (moduleName === 'Test.Utils.Assert.WithLocation' || 
                    moduleName === 'Test.Utils.Assert' ||
                    moduleName === 'Test.Utils.Spec' ||
                    moduleName === 'Test.Utils.Bdd.Describe.Here') {
                    continue;
                }
                
                // Pour l'instant, approximation simple: ligne JS - 2 = ligne PureScript 
                // (car il y a généralement 2 lignes de boilerplate au début du fichier JS)
                const approximatePursLine = Math.max(1, jsLine - 2);
                
                return `line:${approximatePursLine}`;
            }
        }
        
        return "line:no-match";
    } catch (error) {
        return `line:error`;
    }
};
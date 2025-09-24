import { SourceMapConsumer } from 'source-map';
import fs from 'fs';

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
                
                // Convertir le nom du module en chemin de fichier
                // Test.Utils.Html.Encoding.DecodeHtmlEntities → test/Utils/Html/Encoding/DecodeHtmlEntities.purs
                const filePath = moduleName.replace(/^Test\./, 'test/')
                                          .replace(/\./g, '/') + '.purs';
                
                // Essayer de trouver la ligne exacte en analysant le code JS et le fichier PureScript
                try {
                    // Lire le fichier JS pour extraire des indices sur l'assertion exacte
                    const jsFilePath = `./output/${moduleName}/index.js`;
                    const jsContent = fs.readFileSync(jsFilePath, 'utf8');
                    const jsLines = jsContent.split('\n');
                    const jsLineContent = jsLines[jsLine - 1]; // 0-based array
                    
                    // Essayer d'extraire des indices de l'assertion JS
                    let searchPattern = null;
                    
                    // Chercher des patterns comme decodeHtmlEntities("...") ou ("...")
                    const patterns = [
                        /decodeHtmlEntities\("([^"]*)"\).*?\("([^"]*)"\)/,  // decodeHtmlEntities("x")...("y")
                        /decodeHtmlEntities\('([^']*)'\).*?\('([^']*)'\)/,   // decodeHtmlEntities('x')...('y')
                        /decodeHtmlEntities\("([^"]*)"\)/,                   // juste decodeHtmlEntities("x")
                        /\("([^"]*)"\)\)\("([^"]*)"\)$/                      // ("x"))("y") à la fin
                    ];
                    
                    for (const pattern of patterns) {
                        const match = jsLineContent.match(pattern);
                        if (match) {
                            if (match[1] !== undefined && match[2] !== undefined) {
                                // Pattern avec deux parties (input et expected)
                                searchPattern = `"${match[1]}" === "${match[2]}"`;
                            } else if (match[1] !== undefined) {
                                // Pattern avec juste l'input
                                searchPattern = `"${match[1]}"`;
                            }
                            break;
                        }
                    }
                    
                    // Lire le fichier PureScript et chercher la ligne exacte
                    const pursContent = fs.readFileSync(filePath, 'utf8');
                    const pursLines = pursContent.split('\n');
                    
                    if (searchPattern) {
                        // Chercher la ligne qui contient notre pattern spécifique
                        for (let lineNum = 1; lineNum <= pursLines.length; lineNum++) {
                            const line = pursLines[lineNum - 1]; // 0-based array
                            if (line && line.includes(searchPattern)) {
                                return `${filePath}:${lineNum}`;
                            }
                        }
                    }
                    
                    // Fallback: chercher toute ligne avec une assertion proche de jsLine
                    const baseApprox = Math.max(1, jsLine - 5);
                    const endApprox = Math.min(pursLines.length, jsLine + 5);
                    
                    for (let lineNum = baseApprox; lineNum <= endApprox; lineNum++) {
                        const line = pursLines[lineNum - 1]; // 0-based array
                        if (line && (line.includes('===') || line.includes('shouldEqual'))) {
                            return `${filePath}:${lineNum}`;
                        }
                    }
                    
                    // Fallback à l'approximation simple
                    const approximatePursLine = Math.max(1, jsLine - 2);
                    return `${filePath}:${approximatePursLine}`;
                    
                } catch (e) {
                    // Fallback à l'approximation simple si erreur
                    const approximatePursLine = Math.max(1, jsLine - 2);
                    return `${filePath}:${approximatePursLine}`;
                }
            }
        }
        
        return "line:no-match";
    } catch (error) {
        return `line:error`;
    }
};
import { SourceMapConsumer } from 'source-map-js';
import fs from 'fs';

export const captureStackTrace = function() {
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
                const jsColumn = parseInt(match[3], 10);
                
                // Ignorer nos propres modules utilitaires pour chercher le vrai module de test
                if (moduleName === 'Test.Utils.Assert.WithLocation' || 
                    moduleName === 'Test.Utils.Assert' ||
                    moduleName === 'Test.Utils.Spec' ||
                    moduleName === 'Test.Utils.Bdd.Describe.Here') {
                    continue;
                }
                
                // Utiliser les source maps pour la vraie position
                try {
                    const sourceMapPath = `./output/${moduleName}/index.js.map`;

                    // console.log(sourceMapPath);
                    
                    if (fs.existsSync(sourceMapPath)) {
                        const sourceMapContent = fs.readFileSync(sourceMapPath, 'utf8');
                        const sourceMap = JSON.parse(sourceMapContent);

                        // console.log(sourceMap, jsLine, jsColumn, `./output/${moduleName}/index.js`);
                        
                        // API synchrone de source-map-js
                        const consumer = new SourceMapConsumer(sourceMap);
                        const originalPosition = consumer.originalPositionFor({
                            line: jsLine,
                            column: jsColumn
                        });
                        // console.log(originalPosition);

                        if (originalPosition && originalPosition.source && originalPosition.line) {
                            // Convertir le chemin source en chemin relatif propre
                            let sourcePath = originalPosition.source;
                            if (sourcePath.startsWith('../../')) {
                                sourcePath = sourcePath.substring(6); // Enlever '../../'
                            }

                            console.log(`${sourcePath}:${originalPosition.line}`);
                            
                            return `${sourcePath}:${originalPosition.line}`;
                        }
                    }
                    
                    // Fallback si pas de source map ou mapping échoue
                    const filePath = moduleName.replace(/^Test\./, 'test/').replace(/\./g, '/') + '.purs';
                    const approximateLine = Math.max(1, jsLine - 2);
                    return `${filePath}:${approximateLine}`;
                    
                } catch (e) {
                    console.log(e);
                    // Fallback en cas d'erreur avec les source maps
                    const filePath = moduleName.replace(/^Test\./, 'test/').replace(/\./g, '/') + '.purs';
                    const approximateLine = Math.max(1, jsLine - 2);
                    return `${filePath}:${approximateLine}`;
                }
            }
        }
        
        return "line:no-match";
    } catch (error) {
        return `line:error`;
    }
};
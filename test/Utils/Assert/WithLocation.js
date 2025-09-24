import { SourceMapConsumer } from 'source-map';
import fs from 'fs';

// Version synchrone pure qui utilise les source maps
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
                    
                    if (fs.existsSync(sourceMapPath)) {
                        const sourceMapContent = fs.readFileSync(sourceMapPath, 'utf8');
                        const sourceMap = JSON.parse(sourceMapContent);
                        
                        // Utiliser SourceMapConsumer pour mapper JS → PureScript
                        const consumer = new SourceMapConsumer(sourceMap);
                        const originalPosition = consumer.originalPositionFor({
                            line: jsLine,
                            column: jsColumn
                        });
                        
                        consumer.destroy();
                        
                        if (originalPosition && originalPosition.source && originalPosition.line) {
                            // Convertir le chemin source en chemin relatif propre
                            let sourcePath = originalPosition.source;
                            if (sourcePath.startsWith('../../')) {
                                sourcePath = sourcePath.substring(6); // Enlever '../../'
                            }
                            
                            return `${sourcePath}:${originalPosition.line}`;
                        }
                    }
                    
                    // Fallback si pas de source map ou mapping échoue
                    const filePath = moduleName.replace(/^Test\./, 'test/').replace(/\./g, '/') + '.purs';
                    const approximateLine = Math.max(1, jsLine - 2);
                    return `${filePath}:${approximateLine}`;
                    
                } catch (e) {
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
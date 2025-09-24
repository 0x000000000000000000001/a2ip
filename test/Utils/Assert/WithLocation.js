import { SourceMapConsumer } from 'source-map-js';
import fs from 'fs';

export const captureStackTrace = function() {
    try {
        const stack = new Error().stack;

        if (!stack) return '';
        
        const lines = stack.split('\n');
        
        for (let i = lines.length - 1; i >= 0; i--) {
            const line = lines[i];
            
            const match = line.match(/file:\/\/.*?\/output\/(Test\..*?)\/index\.js:(\d+):(\d+)/);
            if (match) {
                const moduleName = match[1];

                const jsLine = parseInt(match[2]);
                const jsColumn = parseInt(match[3]);
                
                try {
                    const sourceMapPath = `./output/${moduleName}/index.js.map`;

                    // console.log(sourceMapPath);
                    
                    if (fs.existsSync(sourceMapPath)) {
                        const sourceMapContent = fs.readFileSync(sourceMapPath, 'utf8');
                        const sourceMap = JSON.parse(sourceMapContent);

                        // API synchrone de source-map-js
                        const consumer = new SourceMapConsumer(sourceMap);
                        const originalPosition = consumer.originalPositionFor({
                            line: jsLine,
                            column: jsColumn
                        });
                        if (
                            moduleName.endsWith('DecodeHtmlEntities')
                        ) console.log(jsLine, jsColumn, originalPosition, `./output/${moduleName}/index.js`, consumer.hasContentsOfAllSources());

                        if (originalPosition && originalPosition.source && originalPosition.line) {
                            // Convertir le chemin source en chemin relatif propre
                            let sourcePath = originalPosition.source;
                            if (sourcePath.startsWith('../../')) {
                                sourcePath = sourcePath.substring(6); // Enlever '../../'
                            }

                            return `${sourcePath}:${originalPosition.line}`;
                        }
                    }
                    
                    return '';
                } catch (e) {
                    console.log(e);
                    return '';
                }
            }
        }
        
        return '';
    } catch (error) {
        return '';
    }
};
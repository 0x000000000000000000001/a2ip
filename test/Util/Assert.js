import { SourceMapConsumer } from 'source-map-js';
import fs from 'fs';

export const captureTrace = function() {
    const stack = new Error().stack;

    const unknown = '?:?:?';

    if (!stack) return unknown;
    
    const lines = stack.split('\n');

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];

        if (!line.includes('index.js') 
            || line.includes(import.meta.dirname)
        ) continue;
        
        const match = line.match(/file:\/\/.*?\/output\/(.*?)\/index\.js:(\d+):(\d+)/);

        if (match) {
            const moduleName = match[1];

            const jsLine = parseInt(match[2]);
            const jsColumn = parseInt(match[3]);
            
            const sourceMapPath = `./output/${moduleName}/index.js.map`;

            // if (moduleName.endsWith('DecodeHtmlEntities')) {
            //     console.log(sourceMapPath);
            //     debugAllMappings(sourceMapPath);
            // }
            
            if (fs.existsSync(sourceMapPath)) {
                const sourceMapContent = fs.readFileSync(sourceMapPath, 'utf8');
                const sourceMap = JSON.parse(sourceMapContent);

                const consumer = new SourceMapConsumer(sourceMap);
                const originalPosition = consumer.originalPositionFor({
                    line: jsLine,
                    column: jsColumn
                });

                if (originalPosition 
                    && originalPosition.source 
                    && originalPosition.line
                ) {
                    let sourcePath = originalPosition.source;

                    sourcePath = sourcePath.replaceAll('../', '');

                    return `${sourcePath}:${originalPosition.line}:${originalPosition.column}`;
                }
            }

            return unknown;
        }
    }
    
    return unknown;
};

// function debugAllMappings(sourceMapPath) {
//     const sourceMapContent = fs.readFileSync(sourceMapPath, 'utf8');
//     const consumer = new SourceMapConsumer(JSON.parse(sourceMapContent));

//     const allMappings = [];

//     consumer.eachMapping(mapping => {
//         if (mapping.source) {
//             allMappings.push({
//                 original: {
//                     source: mapping.source,
//                     line: mapping.originalLine,
//                     column: mapping.originalColumn
//                 },
//                 generated: {
//                     line: mapping.generatedLine,
//                     column: mapping.generatedColumn
//                 }
//             });
//         }
//     });

//     console.log(JSON.stringify(allMappings, null, 2));
//     console.log(`\nTotal de correspondances trouvées: ${allMappings.length}`);
// }
export const _here = function() {
    try {
        const stack = new Error().stack;
        const lines = stack.split('    at ');
    
        let ans = '';
        
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            const match = line.match(/Test\.(.+)\//);
    
            if (match && match.length > 1) {
                ans = match[1];
            }
        }

        // Convert to show both test file and source function
        if (ans) {
            const parts = ans.split('.');
            
            // For test file: keep the complete path with function name
            const testFile = `test/${parts.join('/')}.purs`;
            
            // For source file: remove the last part (function name) 
            const srcParts = [...parts];
            const funcName = srcParts.pop();
            const srcFile = `src/${srcParts.join('/')}.purs`;
            
            const displayName = funcName.charAt(0).toLowerCase() + funcName.slice(1);
            
            // Try to extract line number from the stack trace
            let lineNumber = '1'; // Default
            for (let i = 0; i < lines.length; i++) {
                const line = lines[i];
                // Look for pattern like "(/path/to/test/file.purs:15:1)"
                const lineMatch = line.match(/\(.*?\/test\/.*?\.purs:(\d+):\d+\)/);
                if (lineMatch && lineMatch[1]) {
                    lineNumber = lineMatch[1];
                    break;
                }
            }
            
            // Format: "test/path/Function.purs:line → src/path.purs"
            return `${testFile}:${lineNumber} → ${srcFile} @decodeHtmlEntities`;
        }

        return '';
    } catch (e) {
        console.error('Error in _here:', e);
        return '';
    }
};
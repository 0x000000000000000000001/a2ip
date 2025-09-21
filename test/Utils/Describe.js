export const getCallerModuleName = function() {
    try {
        const stack = new Error().stack;
        // console.log(stack);
        const lines = stack.split('    at ');
    
        let ans = '';
        
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            // console.log(line);
            
            const match = line.match(/Test\.(.+)\//);
    
            if (match && match.length > 1) {
                ans = match[1];
            }
        }
        
        return ans;
    } catch (e) {
        console.error(e);
    }
};
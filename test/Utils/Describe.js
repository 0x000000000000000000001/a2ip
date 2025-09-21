export const getCallerModuleName = function(full) {
    return function(lowerFirst) {
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

            if (!full) {
                const parts = ans.split('.');
                ans = parts[parts.length - 1];
            }

            if (lowerFirst) {
                // Lower case the first letter
                ans = ans.charAt(0).toLowerCase() + ans.slice(1);
            }
            
            return ans;
        } catch (e) {
            console.error(e);
        }
    };
};
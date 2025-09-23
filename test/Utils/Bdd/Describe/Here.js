export const _here = function() {
    // console.log('===');
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
                // console.log(line);
                ans = match[1];

                const dotCount = (ans.match(/\./g) || []).length;

                // It it ends with "Index"
                if (ans.endsWith('Index')) {
                    ans = ".";
                }
            }
        }

        return ans;
    } catch (e) {
        console.error(e);
    }
};
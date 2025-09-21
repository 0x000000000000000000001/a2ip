export const getCallerModuleName = function() {
    const stack = new Error().stack;
    const lines = stack.split('\n');
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        
        let match = line.match(/Test\.Utils\.([^.]+)\.([^.]+)\.([^.]+)\.([^.\s]+)/);
        // console.log(match);
        if (match) {
            return "Utils." + match[1] + "." + match[2] + "." + match[3] + "." + match[4];
        }
        
        match = line.match(/Test\.([^.\s]+)/);
        if (match) {
            return match[1];
        }
    }
    
    return "Unknown Module";
};
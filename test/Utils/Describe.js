import { detectTestModuleNamePrefix } from "./Module.js";

export const _describe = function() {
    const stack = new Error().stack;
    const lines = stack.split('    at ');

    let ans = '';
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        console.log(detectTestModuleNamePrefix());
        const match = line.match(/Test\.(.+)\//);

        if (match && match.length > 1) {
            ans = match[1];
        }
    }

    return ans + ':';
};
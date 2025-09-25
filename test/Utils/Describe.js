export const _describe = function() {
    const stack = new Error().stack;
    const lines = stack.split('    at ');

    let ans = '';
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];

        if (line.startsWith('file:')) {
            ans = line.split('/output/')[1].split('/index.js')[0];
            break;
        }
    }

    return ans + ':';
};
export const reflectCallingModuleName = function() {
    const stack = new Error().stack;
    const lines = stack.split('    at ');

    // console.log(lines);

    let ans = '';
    
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];

        if (!line.includes('index.js') 
            || line.includes(import.meta.dirname)
        ) continue;

        if (line.startsWith('file') || line.startsWith('http')) {
            ans = line.split('/output/')[1].split('/index.js')[0];
        }
    }

    // console.log(ans);

    return ans;
};
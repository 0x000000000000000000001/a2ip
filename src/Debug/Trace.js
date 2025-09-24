// Capture compilation-time information
let compilationInfo = null;

// This will be called during module loading (compilation phase)
function captureCompilationContext() {
    const stack = new Error().stack;
    const lines = stack.split('\n');
    
    // Find PureScript source references in the stack
    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        // Look for .purs files in the stack trace
        if (line.includes('.purs')) {
            const match = line.match(/([^\/]+\.purs):(\d+):(\d+)/);
            if (match) {
                return `${match[1]}:${match[2]}:${match[3]}`;
            }
        }
        // Fallback to any file reference
        if (line.includes('at ') && line.includes(':')) {
            const match = line.match(/at.*?([^\/\s]+\.(js|purs)):(\d+):(\d+)/);
            if (match) {
                return `${match[1]}:${match[3]}:${match[4]}`;
            }
        }
    }
    
    return "unknown:0:0";
}

// Capture at module load time (this happens during compilation/bundling)
compilationInfo = captureCompilationContext();

// Export the compilation-time trace
export const getCompileTimeTrace = compilationInfo;

// Get runtime stack trace
export const getRuntimeTrace = function() {
    return function() {
        const stack = new Error().stack;
        const lines = stack.split('\n');
        
        // Return the first few relevant stack frames
        const relevantLines = lines
            .slice(1, 4) // Skip the Error() constructor line
            .map(line => line.trim())
            .filter(line => line.length > 0)
            .join(' → ');
            
        return relevantLines || "no-runtime-trace";
    };
};

// Standard trace function (side-effectful logging)
export const trace = function(message) {
    return function(value) {
        console.log(message);
        return value;
    };
};
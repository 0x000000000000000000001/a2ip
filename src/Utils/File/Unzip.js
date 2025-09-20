// JSZip will be loaded from CDN and available as global variable
export const unzipImpl = function(filename) {
  return function(zipContent) {
    return function(onError) {
      return function(onSuccess) {
        return function() {
          try {
            // Check if JSZip is available globally
            if (typeof JSZip === 'undefined') {
              onError(new Error('JSZip library not found. Please include JSZip from CDN.'));
              return;
            }
            
            const zip = new JSZip();
            return zip.loadAsync(zipContent, { base64: false })
              .then(function(zip) {
                const files = Object.keys(zip.files);
                let targetFile;
                
                if (filename && filename !== '') {
                  targetFile = files.find(name => name === filename);
                  if (!targetFile) {
                    onError(new Error(`File '${filename}' not found in ZIP`));
                    return;
                  }
                } else {
                  targetFile = files.find(name => name.endsWith('.html'));
                  if (!targetFile) {
                    onError(new Error('No HTML file found in ZIP'));
                    return;
                  }
                }
                
                return zip.files[targetFile].async('string');
              })
              .then(function(content) {
                onSuccess(content);
              })
              .catch(function(error) {
                onError(error);
              });
          } catch (error) {
            onError(error);
          }
        };
      };
    };
  };
}
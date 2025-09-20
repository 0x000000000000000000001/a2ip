// JSZip will be loaded from CDN and available as global variable
export const unzipImpl = function(filename) {
  return function(zipContent) {
    return function(onError) {
      return function(onSuccess) {
        return function() {
          try {
            // Check if JSZip is available globally
            if (typeof JSZip === 'undefined') {
              onError(new Error('JSZip library not found. Please include JSZip from CDN.'))();
              return;
            }
            
            const zip = new JSZip();
            zip.loadAsync(zipContent, { base64: false })
              .then(function(zip) {
                const filename_ = filename + '.html';

                const files = Object.keys(zip.files);
                let targetFile;

                if (filename && filename !== '') {
                  targetFile = files.find(name => name === filename_);
                  if (!targetFile) {
                    throw new Error(`File '${filename_}' not found in ZIP`);
                  }
                } else {
                  targetFile = files.find(name => name.endsWith('.html'));
                  if (!targetFile) {
                    throw new Error('No HTML file found in ZIP');
                  }
                }

                return zip.files[targetFile].async('string');
              })
              .then(function(content) {
                onSuccess(content)();  // Execute the Effect explicitly
              })
              .catch(function(error) {
                onError(error)();  // Execute the Effect explicitly
              });
          } catch (error) {
            onError(error)();
          }
        };
      };
    };
  };
}
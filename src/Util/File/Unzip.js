import JSZip from 'jszip';

export const _unzip = function(filename) {
  return function(zipContent) {
    return function(onError) {
      return function(onSuccess) {
        return function() {
          console.log('[UNZIP] Starting unzip process...');
          const zip = new JSZip();

          zip.loadAsync(zipContent, { base64: false })
            .then(function(zip) {
              console.log('[UNZIP] ZIP loaded successfully');
              const filename_ = filename + '.html';

              const files = Object.keys(zip.files);
              console.log('[UNZIP] Files in ZIP:', files);

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

              console.log('[UNZIP] Target file:', targetFile);
              return zip.files[targetFile].async('string');
            })
            .then(function(content) {
              console.log('[UNZIP] Content extracted, length:', content.length);
              console.log('[UNZIP] Calling onSuccess callback...');
              try {
                const result = onSuccess(content)();
                console.log('[UNZIP] onSuccess called, result:', result);
              } catch (err) {
                console.error('[UNZIP] Error in onSuccess callback:', err);
              }
            })
            .catch(function(error) {
              console.error('[UNZIP] Error occurred:', error);
              try {
                onError(error)();
              } catch (err) {
                console.error('[UNZIP] Error in onError callback:', err);
              }
            });
        };
      };
    };
  };
}
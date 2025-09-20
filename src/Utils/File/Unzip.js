import JSZip from 'jszip';

export const unzipImpl = function(filename) {
  return function(zipContent) {
    return function(onError) {
      return function(onSuccess) {
        return function() {
          try {
            const zip = new JSZip();
            return zip.loadAsync(zipContent, { base64: false })
              .then(function(zip) {
                // Récupérer le fichier spécifié ou le premier fichier HTML
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
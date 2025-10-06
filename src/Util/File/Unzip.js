let JSZipModule;

export const _unzipGoogleSheetAndExtractHtml = function(filename) {
  return async function(zipContent) {
    if (!JSZipModule) // 'jszip' alone will not work for the browser.
      JSZipModule = await import('../../node_modules/jszip/dist/jszip.js');  

    const JSZip = JSZipModule.default || window.JSZip;

    const zip = new JSZip();

    const loadedZip = await zip.loadAsync(zipContent, { base64: false });
    
    const filename_ = filename + '.html';
    const files = Object.keys(loadedZip.files);

    let targetFile;

    if (filename && filename !== '') {
      targetFile = files.find(name => name === filename_);
      
      if (!targetFile) throw new Error(`File '${filename_}' not found in ZIP`);
    } else {
      targetFile = files.find(name => name.endsWith('.html'));

      if (!targetFile) throw new Error('No HTML file found in ZIP');
    }

    return await loadedZip.files[targetFile].async('string');
  };
};
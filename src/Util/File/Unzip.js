let JSZipModule;
let xxHashAPI;
let loadCache = {};
let targetFileCache = {};

export const _unzipGoogleSheetAndExtractHtml = function(filename) {
  return async function(zipContent) {
    const loadedZip = await _unzipGoogleSheet(zipContent);
    
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
    
    const targetFileCacheKey = loadCacheKey + '_' + targetFile;
    
    if (!targetFileCache[targetFileCacheKey]) {
      targetFileCache[targetFileCacheKey] = await loadedZip.files[targetFile].async('string');
    }

    return targetFileCache[targetFileCacheKey];
  };
};

export const _unzipToDirectory = function(outputPath) {
  return async function(zipContent) {
    const { mkdir, writeFile } = await import('fs/promises');
    const path = await import('path');
    
    const loadedZip = await _unzipGoogleSheet(zipContent);
    const files = Object.keys(loadedZip.files);
    
    await mkdir(outputPath, { recursive: true });
    
    for (const filename of files) {
      const file = loadedZip.files[filename];
      
      if (file.dir) {
        const dirPath = path.join(outputPath, filename);
        await mkdir(dirPath, { recursive: true });
      } else {
        const filePath = path.join(outputPath, filename);
        const fileDir = path.dirname(filePath);
        
        await mkdir(fileDir, { recursive: true });
        
        const content = await file.async('nodebuffer');
        await writeFile(filePath, content);
      }
    }
    
    return outputPath;
  };
};

export const _unzipGoogleSheet = async function(zipContent) {
  if (!JSZipModule) // 'jszip' alone will not work for the browser.
    JSZipModule = await import('../../node_modules/jszip/dist/jszip.js');  

  const JSZip = JSZipModule.default || window.JSZip;

  if (!xxHashAPI) {
    const xxhashModule = await import('../../node_modules/xxhash-wasm/esm/xxhash-wasm.js');
    xxHashAPI = await xxhashModule.default();
  }

  const zip = new JSZip();
  const loadCacheKey = xxHashAPI.h32Raw(zipContent);

  if (!loadCache[loadCacheKey]) {
    loadCache[loadCacheKey] = await zip.loadAsync(zipContent, { base64: false });
  }
  
  return loadCache[loadCacheKey];
};

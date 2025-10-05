export const _config = function () {


  return {
    rootDir: import.meta.dirname.split('/output/')[0],
    env: jsonConfig.env || 'dev',
  };
};
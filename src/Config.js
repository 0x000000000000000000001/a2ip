export const _config = function () {

  
  return {
    rootDir: import.meta.dirname.split('/output/')[0],
    env: typeof process !== 'undefined' && process.env && process.env.ENV ? process.env.ENV : 'dev'
  };
};
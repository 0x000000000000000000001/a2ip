export const setInterval = function(ms) {
  return function(fn) {
    return function() {
      const id = global.setInterval(fn, ms);
      if (id.ref) {
        id.ref();
      }
      return id;
    };
  };
};

export const clearInterval = function(id) {
  return function() {
    if (id.unref) {
      id.unref();
    }
    global.clearInterval(id);
  };
};
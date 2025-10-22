export const _setInLocalStorage = (key) => (value) => () => {
  try {
    localStorage.setItem(key, value);
  } catch (e) {
    console.error('localStorage.setItem failed:', e);
  }
};

export const _getInLocalStorage = (key) => () => {
  try {
    return localStorage.getItem(key);
  } catch (e) {
    console.error('localStorage.getItem failed:', e);
    return null;
  }
};

export const dispatchPopStateEvent = () => {
  window.dispatchEvent(new PopStateEvent('popstate', { state: {} }));
};

export const flushStreamImpl = (stream) => () => {
  if (stream && typeof stream.flush === 'function') {
    stream.flush();
  }
};

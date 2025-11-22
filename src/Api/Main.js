export const flushStreamImpl = (stream) => () => {
  // Force flush by using cork/uncork
  if (stream.uncork) {
    stream.uncork();
  }
  // Also try the direct flush if available
  if (stream.flush) {
    stream.flush();
  }
};

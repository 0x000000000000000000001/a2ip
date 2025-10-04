export const writeStdout = (str) => () => {
  process.stdout.write(str);
};

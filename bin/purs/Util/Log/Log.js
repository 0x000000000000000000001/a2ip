export const _write = (str) => () => {
  console.log(123);
  process.stdout.write(str);
};

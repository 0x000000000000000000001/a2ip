import http from 'node:http';

export const createHttpServer = (handler) => () => {
  return http.createServer((req, res) => {
    handler(req)(res)();
  });
};

export const listenOn = (server) => (port) => (callback) => () => {
  server.listen(port, () => {
    callback();
  });
};

export const getUrl = (req) => req.url || '/';

export const getMethod = (req) => req.method || 'GET';

export const sendResponse = (res) => (statusCode) => (body) => () => {
  res.statusCode = statusCode;
  res.setHeader('Content-Type', 'text/plain');
  res.end(body);
};

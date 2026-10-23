import http from 'node:http';

const port = Number(process.env.PORT || 8080);

export const handler = (req, res) => {
  if (req.url === '/health') {
    res.writeHead(200, { 'content-type': 'application/json' });
    return res.end(JSON.stringify({ status: 'ok' }));
  }
  res.writeHead(200, { 'content-type': 'text/plain' });
  res.end(`Hello from ${process.env.APP_ENV || 'local'}\n`);
};

if (process.argv[1] === new URL(import.meta.url).pathname) {
  http.createServer(handler).listen(port, () => console.log(`listening on ${port}`));
}

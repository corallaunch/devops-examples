import { test } from 'node:test';
import assert from 'node:assert/strict';
import http from 'node:http';
import { handler } from './server.js';

test('health check returns ok', async () => {
  const srv = http.createServer(handler).listen(0);
  const { port } = srv.address();
  const res = await fetch(`http://127.0.0.1:${port}/health`);
  assert.equal(res.status, 200);
  assert.deepEqual(await res.json(), { status: 'ok' });
  srv.close();
});

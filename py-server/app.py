#! /usr/bin/python3

from http.server import BaseHTTPRequestHandler, HTTPServer
import time
import json
import os

server_name = os.getenv('SERVER_NAME')
process_delay = os.getenv('DELAY')
static_resp = json.dumps({ "name": server_name })

class HttpHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        time.sleep(int(process_delay))
        self.send_response(200)
        self.end_headers()
        self.wfile.write(static_resp.encode('utf-8'))

if __name__ == "__main__":
    server = HTTPServer(('0.0.0.0', 8080), HttpHandler)
    print("started")
    server.serve_forever()

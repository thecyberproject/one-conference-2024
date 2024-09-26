# Fileserver

We use a simple Python3 HTTP server for serving static files like: logos, and the dummy malware.

How to spin?

```bash
python3 -m http.server 8082 --directory files/
....
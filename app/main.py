from flask import Flask, Response, jsonify

app = Flask(__name__)

HTML = """<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Maintenance</title>
  <style>
    body { font-family: Arial, sans-serif; background: #0f172a; color: #e2e8f0; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
    .card { background: #1e293b; padding: 32px 40px; border-radius: 12px; box-shadow: 0 20px 60px rgba(0,0,0,0.35); text-align: center; max-width: 420px; }
    .card h1 { margin: 0 0 12px; font-size: 26px; }
    .card p { margin: 0; color: #cbd5e1; }
  </style>
</head>
<body>
  <div class="card">
    <h1>We’ll be right back</h1>
    <p>This is a lightweight maintenance page served from the container.</p>
  </div>
</body>
</html>"""


@app.get("/")
def root():
    return Response(HTML, mimetype="text/html")


@app.get("/health")
def health():
    return jsonify(status="ok")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)


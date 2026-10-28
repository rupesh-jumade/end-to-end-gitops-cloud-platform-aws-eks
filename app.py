from pathlib import Path

from flask import Flask

app = Flask(__name__)
VERSION_FILE = Path(__file__).resolve().parent / "version.txt"


@app.route("/", methods=["GET"])
def home():
    return {
        "service": "end-to-end-gitops-cloud-platform",
        "message": "End-to-End GitOps Cloud Platform API",
    }


@app.route("/health", methods=["GET"])
def health():
    return {"status": "healthy"}


@app.route("/version", methods=["GET"])
def version():
    return {"version": VERSION_FILE.read_text().strip()}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

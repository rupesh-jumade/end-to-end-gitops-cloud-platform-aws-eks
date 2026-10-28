from app import app


def test_home():
    response = app.test_client().get("/")

    assert response.status_code == 200
    assert response.json["service"] == "end-to-end-gitops-cloud-platform"
    assert response.json["message"] == "End-to-End GitOps Cloud Platform API"


def test_health():
    response = app.test_client().get("/health")

    assert response.status_code == 200
    assert response.json == {"status": "healthy"}


def test_version():
    response = app.test_client().get("/version")

    assert response.status_code == 200
    assert response.json == {"version": "1.0.0"}

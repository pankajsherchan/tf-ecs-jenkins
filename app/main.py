from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {
        "message": "Hello from FastAPI on ECS",
        "status": "ok",
    }


@app.get("/health")
def health():
    return {
        "status": "healthy",
    }
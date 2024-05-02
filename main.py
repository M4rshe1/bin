from fastapi import FastAPI
from fastapi import Request
from hashlib import sha256
from dotenv import load_dotenv
import os
from starlette.responses import PlainTextResponse

load_dotenv()
app = FastAPI()

TOKEN = os.getenv("TOKEN")
print(TOKEN)


@app.get("/")
async def root(request: Request):
    # check if request has parameter file
    if 'token' not in request.query_params:
        return {"error": "token parameter is required"}

    if request.query_params['token'] != TOKEN:
        return {"error": "invalid token"}

    if "file" not in request.query_params:
        return {"error": "file parameter is required"}

    file = request.query_params["file"]
    filename = request.query_params["filename"]

    file_hash = sha256(file.encode()).hexdigest()[0:10].upper()

    os.makedirs("files", exist_ok=True)
    file_hash = f"{file_hash}-{filename}"
    with open(f"files/{file_hash}", "wb") as f:
        f.write(file.encode())

    protocol = request.url.scheme
    host = request.url.hostname
    port = request.url.port

    if port:
        host = f"{host}:{port}"

    return_link = f"{protocol}://{host}/{file_hash}"

    print(return_link)
    return return_link


@app.get("/rm/{fileid}")
async def remove_file(fileid: str, request: Request):
    if 'token' not in request.query_params:
        return {"error": "token parameter is required"}
    if request.query_params['token'] != TOKEN:
        return {"error": "invalid token"}

    if not os.path.exists(f"files/{fileid}"):
        if "-" not in fileid:
            files = os.listdir("files")
            for file in files:
                if file.startswith(fileid):
                    fileid = file
                    break
            else:
                return {"error": "file not found"}

    os.remove(f"files/{fileid}")
    return {"message": "file removed"}


@app.get("/{fileid}", response_class=PlainTextResponse)
async def read_item(fileid: str):
    # check if file exists
    if not os.path.exists(f"files/{fileid}"):
        if "-" not in fileid:
            files = os.listdir("files")
            for file in files:
                if file.startswith(fileid):
                    fileid = file
                    break
            else:
                return {"error": "file not found"}

    with open(f"files/{fileid}", "rb") as f:
        file = f.read()
    return file.decode()

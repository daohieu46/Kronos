import os
from flask import request, Response
from app import app

USER = os.environ.get("APP_USER", "admin")
PASS = os.environ.get("APP_PASSWORD")

@app.before_request
def require_login():
    if not PASS:
        return
    auth = request.authorization
    if not auth or auth.username != USER or auth.password != PASS:
        return Response("Login required", 401,
                        {"WWW-Authenticate": 'Basic realm="Kronos"'})

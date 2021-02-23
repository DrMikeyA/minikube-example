#!/usr/bin/env python
"""
Hello World flask app to be deployed in a load balanced Kubernetes cluster
"""

from flask import Flask

app = Flask(__name__)


@app.route("/helloworld")
def hello_world():
    """
    Says Hello World when invoked


    Attributes:

    Returns:
        str: response string
    """

    return "Hello World!"


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5010)

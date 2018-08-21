virtualenv -p /usr/bin/python ./venv && \
    source ./venv/bin/activate && \
    pip install -U -r requirements.txt && \
    deactivate
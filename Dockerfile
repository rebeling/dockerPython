#FROM jfloff/alpine-python:2.7-slim
FROM frolvlad/alpine-python2
#FROM python:2.7-alpine

# % docker build . -t $FROM
# REPOSITORY                TAG         IMAGE ID         SIZE
# jfloff/alpine-python      2.7-slim    2fdf75a75b64     58.4MB
# frolvlad/alpine-python2   latest      5d0cb4e83b2f     56MB
# python                    2.7-alpine  c8779bc5246f     75.4MB

# --squash has no effect so far

WORKDIR /opt/app
COPY requirements.txt requirements.txt

RUN apk add --no-cache --virtual .build-deps \
    build-base libffi-dev \
    && pip install -r requirements.txt \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
                | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                | sort -u \
                | xargs -r apk info --installed \
                | sort -u \
    )" \
    && apk add --virtual .rundeps $runDeps \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

# Bundle app source
COPY app.py /src/app.py

EXPOSE  5000
CMD ["python", "/src/app.py", "-p 5000"]

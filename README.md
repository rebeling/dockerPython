Docker python flask microcontainer
===================================

Build the container with the smallest python image out there.

    % docker build . -t flask-app
    % docker images
    % docker run -d -p 5000:5000 flask-app
    % docker ps -a

Cheched some images for final size after build and using frolvlad/alpine-python2.

    # % docker build . -t $REPO
    # REPOSITORY                TAG         IMAGE ID         SIZE
    # jfloff/alpine-python      2.7-slim    2fdf75a75b64     58.4MB
    # frolvlad/alpine-python2   latest      5d0cb4e83b2f     56MB
    # python                    2.7-alpine  c8779bc5246f     75.4MB

    # --squash has no effect so far

If you know a python image with smaller footprint - please let me know. Thanks.

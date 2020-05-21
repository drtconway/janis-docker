# janis-docker
A docker build environment for janis

To use, run something like:
```
$ docker build -t janis-build .
$ docker run -it -v ${PWD}/janis:/janis/:rw janis-build bash
root@11fc8c89ee0f:/# ./clone-janis.sh
...
...
...

root@11fc8c89ee0f:/# ./build-janis.sh
...
...
...
root@11fc8c89ee0f:/# janis --version
--------------------  -------
janis-core            v0.9.16
janis-assistant       v0.9.16
janis-unix            v0.9.0
janis-bioinformatics  v0.9.12
janis-pipelines       v0.9.5
janis-templates       v0.9.5
--------------------  -------
root@11fc8c89ee0f:/# 
```

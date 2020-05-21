# janis-docker
A docker build environment for janis

To use, run something like:
```
$ docker build -t janis-build .
$ docker run -it -v ${PWD}/janis:/janis/:rw -v ${PWD}/singularity:/singularity/:rw --privileged janis-build bash
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
root@11fc8c89ee0f:/# janis init singularity --container_dir /singularity
root@11fc8c89ee0f:/# janis run -o hello-out hello
2020-05-21T08:11:14 [INFO]: Starting task with id = 'd889c3'
d889c3
2020-05-21T08:11:14 [INFO]: Exporting tool files to '/hello-out/janis/workflow/original'
2020-05-21T08:11:14 [INFO]: Zipping tools
2020-05-21T08:11:14 [INFO]: Zipped tools
2020-05-21T08:11:14 [INFO]: Saved workflow with id 'hello' to '/hello-out/janis/workflow'
2020-05-21T08:11:14 [INFO]: Exporting tool files to '/hello-out/janis/workflow'
2020-05-21T08:11:14 [INFO]: Zipping tools
2020-05-21T08:11:14 [INFO]: Zipped tools
2020-05-21T08:11:14 [INFO]: Status changed to: Queued
2020-05-21T08:11:15 [INFO]: Couldn't find cromwell at any of the usual spots, downloading 'cromwell-50.jar' now
100% (203132275 of 203132275) |##########################################################| Elapsed Time: 0:00:53 Time:  0:00:53
2020-05-21T08:12:10 [INFO]: Downloaded cromwell-50.jar
2020-05-21T08:12:10 [INFO]: Starting cromwell (cromwell-50.jar)...
2020-05-21T08:12:10 [INFO]: Cromwell is starting with pid=77
2020-05-21T08:12:10 [INFO]: Will log to file
2020-05-21T08:13:38 [INFO]: Service successfully started with pid=77
2020-05-21T08:13:39 [INFO]: Submitted workflow (d889c3), got engine id = '101af474-62c8-4d4c-a44d-587e4dc3aaea'
2020-05-21T08:13:51 [INFO]: Status changed to: Running
2020-05-21T08:14:03 [INFO]: Status changed to: Completed
2020-05-21T08:14:03 [INFO]: Task has finished with status: Completed
2020-05-21T08:14:03 [INFO]: Hard linking /hello-out/janis/execution/hello/101af474-62c8-4d4c-a44d-587e4dc3aaea/call-hello/execution/stdout → /hello-out/janis/logs/hello_stdout
2020-05-21T08:14:03 [INFO]: Hard linking /hello-out/janis/execution/hello/101af474-62c8-4d4c-a44d-587e4dc3aaea/call-hello/execution/stderr → /hello-out/janis/logs/hello_stderr
2020-05-21T08:14:03 [INFO]: Hard linking /hello-out/janis/execution/hello/101af474-62c8-4d4c-a44d-587e4dc3aaea/call-hello/execution/stdout → /hello-out/out
2020-05-21T08:14:03 [INFO]: View the task outputs: file:///hello-out
2020-05-21T08:14:03 [INFO]: Cleaning up execution directory
2020-05-21T08:14:03 [INFO]: Removing local directory '/hello-out/janis/execution'
2020-05-21T08:14:03 [INFO]: Stopping cromwell
2020-05-21T08:14:03 [INFO]: Stopped cromwell
2020-05-21T08:14:03 [INFO]: Finished managing task 'd889c3'.
2020-05-21T08:14:03 [INFO]: Exiting
root@11fc8c89ee0f:/# cat hello-out/out 
Hello, world!
root@11fc8c89ee0f:/# 
```

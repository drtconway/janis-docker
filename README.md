# janis-docker
A dockerization of the [janis workflow system](https://janis.readthedocs.io/en/latest/index.html).

The simplest invocation is
```
$ docker run -it --privileged drtomc/janis:latest janis run -o hello hello
2020-05-27T06:24:45 [INFO]: Starting task with id = 'aec533'
aec533
2020-05-27T06:24:45 [INFO]: Exporting tool files to '/hello/janis/workflow/original'
2020-05-27T06:24:45 [INFO]: Zipping tools
2020-05-27T06:24:45 [INFO]: Zipped tools
2020-05-27T06:24:45 [INFO]: Saved workflow with id 'hello' to '/hello/janis/workflow'
2020-05-27T06:24:45 [INFO]: Exporting tool files to '/hello/janis/workflow'
2020-05-27T06:24:45 [INFO]: Zipping tools
2020-05-27T06:24:45 [INFO]: Zipped tools
2020-05-27T06:24:45 [INFO]: Status changed to: Queued
2020-05-27T06:24:45 [INFO]: Couldn't find cromwell at any of the usual spots, downloading 'cromwell-50.jar' now
100% (203132275 of 203132275) |########################################################################################################| Elapsed Time: 0:00:45 Time:  0:00:45
2020-05-27T06:25:32 [INFO]: Downloaded cromwell-50.jar
2020-05-27T06:25:32 [INFO]: Starting cromwell (cromwell-50.jar)...
2020-05-27T06:25:32 [INFO]: Cromwell is starting with pid=19
2020-05-27T06:25:32 [INFO]: Will log to file
2020-05-27T06:27:01 [INFO]: Service successfully started with pid=19
2020-05-27T06:27:01 [INFO]: Submitted workflow (aec533), got engine id = '431f95f2-b6da-42e7-ba59-2dde7ba11237'
2020-05-27T06:27:13 [INFO]: Status changed to: Running
2020-05-27T06:27:49 [INFO]: Status changed to: Completed
2020-05-27T06:27:49 [INFO]: Task has finished with status: Completed
2020-05-27T06:27:49 [INFO]: Hard linking /hello/janis/execution/hello/431f95f2-b6da-42e7-ba59-2dde7ba11237/call-hello/execution/stdout → /hello/janis/logs/hello_stdout
2020-05-27T06:27:49 [INFO]: Hard linking /hello/janis/execution/hello/431f95f2-b6da-42e7-ba59-2dde7ba11237/call-hello/execution/stderr → /hello/janis/logs/hello_stderr
2020-05-27T06:27:49 [INFO]: Hard linking /hello/janis/execution/hello/431f95f2-b6da-42e7-ba59-2dde7ba11237/call-hello/execution/stdout → /hello/out
2020-05-27T06:27:49 [INFO]: View the task outputs: file:///hello
2020-05-27T06:27:49 [INFO]: Cleaning up execution directory
2020-05-27T06:27:49 [INFO]: Removing local directory '/hello/janis/execution'
2020-05-27T06:27:49 [INFO]: Stopping cromwell
2020-05-27T06:27:49 [INFO]: Stopped cromwell
2020-05-27T06:27:49 [INFO]: Finished managing task 'aec533'.
2020-05-27T06:27:49 [INFO]: Exiting
$ 
```

However, it is more efficient if you mount the directory `/singularity`
which is where the images used by the workflow get stored, so they are
cached across invocations.

```
$ docker run -it -v ${PWD}/singularity:/singularity/:rw --privileged drtomc/janis:latest janis run -o hello hello
```

To run something more complicated than a hello world workflow, you
will also need to mount directories for data, and possibly your own
janis workflow.

```
$ docker run -it \
    -v ${PWD}/data:/data/:ro \
    -v ${PWD}/results:/results/:rw \
    -v ${PWD}/singularity:/singularity/:rw \
    --privileged drtomc/janis:latest janis run -o results WGSGermlineGATK --inputs data/inputs.yaml
```

## Caveats

If you are running docker on Windows, or inside a virtual machine in a
folder shared with a Windows host you may experience failures. The engine
underneath may attempt to perform some filesystem operations that are
not supported on Windows filesystems (e.g. `mkfifo`). In such cases,
it is recommended to make sure any writable volumes are on fully unix
compatible filesystems.

One way of doing this is to run bash in the container, and run the
workflow using a container-local directory as the output directory,
then copy the outputs across:

```
$ docker run -it \
    -v ${PWD}/data:/data/:ro \
    -v ${PWD}/results:/results/:rw \
    -v ${PWD}/singularity:/singularity/:rw \
    --privileged drtomc/janis:latest bash
root@339b601f4ec7:/# janis run -o local-results WGSGermlineGATK --inputs data/inputs.yaml
...
root@339b601f4ec7:/# cp -r local-results/ results/
```

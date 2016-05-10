# Goal

Main interests of this recipe is to managed video and usb needed to play with android Studio.
The only element known by host is a docker image (for software) and  a docker volume (for configuration, android sdk...).

## Build

To build image, simply launch :
```
docker build -t androidstudio .
```

## Command to create volume named game-data :
```bash
docker create -v /home/developer/.AndroidStudio2.1 -v /home/developer/.android --name androidstudio-data ubuntu:xenial /bin/true
```

folder .AndroidStudio2.1 is managed by android Studio (to keep your preferences)

folder .android will contains all deps that android sdk and tools has to have (downloading during first launch of android studio)


## Run

To launch docker container, a bash alias file is certainly the good option :

```bash
docker_localtime=" -v /etc/localtime:/etc/localtime "
docker_x=" -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/home/developer/.Xauthority --net=host "
docker_me=" -e UID=`id -u` -e GID=`id -g`"

function dandroidstudio {
    docker run --name androidstudio $docker_x --device /dev/bus/usb  --volumes-from androidstudio-data -v /home/yourlogin/workspaces:/home/developer/workspaces $docker_me  $docker_localtime --rm -ti  androidstudio "$@"
}
```

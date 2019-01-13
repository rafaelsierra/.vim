# VIM inside Docker

## Why?

I have a bunch of different computers which I use to do stuff, including Raspbian, Ubuntu in a
couple different versions and MacOS, which means I have to setup and keep updated every single
computer, which is a pain in the ass given each computer has a different Python/Go/Rust version
installed

## How?

1. Build the docker image:
   1. `docker build -t vim --build-arg USER=$(whoami) --build-arg UID=$(id -u) .`
   
1. Start the server:
   * `./start.sh`
   * Enter a password for the private key (optional but recommended)
   * Save the given key at `~/.ssh/id_rsa-vim` and change its permission to `400`
   
1. Make a link from `vim.sh` somewhere into your `$PATH` with whatever name you want (I use vimd)
1. Call `vim.sh <filename>`
   * You can only call `vim.sh` with a filename or without anything. No other `vim` argument is
  supported

## Behind the scenes

My goal is to be able to use docker directly and start vim inside it to edit file, unfortunetally
this is not possible at the moment due to some issue between [vim and docker](https://stackoverflow.com/questions/54148172/vim-inside-a-docker-container-does-not-update-screen-correctly).

In order to be able to use vim, the `start.sh` script will start an `ssh` server that `vim.sh` will
use to connect and open a proper vim instance.

During the build steps an standard user will be created with username and UID as set by
`--build-arg` making it possible to edit whatever file you already have permission to.

**The whole root folder will be mounted as volume inside /host** making it possible to edit all
files. Be constantly aware of that.

The port `60022` is exposed over `127.0.0.1` (meaning no access to other computers on the same
networkd)

Access to the ssh server is only possible via the previously provided key. If you want to use a
key other than the provided, use `docker cp` to copy your public key into
`/home/$USER/.ssh/authorized_keys`

## Saving state

Everytime you call `./start.sh` a new private key will be created and you have to save at
`~/.ssh/id_rsa-vim`.

To avoid that, you can create a snapshot from the running container and use `./resume.sh` to
start a new container with the same key as before.

```
$ docker container ls |grep vim
e25469a6d67a        vim:snapshot        "/usr/sbin/sshd -D"   3 minutes ago       Up 3 minutes        127.0.0.1:60022->22/tcp   distracted_bohr
$ docker commit e25469a6d67a vim:snapshot
```

## Issues

* At the moment, `Shift+Up/Down` does not jump 5 lines
* `Command+C` will not copy selected text on Mac
* Calling `./vim.sh new-file` will not imply that you are creating a new file
* Your user has sudo powers inside the container
  * And all your host files are exposed inside it
  * And you might not have entered a password for the private key


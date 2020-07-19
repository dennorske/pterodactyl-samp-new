# SAMPCTL support for pterodactyl
![](https://img.shields.io/badge/SA--MP-with%20sampctl-lightgrey)

![](https://i.imgur.com/i6pUA1Q.png)

This image is developed and tested to run sampctl on your pterodactyl instance.

## Requirements
- Pterodactyl panel set up and configured, and you need to be admin on the panel.
- Docker-ce and Docker-ce-cli version 19.03.11 and upwards. (We had issues with 100% cpu usages on lower versions)

## How to install?
This requires that you have the SA-MP nest installed on your instance. If not, you can create a new nest on your own.

1. Import the `egg-sampctl.json` file to your pterodactyl instance. You can do this under: `Admin > Nests > Import Egg`
2. Make a new server, and select the sampctl egg you just imported. On the very bottom of the "create new server" dialog, you will see two variables you need to define. Please define the git path for the server you are going to run.

## How does it work? 
The docker image made for this egg runs the following commands when a server is started:
```
## This clones the repo you defined in the variables when creating the server. 
## The server owner can also modify these
sampctl p get ${gituser}/${gitrepo} 

## Then, we check if the repo was moved into it's own folder, if yes we enter the folder:
[ -d "sampctl-package" ] && cd sampctl-package; 

## If there are any updates on the source repo, pull these
sampctl p ensure --update; 

## Build the binary (amx) with sampctl
sampctl p build; 

## Run the server
sampctl p run
```

## Notes
When you install the server, and it starts after installation - the script defined in the egg will be launched. This you can find under the egg settings, under "Install script"

The image has been tested on
- Debian 9
- Debian 10
- Ubuntu 16.04
- Ubuntu 18.04
- Ubuntu 20.04

## How to contribute?
Please fork the repository and modify the sampctl branch. When done, create a pull request.

## Credits and relevant links
SAMPCTL made by Southclaws: https://github.com/Southclaws/sampctl
Pterodactyl documentation: https://pterodactyl.io/community/config/eggs/creating_a_custom_image.html
Normal SA-MP egg for pterodactyl: https://github.com/parkervcp/eggs/blob/5068f366a83cc234c0b6527d5b489b3ddd881fca/gta/samp/egg-s-a--m-p.json

## Can i run this container outside of pterodactyl?
You can! Make sure you have the newest docker version, and you can override the entrypoint by issuing bash commands to it. Remember to run as "container":
```
sudo docker run -it --rm -u container dennorske/pterodactyl-samp-new:sampctl /bin/bash -c \
   "sampctl p get dennorske/sampctl-package; \
   [ -d "sampctl-package" ] && cd sampctl-package; \
   sampctl p ensure --update; \
   sampctl p build; \
   sampctl p run"
```

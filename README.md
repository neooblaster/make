# Makefile - Interface for common Docker commands

An easy way to produce simple commands to exploit Docker in your projects.


## Make commands

````

-----------------------------------------------------------------------------
                 Make Interface for common Docker commands
-----------------------------------------------------------------------------
   Author  : Nicolas DUPRE
   Version : 0.5.0
   Release : 23.03.2018

------------------------------[ Commandes ]----------------------------------
   Liste des commandes :  make <cmd>

   build     : (Re)builds services.
   env       : Displays environment informations regarding the virtual
               machine install by docker-toolbox.
   help      : Displays this manual.
   install   : Starts the project development environment.
   ls        : Displays the list of active containers.
   lsa       : Displays all containers available.
   reset     : Resets the whole project.
   shutdown  : Stops Docker's virtual machine under Oracle VM VirtualBox.
   ssh       : Opens an SSH connection to Docker's Virutal Machine under
               Oracle VM VirtualBox.
   start     : Builds the services, make and start the containers from
               docker-compose.yml file.
   stop      : Stops all the containers.
   up        : Make and start the containers.

------------------------------[ Services ]-----------------------------------
   Commands to manipulate services :
      make service <cmd>=<svc-name>
      make svc     <cmd>=<svc-name>

   List of commands <cmd> :
      create : Make the specified service.
      start  : Starts the specified service with pseudo-TTy.
      stop   : Stops the specified service.
      attach : Open a TTy on specified service.

   Liste des service <svc-name> : -- customisable --
      dockerSvc  : Container dockerSvc

-----------------------------------------------------------------------------

````
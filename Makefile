##-----------------------------------------------------------------------------
##                 Make Interface for common Docker commands
##-----------------------------------------------------------------------------
##   Author  : Nicolas DUPRE
##   Version : 0.5.0
##   Release : 23.03.2018
##
.PHONY: build clear env help install ls lsa ready reset shutdown start stop up service ssh org-ws-core
.DEFAULT_GOAL := help

DK=docker
DKC=docker-compose
DKM=docker-machine

CERR="196"
CINF="39"
CWARN="214"
CNOT="247"
CSUC="76"
CKWD="198"
CINP=$CKWD

DETACH="ctrl+q ctrl+d to detach."
WAITSEC="Wait a few secondes..."
UNKNOW="No command specified or unknown."





##------------------------------[ Commandes ]----------------------------------
##   Liste des commandes :  make <cmd>
##
##   build     : (Re)builds services.
##   env       : Displays environment informations regarding the virtual
##               machine install by docker-toolbox.
##   help      : Displays this manual.
##   install   : Starts the project development environment.
##   ls        : Displays the list of active containers.
##   lsa       : Displays all containers available.
##   reset     : Resets the whole project.
##   shutdown  : Stops Docker's virtual machine under Oracle VM VirtualBox.
##   ssh       : Opens an SSH connection to Docker's Virutal Machine under
##               Oracle VM VirtualBox.
##   start     : Builds the services, make and start the containers from
##               docker-compose.yml file.
##   stop      : Stops all the containers.
##   up        : Make and start the containers.
##


build:
ifdef nocache
	@$(DKC) build --no-cache
else
	@$(DKC) build
endif


clear:
	@$(DK) rm -f $$($(DK) ps -a -q)


env:
	@$(DKM) env


help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'


install:
ifdef nocache
	@$(MAKE) --no-print-directory reset nocache=1
else
	@$(MAKE) --no-print-directory reset
endif
ifdef log
	@$(MAKE) --no-print-directory log
endif


log:
	@echo -e "\e[38;5;${CWARN}m!!! Becareful, some Shell can not interrupt the log watching with ctrl+c !!!\e[0m"
	touch site/var/log/docker.log
	tail -f site/var/log/docker.log

ls:
	@$(DK) ps


lsa:
	@$(DK) ps -a


ready:
	@echo -e "\e[38;5;${CSUC}m--> You can now use the make command.\e[0m"
	@echo -e "\e[38;5;${CINF}m--> Below an example with command 'make ls'.\e[0m"
	@$(DK) ps --all


reset:
	@$(MAKE) --no-print-directory stop
ifdef nocache
	@$(MAKE) --no-print-directory start nocache=1
else
	@$(MAKE) --no-print-directory start
endif
	@$(MAKE) --no-print-directory ls


shutdown:
	@$(DKM) stop default


start:
ifdef nocache
	@$(MAKE) --no-print-directory build nocache=1
else
	@$(MAKE) --no-print-directory build
endif
	@$(MAKE) --no-print-directory up


ssh:
	@echo -e "\e[38;5;${CSUC}mType 'exit' to leave the V.M.\e[0m"
	$(DKM) ssh default


stop:
	@$(DKC) kill || echo -e "\e[38;5;${CERR}mTry 'source startDockerForWin7.sh'\e[0m"
	@$(DKC) rm -v --force


up:
	@$(DKC) up -d



##------------------------------[ Services ]-----------------------------------
##   Commands to manipulate services :
##      make service <cmd>=<svc-name>
##      make svc     <cmd>=<svc-name>
##
##   List of commands <cmd> :
##      create : Make the specified service.
##      start  : Starts the specified service with pseudo-TTy.
##      stop   : Stops the specified service.
##      attach : Open a TTy on specified service.
##
##   Liste des service <svc-name> : -- customisable --
##      dockerSvc  : Container dockerSvc
##

svc: service
service:
ifdef create
	@$(DK) run --name $(create) $(create) bash&
	@sleep 0.5
	@$(DK) ps
else ifdef start
	@echo $(DETACH)
	@$(DK) start $(start)
	@$(DK) exec -ti $(start) bash
else ifdef stop
	@echo $(WAITSEC)
	@$(DK) stop $(stop)
	@$(DK) ps
else ifdef attach
	@echo $(DETACH)
	@$(DK) exec -ti $(attach) bash
else
	@echo $(UNKNOW)
endif


dockerSvc:
	@$(MAKE) --no-print-directory svc attach=dockerSvc


##-----------------------------------------------------------------------------

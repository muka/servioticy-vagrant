servioticy-vagrant
==================

Puppet is used to setup and launch all the needed components to run the servioticy API


##Requirements
* Vagrant 1.6 or newwer is necessary (see vagrantup.com for more information)

##Running  the instance

Now we are ready to run

`vagrant up`

If you want to update the components again, you can always run:

`vagrant up --provision`


You can then login into the instance running:

`vagrant ssh`

Now you can start or stop the servioticy services by running:

`start-servioticy` and `stop-servioticy`

or alternatively

`sudo servioticy start`

`sudo servioticy stop`

`sudo servioticy restart`


##Running on a standalone dev server

Install the software components on a machine not managed by vagrant.

It will create a user `servioticy` and install all the required packages in `/opt/servioticy`

Clone this repository in the machine to setup and run `sudo ./scripts/puppet-standalone.sh`

** Backup your system before proceeding as some operation may result in data loss **

##Notes

- The provision script handles either the configuration of the services, so use
`vagrant up --provision` when starting the VM.

- If you use Windows as your host system, note that you may encounter issues with the End-of-Line codification (CRLF in Windows vs LF in Unix/OSX). To avoid problems, use the following command in your git configuration (assuming you are not a developer committing code) before cloning this repository
`git config --global core.autocrlf false`


##Credits

This Vagrant box is a complete refactor of an initial version developed by Luca Capra at CREATE-NET.

#License

Apache2

Copyright 2014 Barcelona Supercomputing Center - Centro Nacional de Supercomputación (BSC-CNS)
Developed for COMPOSE project (compose-project.eu)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

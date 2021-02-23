Hello World minikube tech test
==============================

Makefile Macros
---------------

The Makefile is self documenting so just rung `make` and it will provide the list of available macros

`make ci`                             unit tests and coverage report in one
`make clean`                          clean everything up
`make clean-k8s-service`              clean the minikube resources
`make container-test`                 build and test the docker image locally
`make coverage`                       generate a coverage report for the unit tests
`make deploy-k8s-service`             deploy out all the minikube resources
`make docker-image`                   Build a local version of the docker image for testing
`make docker-k8s-image`               Build the k8s image in the minikube docker space so can be referenced in the pod deployment
`make docker-stop`                    stop any running docker images from this build and remove ready for rebuild
`make requirements`                   Install python dependencies
`make unittest`                      run the unit tests for the app
`make virtual-env`                   Creates a virtual environment for the python dependencies

Folder Structure
----------------

``` text
.
├── app
│   ├── docs
│   │   ├── api-specification
│   │   └── source
│   │       ├── _static
│   │       └── _templates
│   ├── src
│   └── test
├── config
│   ├── apache
│   └── wsgi
└── ops
    ├── docker
    │   └── hello-world
    └── kubernetes

```


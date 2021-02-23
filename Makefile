#
# Makefile
#
.EXPORT_ALL_VARIABLES:

#set default ENV based on your username and hostname
APP_DIR=app
TEST_DIR=$(APP_DIR)/test
SRC_DIR=$(APP_DIR)/src
DOCS_DIR=$(APP_DIR)/docs
VENV=hello-world-venv
PROGRAM=run.py
TOUCH_FILES=requirements 
TEMP_FOLDERS=coverage_html_report $(VENV) $(DOCS_DIR)/build

virtual-env:
	@echo "=========> Creating local python venv"
	python3 -m venv $(VENV)/

requirements: virtual-env
	@echo "=========> Installing Requirements within the created virtual environment"
	( \
		source $(VENV)/bin/activate; \
		pip install -r $(APP_DIR)/requirements.txt; \
		pip install -r $(APP_DIR)/test-requirements.txt; \
    )
	touch $@

unittest: virtual-env requirements
	@echo "=========> Running Unit Tests"
	( \
		source $(VENV)/bin/activate; \
		PYTHONPATH=$(APP_DIR):$(PYTHONPATH) pytest $(TEST_NAME) ; \
	)

coverage: virtual-env requirements
	@echo "=========> Running Coverage Report"
	( \
		source $(VENV)/bin/activate; \
		PYTHONPATH=$(APP_DIR):$(PYTHONPATH) pytest --cov-report term-missing --cov=src $(TEST_DIR); \
	)

ci: unittest coverage

docker-image:
	docker build -f ops/docker/helloworld/Dockerfile -t hello-world .

docker-stop:
	docker stop hello-world-test || true
	docker rm hello-world-test || true

container-test: docker-image docker-stop
	docker run -d --name hello-world-test -p 5010:5010 hello-world
	curl -s  http://localhost:5010/helloworld | grep -q 'Hello World' && echo -e "\033[0;32m**** Container Test Passed ****\033[0m" || echo -e "\033[0;31m**** Container Test Failed ****\033[0m"

	docker stop hello-world-test
	docker rm hello-world-test

docker-k8s-image:
	eval $$(minikube docker-env) && \
	docker ps && \
	docker build -f ops/docker/hello-world/Dockerfile -t hello-world-test . && \
	docker ps 

deploy-k8s-serice: docker-k8s-image
	kubectl apply -f ops/kubernetes/hello-world-deployment.yml
	kubectl apply -f ops/kubernetes/hello-world-service.yaml
	kubectl apply -f ops/kubernetes/hello-world-ingress.yaml
	minikube ip
	$(eval IP=$(shell minikube ip))
	curl -s -I -H "Host: hello.world" http://$(IP)/helloworld | grep "200 OK" && echo -e "\033[0;32m**** K8s deploy Success ****\033[0m" || echo -e "\033[0;31m**** K8s Service deploy Failed ****\033[0m" 

clean-k8s-service:
	kubectl delete -f ops/kubernetes/hello-world-deployment.yml || true
	kubectl delete -f ops/kubernetes/hello-world-service.yaml || true
	kubectl delete -f ops/kubernetes/hello-world-ingress.yaml || true

clean: clean-k8s-service docker-stop
	-rm $(TOUCH_FILES)
	-rm -Rf $(TEMP_FOLDERS)
	docker rmi hello-world-test || true


.PHONY: clean unittest coverage 

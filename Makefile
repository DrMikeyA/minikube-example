#
# Makefile
#
.EXPORT_ALL_VARIABLES:

#set default ENV based on your username and hostname
APP_DIR=app
TEST_DIR=$(APP_DIR)/test
SRC_DIR=$(APP_DIR)/src
PROGRAM=entrypoint.py
TOUCH_FILES=requirements 

requirements: 
	@echo "=========> Installing Requirements"
	pip install -r $(APP_DIR)/requirements.txt
	pip install -r $(APP_DIR)/test-requirements.txt
	touch $@

unittest: requirements
	@echo "=========> Running Unit Tests"
	PYTHONPATH=$(APP_DIR):$(PYTHONPATH) pytest $(TEST_NAME)

coverage: requirements
	@echo "=========> Running Coverage Report"
	PYTHONPATH=$(APP_DIR):$(PYTHONPATH) pytest --cov-report term-missing --cov=src $(TEST_DIR)

ci: unittest coverage

clean:
	-rm $(TOUCH_FILES)


.PHONY: clean unittest coverage 

#include ../public/Makefile.def
MODULE_NAME = test_folly 

BINDIR=./output
TARGET=test/test_folly
BASE=base

INC=-I$(INCLUDE_PATH) -I./
LIB=-lrt -lcrypto -ldl -lz  -lboost_thread -lboost_regex -lboost_system -lpthread -L/usr/local/lib -lfollyinit -lfolly -lfollysymbolizer -lfollybenchmark -lglog

#DC=g++ -g -Wall -DBUILD_TIME="$(BUILD_TIME)"  -DPROJECT_VERSION="$(PROJECT_BUILD_VERSION)" -DMODULE_VERSION="$(MODULE_BUILD_VERSION)" -DTAG_VERSION="$(TAG_LAST)" -o $@ -c $<
#DT=g++ -g -Wall -DBUILD_TIME="$(BUILD_TIME)"  -DPROJECT_VERSION="$(PROJECT_BUILD_VERSION)" -DMODULE_VERSION="$(MODULE_BUILD_VERSION)" -DTAG_VERSION="$(TAG_LAST)" -o $@ $^

DC=g++ -std=c++1y -g -Wall -o $@ -c $<
DT=g++ -std=c++1y -g -Wall -o $@ $^

release:clrtarget $(TARGET) 
	cp test/test_folly $(BINDIR)

clrtarget:
	-@rm -rf $(TARGET)

OBJS_TEST_FOLLY = test/test_folly.o 
test/test_folly:$(OBJS_TEST_FOLLY) 
	$(DT) $(LIB) 
	@echo ""

%.o:%.cpp 
	$(DC) $(INC)

%.o:%.cc 
	$(DC) $(INC)

%.o:%.c 
	$(DC) $(INC)

%.o:%.cpp %.h
	$(DC) $(INC)

%.o:%.cc %.h
	$(DC) $(INC)

%.o:%.c %.h
	$(DC) $(INC)

clean: dir
	@for d in $(BASE) ; do \
	make clean -C $$d ; \
	echo "" ;\
	done
	-@rm -rf $(INCLUDE_PATH)/*.h
	-@rm -rf  *.o
	-@rm -rf  test/*.o
	-@rm -rf $(TARGET)
	-@rm -rf output/*



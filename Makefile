GOARGS=-a -installsuffix cgo -x
GOENV=CGO_ENABLED=0
BINDIR=/usr/local/sbin
EXECUTABLE=project-creator
CONTAINER_TAG=quay.io/financialtimes/project-creator:latest

all: main

main:
	$(GOENV) go build $(GOARGS)

install: all
	install -d $(BINDIR)
	install -s -m 0750 -o $(USER) project-creator $(BINDIR)/$(EXECUTABLE)

build: all
	docker build -t $(CONTAINER_TAG) .

push:
	docker push $(CONTAINER_TAG)

uninstall:
	rm -rfv $(CONF)
	rm -v $(BINDIR)/$(EXECUTABLE)

clean:
	-rm -v $(EXECUTABLE)

strip:
	strip -v $(EXECUTABLE)

dist: clean main strip build push

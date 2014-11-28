SUBDIRS = apache_container chado_create_container demo_container generic_chado_create_container generic_chado_db_reload_container generic_db_container worker_container worker_ftp_container

define MESSAGE
***** TBro Docker Installation *****

Here comes the message how to build all TBro docker containers
endef

export MESSAGE

none:
	@echo  "$$MESSAGE"

SUBDIRS_PREPARE=$(patsubst %,%.prepare,$(SUBDIRS))
SUBDIRS_BUILD=$(patsubst %,%.start,$(SUBDIRS))
SUBDIRS_START=$(patsubst %,%.start,$(SUBDIRS))
SUBDIRS_STOP=$(patsubst %,%.stop,$(SUBDIRS))
SUBDIRS_RM=$(patsubst %,%.rm,$(SUBDIRS))
SUBDIRS_RMI=$(patsubst %,%.rmi,$(SUBDIRS))

.PHONY: $(SUBDIRS_PREPARE)
$(SUBDIRS_PREPARE):
	make -C $(@:.prepare=) prepare

.PHONY: $(SUBDIRS_BUILD)
$(SUBDIRS_BUILD):
	make -C $(@:.build=) build

.PHONY: prepare
prepare: $(SUBDIRS_PREPARE)


.PHONY: build
build: $(SUBDIRS_BUILD)

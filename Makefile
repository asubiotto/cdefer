# whre test course code is
TSTDIR = tests
# where target object files go
OBJDIR = obj
# where target executables (tests) go
BINDIR = bin
# where installation stuff goes
LIBDIR = lib
# target directories
DIRS = $(OBJDIR) $(BINDIR) $(LIBDIR)

NAME   = cdefer
LIB    = lib$(NAME)
USRLIB = /usr/local/lib
USRINC = /usr/local/include

# names of source files
SRC = $(notdir $(wildcard *.c))
ofiles = $(patsubst %.c, %.o, $(SRC))
# paths of target object files
OBJ = $(addprefix $(OBJDIR)/, $(ofiles))
# paths to target library files
LAO = $(addprefix $(LIBDIR)/, $(ofiles))
# paths of test files
TST = $(wildcard $(TSTDIR)/*.c)
# pats of target executables (tests)
BIN = $(notdir $(basename $(TST)))
TESTS = $(addprefix $(BINDIR)/, $(BIN))

# C compiler
CC = gcc
# Wall   - warns about questionable things
# Werror - makes all warnings errors
# Wextra - enables some extra warning flags that `all` doesn't set
CFLAGS = -Wall -Werror -Wextra
# g    - add symbol table for debugging
# std= - sets the language standard, in this case c99
# O    - the level of optimization (3)
CFLAGS += -g -std=c99 -O3

INFOPRMPT = MAKE ------>

ifeq ($(shell uname -s), Linux)
	CC     = clang
	LFLAGS = -lBlocksRuntime
	CFLAGS += -fblocks
endif

.PHONY: all install include test build_test

all: $(OBJ)

install: $(USRLIB)/$(LIB).a
	$(info $(INFOPRMPT) installing...)
	@make include

test: $(TESTS)
	$(info $(INFOPRMPT) running tests...)
	@for i in $(TESTS); do echo "$$i:"; $$i; done

# build object files--no library
$(OBJ): $(OBJDIR)/%.o: %.c $(OBJDIR)
	$(info $(INFOPRMPT) building object file $*.o...)
	@$(CC) $(CFLAGS) -o $@ -c $<

# move library file into /usr/lical/lib
$(USRLIB)/$(LIB).a: $(LIBDIR)/$(LIB).a
	$(info $(INFOPRMPT) symlinking $< to $@...)
	@cp -i $< $@

# build library file
$(LIBDIR)/$(LIB).a: $(LAO)
	$(info $(INFOPRMPT) making and linking library archive $@...)
	@ar cru $@ $^
	@ranlib $@
	@chmod 755 $@

# build object file for library
$(LAO): $(LIBDIR)/%.o: %.c $(LIBDIR)
	$(info $(INFOPRMPT) building library object file $@...)
	@$(CC) $(CFLAGS) -fPIC -o $@ -c $<

# symlink header files
include:
	$(info $(INFOPRMPT) copying header files to $(USRINC)/$(NAME)...)
	@mkdir -p $(USRINC)/$(NAME)
	@cp -i $(wildcard *.h) $(USRINC)/$(NAME)/

# build tests
$(BINDIR)/%: $(TSTDIR)/%.c $(BINDIR) $(OBJ)
	$(info $(INFOPRMPT) building test $*.c...)
	@$(CC) $(CFLAGS) $(LFLAGS) -I"." -o $@ $(OBJ) $<

# make directories
$(DIRS):
	@mkdir -p $@

.PHONY: clean uninstall

clean:
	$(info $(INFOPRMPT) removing build directories $(DIRS)...)
	@rm -rf $(DIRS)

uninstall:
	$(info $(INFOPRMPT) uninstalling from system...)
	@rm -rf $(USRINC)/$(NAME) $(USRLIB)/$(LIB).a

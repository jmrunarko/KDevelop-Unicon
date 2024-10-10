# Note: in KDevelop make starts with -j4. This cause racing conditions! the *.u files were not available, but
# creating the executable already starts.
# Set process to 1 in Project->Open Configuration->Make->Override number of jobs->Number of simultaneous jobs set
# to 1.

ICON=unicon
EXEC_FILE=%{APPNAME}
UFLAGS=-s
RM=rm -f

# find and define all *.icn as SRC_ICN
SRC_ICN := $(shell find . -name "*.icn")

# define $(UNITS) to be the same as $(SRC_ICN) but replace every .icn with .u
UNITS := $(SRC_ICN:.icn=.u)

all: $(EXEC_FILE)


$(UNITS): $(SRC_ICN)
	$(ICON) $(UFLAGS) -c $(SRC_ICN)


$(EXEC_FILE): $(UNITS) %{APPNAME}Main.icn
	$(ICON) $(UFLAGS) -B $^ -o $@

clean:
	@$(RM)  *.u $(EXEC_FILE)

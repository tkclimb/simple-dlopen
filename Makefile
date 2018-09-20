CXX ?= clang++
SRC = do_something.cpp do_something_2.cpp
OBJ = $(patsubst %.cpp, %.o, $(SRC))

override CXXFLAGS += -Og -g
override LDFLAGS += -shared -fPIC

BIN = test_dlopen.bin

all: $(BIN)

RM = rm
clean: 
	$(RM) $(BIN) $(OBJ)

test_dlopen.bin : libdo_something.so test_dlopen.cpp
	$(CXX) $(CXXFLAGS) test_dlopen.cpp -o $@

libdo_something.so: $(OBJ)
	$(CXX) $(LDFLAGS) $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ 


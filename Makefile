CXX ?= clang++
SRC = do_something.cpp
OBJ = $(patsubst %.cpp, %.o, $(SRC))

override CXXFLAGS += -Og -g
override LDFLAGS += -shared -fPIC

BIN = test_dlopen.bin

all: $(BIN)

RM = rm -rf
clean: 
	$(RM) *.bin *.o *.so  *.a *.dylib *.dSYM

test_dlopen.bin : libdo_something.so test_dlopen.cpp
	$(CXX) $(CXXFLAGS) test_dlopen.cpp -o $@ -ldl -rdynamic

libdo_something.so: $(OBJ)
	$(CXX) $(LDFLAGS) $< -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@ 


#include <cstdio>
#include <cstdlib>
#include <dlfcn.h>

int main(int argc, char *argv[]) {

  void *plugin;
  plugin = dlopen("./simple/libdo_something.so", RTLD_LAZY);

  const char *err_msg = dlerror();
  if (err_msg) {
    printf("load so error:%s\n", err_msg);
    return -1;
  }

  // define f whose function type matches to the function you call
  void (*f)();
  f = (void (*)())dlsym(plugin, "print");

  if (err_msg) {
    printf("load so fun:%s\n", err_msg);
    return -1;
  }
  f();

  return EXIT_SUCCESS;
}
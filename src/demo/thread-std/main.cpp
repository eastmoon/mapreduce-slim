// thread example
// Ref : http://www.cplusplus.com/reference/thread/thread/
#include <iostream>
#include <thread>

void foo()
{
  // do stuff..
  std::cout << "Run foo function" << std::endl;
}

void bar(int x)
{
  // do stuff..
  std::cout << "Run bar function with " << x << std::endl;
}

int main()
{
  std::cout << "main, foo and bar now execute concurrently..." << std::endl;

  // spawn new thread that calls foo()
  std::thread first(foo);
  // spawn new thread that calls bar(0)
  std::thread second(bar, 0);

  // synchronize threads:
  first.join();                // pauses until first finishes
  second.join();               // pauses until second finishes

  std::cout << "foo and bar completed." << std::endl;
}

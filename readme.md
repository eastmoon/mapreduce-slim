# MapReduce slim project

此專案為一個以 C++ 語言開發的簡易 MapReduce 框架實作專案，並以此實作相關多執行緒語法。

+ Thread
    - [Standard Library](http://www.cplusplus.com/reference/thread/thread/)
        + [多執行緒 — C++ Thread](https://medium.com/ching-i/%E5%A4%9A%E5%9F%B7%E8%A1%8C%E7%B7%92-c-thread-9f6e37c7cf32)
        + Compile Error : [Undefined reference to pthread_create in Linux](https://stackoverflow.com/questions/1662909/undefined-reference-to-pthread-create-in-linux)
            - 在 gcc 進行編譯時，需要額外增加```-lpthred```來啟動執行緒編譯動作
            - 此外亦須確保```libpthread```函式庫存在於環境中，指令```ls /usr/lib/x86_64-linux-gnu/ | grep libpthread```，參考[文獻](https://stackoverflow.com/questions/35932258)
    - [Boost](https://www.boost.org/doc/libs/1_69_0/doc/html/thread.html)
        + [asio, thread_pool](https://www.boost.org/doc/libs/1_69_0/doc/html/boost_asio/reference/thread_pool.html)
+ ThreadPool
+ MapReduce

## 函式庫

此專案包括一下函式庫：

+ [Boost](https://www.boost.org/)

## 指令

+ 進入虛擬環境
```
dockerw start
```
> 以 Docker 啟動開發環境，結束請使用 "Ctrl + Z"

+ 執行內容
```
. run.sh
```
> 以此指令呼叫 c++ 相關編譯工具進行處理，並執行相關輸出結果

| command | shell | descript |
| :--: | :--: | :------: |
| demo | ```. run.sh demo -t=<target-directory>``` | 執行 ```demo``` 目錄下指定目標的 ```main.cpp``` 並以其 ```test.sh``` 為測試輸入資料 |

## 參考

#### 函式庫文件

+ [Boost.org](https://www.boost.org/)
+ [Boost 1.69.0 Library Documentation](https://www.boost.org/doc/libs/1_69_0/)

#### 框架文件

+ 原始碼
    - [Github : ThreedPool](https://github.com/progschj/ThreadPool)
    - [Github : C-MapReduce](https://github.com/jeffrey-garcia/C-MapReduce)
    - [Github : MapReduce C++ Library](https://github.com/cdmh/mapreduce)
+ 文獻
    - [Google: native C in Hadoop with MapReduce for C](https://www.computerweekly.com/blog/Open-Source-Insider/Google-native-C-in-Hadoop-with-MapReduce-for-C)
    - [c++编程实现简单mapreduce程序](https://blog.csdn.net/feinifi/article/details/101123071)
+ 電子書
    - [C++ Mapreduce, Chris Mysen, Lawrence Crowl, Adam Berkan](https://isocpp.org/files/papers/n3563.pdf)

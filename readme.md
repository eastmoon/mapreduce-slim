# MapReduce slim project

此專案為一個以 C++ 語言開發的簡易 MapReduce 框架實作專案，並以此實作相關執行緒語法與設計。

+ Keyword
    - Thread
    - ThreadPool
    - MapReduce

![MapReduce concept](https://i2.wp.com/s3-us-west-2.amazonaws.com/content.edupristine.com/images/blogs/mapreduce-step.jpg?w=525&ssl=1)
> from [Hadoop: MapReduce Framework](https://www.edupristine.com/blog/hadoop-mapreduce-framework)

MapReduce 框架是 Hadoop 的基礎架構，其設計主要在「Map（對映）」和「Reduce（歸納）」兩項，並採用多執行緒程式來達到多工運算。

+ Mapper

『Mapper will give a structure to the unstructured data.』

在 MapReduce 框架中，Mapper 主要作用是將無結構的原始資料轉成結構資料；例如 [Mapreduce Framework](https://www.sciencedirect.com/topics/computer-science/mapreduce-framework) 的範例

原始資料如下
```
ISBN1234, name of book1, author, dealer name, location, 10, ...
ISBN3245, name of book2, author, dealer name, location, 20, ....
```

可透過 Map 將其資料化如下
```
(ISBN1234, 10)
(ISBN3245, 20)
```

+ Reducer

『Reducer will take the output from the mapper as an input and make the final output as specified by the programmer.』

在 MapReduce 框架中，Reducer 是將 Mapper 結構化的資料進行相應運算，並送出其結果；在 Hadoop 架構中，Reducer 會有兩個部分 Shuffle 與 Reduce，其設計目的是將資料排序、運算分為兩步驟。

承襲前述範例，則資料在經過 Reducer 處理後，會輸出如下
```
(ISBN1234, [10,110])
(ISBN3245, [20])
```

+ MapReduce

是一套管理 Mapper、Reducer 兩階段運作的框架，而依據實際處理內容需要，Mapper、Reducer 並沒有嚴格規範的使用與設計方式，在 Hadoop 眾多範例中提到 Split、Shuffle 兩階段，但這也各自會被規畫到 Mapper、Reducer 的實作細節中；而在相關文獻中提到，除 Hadoop 外，其框架也類似不同語言中的 Streaming framework 與 Pipes framework，考量實務與運用特性，若能將資料脫除時序性、關係性，並將運算結果還原其時序性，的確可將此框架的分散運算概念用於此兩類框架中。

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
    - [MapReduce](https://zh.wikipedia.org/wiki/MapReduce)
        + [Google: native C in Hadoop with MapReduce for C](https://www.computerweekly.com/blog/Open-Source-Insider/Google-native-C-in-Hadoop-with-MapReduce-for-C)
        + [c++编程实现简单mapreduce程序](https://blog.csdn.net/feinifi/article/details/101123071)
        + [Hadoop: MapReduce Framework](https://www.edupristine.com/blog/hadoop-mapreduce-framework)
        + [Hadoop MapReduce Tutorial](https://www.dezyre.com/hadoop-tutorial/hadoop-mapreduce-tutorial-)
        + [Mapreduce Framework](https://www.sciencedirect.com/topics/computer-science/mapreduce-framework)
    - [Thread](https://zh.wikipedia.org/wiki/%E7%BA%BF%E7%A8%8B)
        + [Standard Library](http://www.cplusplus.com/reference/thread/thread/)
            - [多執行緒 — C++ Thread](https://medium.com/ching-i/%E5%A4%9A%E5%9F%B7%E8%A1%8C%E7%B7%92-c-thread-9f6e37c7cf32)
            - Compile Error : [Undefined reference to pthread_create in Linux](https://stackoverflow.com/questions/1662909/undefined-reference-to-pthread-create-in-linux)
                - 在 gcc 進行編譯時，需要額外增加```-lpthred```來啟動執行緒編譯動作
                - 此外亦須確保```libpthread```函式庫存在於環境中，指令```ls /usr/lib/x86_64-linux-gnu/ | grep libpthread```，參考[文獻](https://stackoverflow.com/questions/35932258)
        + [Boost](https://www.boost.org/doc/libs/1_69_0/doc/html/thread.html)
            - [asio, thread_pool](https://www.boost.org/doc/libs/1_69_0/doc/html/boost_asio/reference/thread_pool.html)
+ 電子書
    - [C++ Mapreduce, Chris Mysen, Lawrence Crowl, Adam Berkan](https://isocpp.org/files/papers/n3563.pdf)

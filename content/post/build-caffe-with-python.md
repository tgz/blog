---
title: 编译 caffe 并在 python 中使用
date: 2018-05-18 13:30:18
tags: [caffe]
keywords: [caffe pycaffe]
---

1. 参考[官方文档](http://caffe.berkeleyvision.org/installation.html) 将前置依赖都装好

2. 一般来说，我们会在 python 使用 caffe，强烈建议使用 anaconda / virtual env.   
   除了需要 `pip install -r pyton/requriements.txt` 外，scikit-image 也需要安装。requirement 有遗漏 

3. 关于 make / cmake， 个人建议使用 cmake， 毕竟省了改一堆 Make.confi。  
  
   另外 `cmake ..` 的时候，输出的环境检查也更友好。比如：  
   `The dependency target "pycaffe" of target "pytest" does not exist !`  
   这个问题其实就是 Python 相关依赖的问题，网上五花八门的情况都有。我是缺少 `scikit-image` 导致

4. 编译并输出安装目录：    

    `make all & make install` （CMAKE） 

    or    

      `make all & make pycaffe & make distribute`(MAKE)

5. 添加 `PYTHONPATH` 环境变量。这里将 build 输出的与源码的 python 目录都加上:

    `export PATHONPATH=/caffe_path/distribute/python:/caffe_path/python:$PYTHONPATH` (MAKE)
    
    或者： 
 
    `export PATHONPATH=/caffe_path/build/install/python:/caffe_path/python:$PYTHONPATH` (CMAKE)
  
6. 验证 python module:  
  `import caffe`不报错即可



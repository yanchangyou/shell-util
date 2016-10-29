#!/bin/bash

# 使用说明 ：将本shell放到.git目录下面
# 添加执行权限： chmod +x cat_git_objects.sh
# 在.git目录中执行： ./cat_git_objects.sh
# 执行结果： 把所以objects按照修改时间顺序排列，然后依次显示内容

# 进入目录
cd objects
# 查找文件
find . -type f|\
#按照修改时间排序
xargs ls -ltar |\
#提前文件名
awk '{print $9}'|\
#提取objects
grep -E '^./\w+'|\
#生成显示object内容的命令（包装 git cat-file 命令）
awk -F / '{print "echo =======object : "$2$3"===== && git cat-file -p "$2$3" &&echo"}'|\
# 执行命令
xargs -0  bash -c

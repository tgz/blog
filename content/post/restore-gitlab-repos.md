---
title: gitlab 批量恢复被删除的 repo
date: 2018-05-17 20:53:17
tags: [GitLab]
keywords: [GitLab, 恢复]
---

小伙伴本想移动一 repo group. 结果可能点错了，把 group 删除了。这里记录一下恢复的过程。

1. 首先查看 gitlab 的 docker-coompose.yml 设置，定位 gitlab 的存储在什么位置。
2. 进入 gitlab data 的实际存储文件夹：
   `/srv/docker/gitlab/gitlab`
3. 这里能看到有 backups 文件夹
 
    解压备份：

    ```bash
    tar xvf 1526230868_2018_05_13_10.1.4_gitlab_backup.tar
    ```
4. 进入发现能看到 gitlab 的每日备份，将昨日的备份解压   
   
5. 进入 repositories 能看到以各 group 名为称的文件夹，再进入想恢复的 group, 能看到所有 repo 的 bundle 文件。  
    参考：[git bundle](https://git-scm.com/docs/git-bundle) 

    
6. 将需要恢复的 repo 移动到当前 gitlab  repositoris 文件夹内。

    执行：

    ```bash
    for i in `ls`; do git clone --mirror $i;done
    ```

    这个命令遍历当前文件夹下的文件，分别执行 `clone` 命令，将 `bundle` 解包为 `*.git`

7. 参考：[gitlab-raketasks-import](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/raketasks/import.md)  执行 rake 命令：

```bash
sudo -u git -H bundle exec rake gitlab:import:repos['/home/git/data/repositories/Backup'] RAILS_ENV=production
```

这句话会遍历指定的文件下的所有 `*.git`,导入到 gitlab 的数据库内。

至此，恢复完成。



---
title: 通过命令行重置 GitLab 用户密码
date: 2018-03-22 10:01:41
tags: GitLab
---

公司内部使用 Docker 部署了 GitLab, 有同事忘记密码，恰好邮件发送服务暂时失效，所以查了下使用命令行重置 GitLab 用户密码的方法，记录如下：

1. 找到 GitLab 的 container:  
     `docker ps`

	> `9ef8c21caba5        sameersbn/gitlab:10.1.4`

2. 进入 GitLab console:  
  `docker exec -it 9ef8c21caba5 /bin/bash`

	> `root@9ef8c21caba5:/home/git/gitlab# `

3. 进入 rails console:  
   `sudo -u git -H bundle exec rails console production`

    执行以下命令：

    ```bash
    user=User.find_by(email: 'name@mail.host')
	 或者：user = User.find(1) # 使用 userID 查询

    user.password='new_password'
	 user.password_confirmation='new_password'
	 
	 user.save

	```
	
	---
	附： 给用户添加管理员角色：`user.admin=true`


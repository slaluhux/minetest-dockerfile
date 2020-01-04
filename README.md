# minetest-dockerfile

Minetest服务器的Docker容器

用于编译:

* Minetest 5.1.0 服务端

# 使用方法:

## 构建容器

	git clone https://github.com/slaluhux/minetest-dockerfile
	cd minetest-dockerfile
	sh build.sh   # 构建容器
	docker create volume minetest # 创建卷来存储数据


## 启动容器

启动命令:

	docker run -d \ # 后台运行
		--rm \ # 容器关闭即销毁
		--name minetest-server \ # 容器名
		-v minetest:/home/minetst \ # 将卷挂载
		-p 30000:30000/udp \ # 将游戏服务端口映射出来
		minetest 

## 第一次使用的配置

容器开启后会使用ssh服务用来登录，但是为了安全，用户密码是随机生成的，第一次使用请导入ssh公钥

	docker ps | grep minetest-server
	# 找到容器id后
	docker cp 公钥 容器id:/home/minetest/  # 拷贝公钥到容器
	docker exec -it 容器id /bin/bash    # 进入容器
	chown -R minetest:minetest /home/minetest # 为minetest用户提供权限
	su - minetest   # 切换用户
	mkdir ~/.ssh # 创建 .ssh 目录
	cat 公钥 > ~/.ssh/authorized_keys  # 导入公钥
	hostname -i    # 查看容器IP地址


导入公钥后可以使用:

	ssh -i 密钥 minetest@容器IP 

登录使用容器

## 编译服务端

下载源码并解压

进入源码目录

执行 

	cmake . \
		-DRUN_IN_PLACE=TRUE \
		-DBUILD_CLIENT=FALSE \
		-DBUILD_SERVER=TRUE \
		-DCMAKE_BUILD_TYPE=Release \
		-DENABLE_CURSES=ON \
		-DENABLE_GETTEXT=ON
	make 

进行编译


编译完成后执行 screen ./bin/minetestserver + 参数启动游戏服务器

> 使用screen保持游戏服务运行


## 关闭容器

关闭容器:

	docker ps | grep minetest-server 
	# 找到容器id后
	docker stop 容器id



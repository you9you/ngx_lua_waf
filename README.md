## ngx_lua_waf

基于 https://openresty.org/cn/ 修改

### 用途：

- 防止sql注入，本地包含，部分溢出，fuzzing测试，xss,SSRF等web攻击
- 防止svn/备份之类文件泄漏
- 防止ApacheBench之类压力测试工具的攻击
- 屏蔽常见的扫描黑客工具，扫描器
- 屏蔽异常的网络请求
- 屏蔽图片附件类目录php执行权限
- 防止webshell上传

### 兼容测试:

基于 OpenResty 1.17.8.1 RC1


### 使用说明：

nginx安装路径假设为:/usr/local/nginx/conf/

把ngx_lua_waf下载到conf目录下,解压命名为waf

在nginx.conf的http段添加

```shell
    lua_shared_dict limit 50m;
    init_by_lua_file "/usr/local/openresty/nginx/conf/waf/init.lua";
    access_by_lua_file "/usr/local/openresty/nginx/conf/waf/access.lua";
```

配置config.lua里的waf规则目录(一般在waf/conf/目录下)
```shell
    RulePath = "/usr/local/openresty/nginx/conf/waf/rules/"
```

绝对路径如有变动，需对应修改

然后重启nginx即可


### 配置文件详细说明：

```lua
--规则存放目录
RulePath = "/usr/local/openresty/nginx/conf/waf/rules/"

--是否开启攻击信息记录，需要配置logdir
attacklog = "on"

--log存储目录，该目录需要用户自己新建，切需要nginx用户的可写权限
logdir = "/usr/local/openresty/nginx/logs/test/"

--是否拦截url访问
UrlDeny="on"

--是否拦截后重定向
Redirect="on"

--是否拦截cookie攻击
CookieMatch="on"

--是否拦截post攻击
postMatch="on"

--是否开启URL白名单
whiteModule="on"

--填写不允许上传文件后缀类型
black_fileExt={"php","jsp"}

--ip白名单，多个ip用逗号分隔
ipWhitelist={"127.0.0.1"}

--ip黑名单，多个ip用逗号分隔
ipBlocklist={"1.0.0.1"}

--是否开启拦截cc攻击(需要nginx.conf的http段增加lua_shared_dict limit 50m;)
CCDeny="off"

--设置cc攻击频率，单位为秒.
--默认1分钟同一个IP只能请求同一个地址100次
CCrate="100/60"

--警告内容,可在中括号内自定义
html=[[Please go away~~]]
```
        
### 检查规则是否生效

部署完毕可以尝试如下命令：        
```shell
curl http://xxxx/test.php?id=../etc/passwd
```
        返回"Please go away~~"字样，说明规则生效。

注意:默认，`127.0.0.1`在白名单不过滤，可自行调整config.lua配置

### 规则更新：

考虑到正则的缓存问题，动态规则会影响性能，所以暂没用共享内存字典和redis之类东西做动态管理。

规则更新可以把规则文件放置到其他服务器，通过crontab任务定时下载来更新规则，nginx reload即可生效。以保障ngx lua waf的高性能。

只记录过滤日志，不开启过滤，在代码里在check前面加上--注释即可，如果需要过滤，反之

### 一些说明：

	过滤规则在rules下，可根据需求自行调整，每条规则需换行,或者用|分割
	
		args里面的规则get参数进行过滤的
		url是只在get请求url过滤的规则		
		post是只在post请求过滤的规则		
		whitelist是白名单，里面的url匹配到不做过滤		
		user-agent是对user-agent的过滤规则
	

	默认开启了get和post过滤，需要开启cookie过滤的，编辑waf.lua取消部分--注释即可
	
	日志文件名称格式如下:虚拟主机名_sec.log


### Open Source Lincenses
- ngx_lua_waf: [MIT](https://github.com/loveshell/ngx_lua_waf "loveshell/ngx_lua_waf")

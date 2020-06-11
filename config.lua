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
html=[[
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, maximum-scale=1">
    <title>网站防火墙</title>
    <style>
        body{padding:0; margin:0; font:14px/1.5 Microsoft Yahei, 宋体,sans-serif; color:#555;}
        p{line-height:20px;margin:0px;text-indent:0px;}
        ul{list-style-type:none;margin: 0px 0px 12px;}
        li{list-style-type:none;margin: 0px; text-indent:0px;}
        .card{margin: 0 auto; width:600px; padding-top:70px; overflow:hidden;}
        .card .card-header{height:40px; line-height:40px; color:#fff; font-size:16px; overflow:hidden; background:#6bb3f6; padding-left:20px;}
        .card .card-body{border:1px dashed #cdcece; border-top:none; font-size:14px; background:#fff; color:#555; line-height:24px; height:220px; padding:20px 20px 0 20px; overflow-y:auto;background:#f3f7f9;}
        .card .card-body .title{font-weight:600; color:#fc4f03;}
    </style>
</head>

<body>
    <div class="card">
        <div class="card-header">
            网站防火墙
        </div>
        <div class="card-body">
            <p class="title">
                您的请求带有不合法参数，已被网站管理员设置拦截！
            </p>
            <p>可能原因：您提交的内容包含危险的攻击请求</p>
            
            <p style="margin:12px 0px;">如何解决：</p>
            <ul>
                <li>1) 检查提交内容</li>
                <li>2) 如网站托管，请联系空间提供商</li>
                <li>3) 普通网站访客，请联系网站管理员</li>
            </ul>
        </div>
    </div>
</body>
</html>
]]

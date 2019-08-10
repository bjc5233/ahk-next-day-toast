# next-day-toast
> 很喜欢一个next-day的应用，最初是在Ami桌面上见到，每天很清新，非常喜欢，是与next-day官方合作的，可以这个桌面后来不维护了（猜测）。 在github上有公开[API](https://github.com/NXMIX/nextday-public-api)。 目前采用的接口是这个[手机应用客户端项目的接口](https://github.com/sanddudu/nextday-desktop)。 以后再调整到官方的接口

## 说明
> 自动下载next-day每日图文，并以系统toast消息形式展示；建议将脚本配置到系统定时任务中，让其自动执行
使用步骤
* 安装autohotkey软件
* 双击[nextDay.ahk]执行预览
* 为方便自动化，可以在[系统计划任务]中配置定时执行。  
例如我的配置是：触发器每日10：05，操作  
```"C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" "C:\path\AHK\nextDayToast\nextDay.ahk"```
 
 
## 预览
<div align=center><img src="https://github.com/bjc5233/toast-next-day/raw/master/resources/nextDay20170706.png"/></div>
<div align=center><img src="https://github.com/bjc5233/toast-next-day/raw/master/resources/nextDay20170704.png"/></div>



## TODO
 * 重新检查接口有效性
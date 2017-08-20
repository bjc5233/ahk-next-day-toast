# next-day-toast
> 很喜欢一个next-day的应用，最初是在Ami桌面上见到，每天很清新，非常喜欢，是与next-day官方合作的，可以这个桌面后来不维护了（猜测）。 在github上有公开[API](https://github.com/NXMIX/nextday-public-api)。 目前采用的接口是这个[手机应用客户端项目的接口](https://github.com/sanddudu/nextday-desktop)。 以后再调整到官方的接口

## 说明
> 自动下载next-day每日图文，并以系统toast消息形式展示；建议将脚本配置到系统定时任务中，让其自动执行
---
使用步骤
* 安装autohotkey
* 修改nextDay.ahk中行<image placement="appLogoOverride" src="C:/path/toast/task/milk.png" />，将这个图片地址修改为本地绝对图片路径
* 双击nextDay.ahk执行预览
* 在系统计划任务中配置定时执行。
   例如我的配置是：触发器每日10：05，操作"C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" "C:\path\toast\nextDayToast\nextDay.ahk"

## 预览
<div align=center><img src="https://github.com/bjc5233/next-day-toast/raw/master/resources/nextDay20170706.png"/></div>
<div align=center><img src="https://github.com/bjc5233/next-day-toast/raw/master/resources/nextDay20170704.png"/></div>




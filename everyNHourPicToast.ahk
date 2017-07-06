#SingleInstance,Force



; ========================= 检查图片路径文件 =========================
IfNotExist, %A_Temp%\everyNHourPicToast.txt
    runWait, buildPicPath.bat,,Hide
; ========================= 检查图片路径文件 =========================



; ========================= 获取随机图片路径 =========================
global pics := Array()
Loop, Read, %A_Temp%\everyNHourPicToast.txt
{
     pics.Insert(A_LoopReadLine)
}
Random, randIndex, pics.MinIndex(), pics.MaxIndex()
curPicPath := pics[randIndex]
StringReplace, curPicPath, curPicPath, \, /, All
; ========================= 获取随机图片路径 =========================





; ========================= 获取随机文字 =========================
global words := Array()
Loop, Read, C:\path\bat\正能量\data\words.txt
{
     words.Insert(A_LoopReadLine)
}
Random, randIndex, words.MinIndex(), words.MaxIndex()
curWord := words[randIndex]
; ========================= 获取随机文字 =========================







; ========================= 通过powershell执行toast =========================
code =
(
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null
$APP_ID = ' '
$template = @"
<toast activationType="protocol" launch="" duration="short" displayTimestamp="2017-04-15T19:45:00Z">
    <visual>
        <binding template="ToastGeneric">
            <image placement="appLogoOverride" hint-crop="circle" src="D:/theme/pic/1.png" />
            <image placement="inline" src="file:///%curPicPath%"/>
            
            <text><![CDATA[]]></text>
            <text><![CDATA[%curWord%]]></text>
        </binding>
    </visual>
    <audio src="ms-winsoundevent:Notification.Looping.Alarm10" loop="false" silent="false" />
</toast>
"@

$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($template)
$toast = New-Object Windows.UI.Notifications.ToastNotification $xml
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($APP_ID).Show($toast)
)

FileDelete, %A_Temp%\everyNHourPicToast.ps1
FileAppend, %code% , %A_Temp%\everyNHourPicToast.ps1
run, PowerShell -ExecutionPolicy Bypass -File %A_Temp%\everyNHourPicToast.ps1 ,, Hide
; ========================= 通过powershell执行toast =========================
;说明
;  获取nextDay的图文，并以系统toast形式展示
; ========================= init =========================
#SingleInstance,Force
#Include <JSON>
FormatTime, dateStr, , yyyy-MM-dd
FormatTime, dateStr2, , yyyyMMdd
StringSplit, dateArray, dateStr, -
yearStr := dateArray1
monthStr := dateArray2
dayStr := dateArray3
; ========================= init =========================




; ========================= 下载json并解析 =========================
jsonFilePath = %A_Temp%\nextDay%dateStr%.json
IfNotExist, %jsonFilePath%
    URLDownloadToFile http://nichijou.in/LastDay/%yearStr%/%monthStr%/%dayStr%.json, %jsonFilePath%
ToolTip, JSON文件格式错误，请检查[%jsonFilePath%]
FileEncoding, UTF-8
file := FileOpen(jsonFilePath, "r")
if !IsObject(file)
	throw Exception("Can't access file for JSONFile instance: " file, -1)

try {
    json := JSON.Load(file.Read())
} catch e {
    ;JSON文件可能格式不正确。如果日期太早，下载返回的是错误html页面
    FileDelete, %jsonFilePath%
    MsgBox, JSON文件格式错误，请检查[%jsonFilePath%]
    return
}
; ========================= 下载json并解析 =========================



; ========================= 获取图片地址并下载 =========================
imgUrl := json[dateStr2].images.big568h3x
StringReplace, imgUrl, imgUrl, {img}, http://nextday-pic.b0.upaiyun.com, All
imgFilePath = %A_Temp%\nextDay%dateStr%.jpg
IfNotExist, %imgFilePath%
	URLDownloadToFile, %imgUrl%, %imgFilePath%
StringReplace, imgFilePath, imgFilePath, \, /, All
; ========================= 获取图片地址并下载 =========================



; ========================= 获取图片配词 =========================
comment1 := json[dateStr2].text.comment1
comment2 := json[dateStr2].text.comment2
; ========================= 获取图片配词 =========================


; ========================= 通过powershell发送toast =========================
code =
(
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null
$APP_ID = ' '
$template = @"
<toast activationType="protocol" launch="" duration="long" displayTimestamp="2017-04-15T19:45:00Z">
    <visual>
        <binding template="ToastGeneric">
            <image placement="hero" src="file:///%imgFilePath%"/>
            <image placement="appLogoOverride" src="C:/path/toast/nextDayToast/milk.png" />
            <image placement="inline" src="file:///%imgFilePath%"/>
            

            <text><![CDATA[%comment1%]]></text>
            <text><![CDATA[%comment2%]]></text>
			
			
            <group>
                <subgroup>
                    <text hint-style="captionSubtle" hint-align="right">%dateStr%</text>
                </subgroup>
            </group>
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
; ========================= 通过powershell发送toast =========================
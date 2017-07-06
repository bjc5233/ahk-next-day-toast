@echo off
set picPathFile=%temp%\everyNHourPicToast.txt
if not exist %picPathFile%  (
	dir /A-D /s /b D:\theme\pic *.jpg *.gif *.png >%picPathFile%
)
@echo off
//adb shell input keyevent 224
//timeout 2
//adb shell input swipe 300 1000 300 500
adb shell service call phone 1 s16 0
adb shell input keyevent 67
adb shell input keyevent 17
adb shell input keyevent 18
adb shell input keyevent 17
adb shell input keyevent 18
adb shell input keyevent 11
adb shell input keyevent 11
adb shell input keyevent 8
adb shell input keyevent 9
adb shell input keyevent 18
adb shell input keyevent 17
adb shell input keyevent 18
adb shell input keyevent 17



//timeout 15
//adb shell input keyevent 6
//adb shell input keyevent 223

@echo off
//adb shell input keyevent 224
//timeout 2
//adb shell input swipe 300 1000 300 500
adb shell service call phone 1 s16 0
adb shell input keyevent 67
adb shell input keyevent 17
adb shell input keyevent 18
adb shell input keyevent 7
adb shell input keyevent 13
adb shell input keyevent 18



//timeout 15
//adb shell input keyevent 6
//adb shell input keyevent 223

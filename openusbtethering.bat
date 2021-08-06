@echo off
//adb shell input keyevent 224
//timeout 2
//adb shell input swipe 300 1000 300 500
adb shell am start -n com.android.settings/.TetherSettings
adb shell input keyevent 20
adb shell input keyevent 20
adb shell input keyevent 66
timeout 2
adb shell input keyevent 3

//timeout 15
//adb shell input keyevent 6
//adb shell input keyevent 223

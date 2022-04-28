remove comments
- search with //.*
- check .*
- select all occurrences
- press back space twine


#1 deployment
// macos
keytool -genkey -v -keystore /Users/iblurblur/Desktop/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
// windows
keytool -genkey -v -keystore c:\Users\iblurblur\Desktop\key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key

#2 check fluttet environment
flutter doctor -v

#3 Create a file named <app dir>/android/key.properties that contains a reference to your keystore
#4 <app dir>/android/app/build.gradle file.
#5 flutter build apk
#6 flutter build appbundle


day1
- install and setting
- layout and login
- state
- log
- debug

day2
- navigation
- grid and feed json
- viewmodel
- image
- bloc

day3
- gallery & camera upload image
- grud & nodejs & heroku
- qrcode read and write
- detect platform and devices

day4
- ios demo
- map

day5
- deployment
- app icon
- rename app
- apk appbundle
- ios certificate

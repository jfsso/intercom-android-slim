# intercom-android-slim

A small script to generate a "slim jar" for [Intercom Android SDK](https://github.com/intercom/intercom-android). Because fat-jars are [uncool](https://github.com/intercom/intercom-android/issues/126).

Make sure to declare the dependencies of the Intercom Android SDK in your build.gradle.

```
compile 'com.google.code.gson:gson:2.4'
compile 'com.squareup.okhttp:okhttp:2.5.0'
compile 'com.squareup.okhttp:okhttp-ws:2.5.0'
compile 'com.squareup.okio:okio:1.6.0'
compile 'com.squareup:otto:1.3.8'
compile 'com.squareup.picasso:picasso:2.5.2'
compile 'com.squareup.retrofit:retrofit:1.9.0'
```

Feel free to use/adapt/modify this as you need. Pull requests are welcome.

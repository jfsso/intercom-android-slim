**This project is no longer continued thanks to Intercom's official release of a library build with transitive dependencies! Check out this article for more info: [Using transitive dependencies with Intercom for Android](https://docs.intercom.com/configure-intercom-for-your-product-or-site/configure-intercom-for-mobile/using-transitive-dependencies-with-intercom-for-android).**

# intercom-android-slim

A small script to generate a "slim jar" for [Intercom Android SDK](https://github.com/intercom/intercom-android). Because fat-jars are [uncool](https://github.com/intercom/intercom-android/issues/126).

Make sure to declare the dependencies of the Intercom Android SDK in your build.gradle.

```
compile 'com.google.code.gson:gson:2.4'
compile 'com.squareup.okhttp:okhttp:2.7.5'
compile 'com.squareup.okhttp:okhttp-ws:2.7.5'
compile 'com.squareup.okio:okio:1.6.0'
compile 'com.squareup:otto:1.3.8'
compile 'com.squareup.picasso:picasso:2.5.2'
compile 'com.squareup.retrofit:retrofit:1.9.0'
```

Feel free to use/adapt/modify this as you need. Pull requests are welcome.

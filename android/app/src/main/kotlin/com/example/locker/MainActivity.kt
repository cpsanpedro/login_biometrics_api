package com.example.locker

import io.flutter.embedding.android.FlutterFragmentActivity
import com.example.flutter_locker.FlutterLockerPlugin
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        flutterEngine.plugins.add(FlutterLockerPlugin())
    }
}

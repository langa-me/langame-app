package me.langa.dev

import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.embedding.android.FlutterActivity
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin

class MainActivity : FlutterActivity(), PluginRegistrantCallback {
    override fun registerWith(registry: PluginRegistry?) {
        if (!registry!!.hasPlugin("com.dexterous.flutterlocalnotifications")) {
                FlutterLocalNotificationsPlugin.registerWith(registry!!.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
        }
    }
}
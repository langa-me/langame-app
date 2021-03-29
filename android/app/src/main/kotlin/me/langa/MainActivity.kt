package me.langa

import io.flutter.embedding.android.FlutterActivity
class MainActivity: FlutterActivity(){}
//class MainActivity: FlutterActivity(), PluginRegistrantCallback {
//    override fun onCreate() {
//        super.onCreate()
//        FlutterFirebaseMessagingService.setPluginRegistrant(this);
//    }
//
//    override fun registerWith(registry: PluginRegistry) {
//        CustomPluginRegistrant.registerWith(registry)
//    }
//}
//class CustomPluginRegistrant {
//    companion object {
//        fun registerWith(registry: PluginRegistry) {
//            if (alreadyRegisteredWith(registry)) {
//                return
//            }
//            FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
//            FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
//        }
//
//        fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
//            val key: String = FirebaseCloudMessagingPluginRegistrant::class.java.getCanonicalName()
//            if (registry.hasPlugin(key)) {
//                return true
//            }
//            registry.registrarFor(key)
//            return false
//        }
//    }
//}

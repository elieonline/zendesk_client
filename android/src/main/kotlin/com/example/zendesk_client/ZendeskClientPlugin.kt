package com.example.zendesk_client

import android.app.Activity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import zendesk.core.AnonymousIdentity
import zendesk.core.Zendesk
import zendesk.support.Support


/** ZendeskClientPlugin */
class ZendeskClientPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private val tag = "[ZendeskMessagingPlugin]"
  var activity: Activity? = null
  var isInitialize: Boolean = false

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "zendesk_client")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
      val sendData: Any? = call.arguments
      val zendeskFlutterCombination = FlutterZendeskCommonMethod(this, channel)

      Zendesk.INSTANCE.init(plugin.activity!!, "zendeskUrl", "appId", "clientId")

      val identity: Identity = AnonymousIdentity.Builder().withNameIdentifier("").withEmailIdentifier("").build();
      Zendesk.INSTANCE.setIdentity(identity)

      Support.INSTANCE.init(Zendesk.INSTANCE)

      if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

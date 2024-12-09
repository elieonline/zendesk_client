import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'zendesk_client_platform_interface.dart';

/// An implementation of [ZendeskClientPlatform] that uses method channels.
class MethodChannelZendeskClient extends ZendeskClientPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zendesk_client');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

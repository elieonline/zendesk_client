import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'zendesk_client_method_channel.dart';

abstract class ZendeskClientPlatform extends PlatformInterface {
  /// Constructs a ZendeskClientPlatform.
  ZendeskClientPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZendeskClientPlatform _instance = MethodChannelZendeskClient();

  /// The default instance of [ZendeskClientPlatform] to use.
  ///
  /// Defaults to [MethodChannelZendeskClient].
  static ZendeskClientPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZendeskClientPlatform] when
  /// they register themselves.
  static set instance(ZendeskClientPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

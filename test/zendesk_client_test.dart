import 'package:flutter_test/flutter_test.dart';
import 'package:zendesk_client/zendesk_client.dart';
import 'package:zendesk_client/zendesk_client_platform_interface.dart';
import 'package:zendesk_client/zendesk_client_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZendeskClientPlatform
    with MockPlatformInterfaceMixin
    implements ZendeskClientPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ZendeskClientPlatform initialPlatform = ZendeskClientPlatform.instance;

  test('$MethodChannelZendeskClient is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZendeskClient>());
  });

  test('getPlatformVersion', () async {
    ZendeskClient zendeskClientPlugin = ZendeskClient();
    MockZendeskClientPlatform fakePlatform = MockZendeskClientPlatform();
    ZendeskClientPlatform.instance = fakePlatform;

    expect(await zendeskClientPlugin.getPlatformVersion(), '42');
  });
}

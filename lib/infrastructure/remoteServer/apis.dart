import 'dart:io';

abstract class Apis {
  static const String apiVersion = 'api/v0';
  static const String submitRecord = '/$apiVersion/submitRecord';
    static const String submitRecordBatch = '/$apiVersion/submitRecordBatch';
  static const String authenticate = '/$apiVersion/loginWorker';
  static String _resolvedServerUrl = '';

  static Future<String> get serverUrl async{
    const host ='enduring-alligator-629.convex.site'; //'embag.duckdns.org';

    if (_resolvedServerUrl != '') {
      return _resolvedServerUrl;
    }

    _resolvedServerUrl = (await InternetAddress.lookup(host)).first.address;

    return host;
  }
}

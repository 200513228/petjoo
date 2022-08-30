import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DLinkService {
  static String? type;
  static String? docid;
  static bool isGo = false;
  static void instance(PendingDynamicLinkData? initial) {
    final PendingDynamicLinkData? data = initial;
    if (data == null) {
      return;
    } else {
      isGo = true;
      type = data.link.queryParameters['type'];
      docid = data.link.queryParameters['doc'];
    }
  }
}

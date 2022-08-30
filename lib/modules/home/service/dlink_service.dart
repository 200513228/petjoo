import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DLinkService {
  static String? type;
  static String? docid;
  static void instance(PendingDynamicLinkData? initial) {
    final PendingDynamicLinkData? data = initial;
    if (data == null) {
      return;
    } else {
      type = data.link.queryParameters['type'];
      docid = data.link.queryParameters['doc'];
    }
  }
}

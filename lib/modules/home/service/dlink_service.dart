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

  static Future<Uri> createLink(String type, String doc,
      {SocialMetaTagParameters? metaTagParameters}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://url.petjoo.app',
        link: Uri.parse('https://url.petjoo.app?type=$type&doc=$doc'),
        androidParameters: const AndroidParameters(
          packageName: "com.petjoo.android",
          minimumVersion: 33,
        ),
        iosParameters: const IOSParameters(
          appStoreId: "1614267680",
          bundleId: "com.petjoo.ios",
          minimumVersion: '1.3.3',
        ),
        socialMetaTagParameters: metaTagParameters);

    final ShortDynamicLink shortDynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortDynamicLink.shortUrl;
  }

  static Future<Uri> createPetLink(String doc) async => createLink('pet', doc);
  static Future<Uri> createStoreLink(String doc) async =>
      createLink('store', doc);
}

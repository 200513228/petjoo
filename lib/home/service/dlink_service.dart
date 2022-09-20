import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DLinkService {
  static String? type;
  static String? docid;
  static bool isGo = false;

  static void instance(PendingDynamicLinkData? initial) async {
    var init = await FirebaseDynamicLinks.instance.getInitialLink();
    final PendingDynamicLinkData? data = init;
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

  static Future<Uri> createPetLink(String doc) async => createLink(
        'pet',
        doc,
        metaTagParameters: SocialMetaTagParameters(
            imageUrl: Uri.parse(
                "https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2F634x634.png?alt=media&token=8b5c370e-3d48-410d-8425-9e0570de7e01"),
            title: 'İlan',
            description:
                'Bu link sizi güvenli bir şekilde PETJOO uygulamasına taşır. Eğer şüphelendiğiniz bir durum varsa destek@petjoo.app adresine mail ile iletebilirsiniz.'),
      );
  static Future<Uri> createStoreLink(String doc) async => createLink(
        'store',
        doc,
        metaTagParameters: SocialMetaTagParameters(
            imageUrl: Uri.parse(
                "https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2F634x634.png?alt=media&token=8b5c370e-3d48-410d-8425-9e0570de7e01"),
            title: 'İlan',
            description:
                'Bu link sizi güvenli bir şekilde PETJOO uygulamasına taşır. Eğer şüphelendiğiniz bir durum varsa destek@petjoo.app adresine mail ile iletebilirsiniz.'),
      );
  static Future<Uri> createTransportLink(String doc) async => createLink(
        'transport',
        doc,
        metaTagParameters: SocialMetaTagParameters(
            imageUrl: Uri.parse(
                "https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2F634x634.png?alt=media&token=8b5c370e-3d48-410d-8425-9e0570de7e01"),
            title: 'İlan',
            description:
                'Bu link sizi güvenli bir şekilde PETJOO uygulamasına taşır. Eğer şüphelendiğiniz bir durum varsa destek@petjoo.app adresine mail ile iletebilirsiniz.'),
      );
}

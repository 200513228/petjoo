import 'package:dartx/dartx.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';

class DynamicLinkService {
  DynamicLinkService._();

  static DynamicLinkService? _instance;

  static DynamicLinkService get instance => _instance ?? (_instance = DynamicLinkService._());

  initialize(PendingDynamicLinkData? initialLink) => this.initialLink = initialLink;

  PendingDynamicLinkData? initialLink;

  Future<Uri> createLink(String parameter, {SocialMetaTagParameters? metaTagParameters}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://ppetjoo.page.link',
        link: Uri.parse('https://www.ppetjoo.com/$parameter'),
        androidParameters: const AndroidParameters(
          packageName: "com.petjoo.android",
          minimumVersion: 10,
        ),
        iosParameters: const IOSParameters(
          appStoreId: "1614267680",
          bundleId: "com.petjoo.ios",
          minimumVersion: '1.1.0',
        ),
        socialMetaTagParameters: metaTagParameters);

    final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortDynamicLink.shortUrl;
  }

  Future<Uri> createAdvertLink(AdvertModel data) => createLink("advertDetail?id=${data.id}",
      metaTagParameters: SocialMetaTagParameters(
          imageUrl: Uri.parse(data.images.firstOrNull ??
              "https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2F634x634.png?alt=media&token=8b5c370e-3d48-410d-8425-9e0570de7e01"),
          title: data.title,
          description: data.description.length > 50 ? data.description.substring(0, 50) : data.description));

  Future<Uri> createTransportAdvertLink(TransportAdvertModel data) => createLink("transportAdvertDetail?id=${data.id}",
      metaTagParameters: SocialMetaTagParameters(
          imageUrl: Uri.parse(data.images.firstOrNull ??
              "https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2F634x634.png?alt=media&token=8b5c370e-3d48-410d-8425-9e0570de7e01"),
          title: data.title,
          description: data.description.length > 50 ? data.description.substring(0, 50) : data.description));
}

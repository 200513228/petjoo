import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/modules/home/view/document_view.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DocumentsView extends StatelessWidget {
  const DocumentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
        centerTitle: true,
        title: Text('settings_docs'.tr()),
      ),
      body: settingsTiles(context),
    );
  }

  Widget settingsTiles(BuildContext _) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            settingTile('privacypolicy'.tr(), Icons.privacy_tip_rounded,
                () => navigate(_, 'privacy_policy.txt')),
            settingTile('termsofuse'.tr(), Icons.description_rounded,
                () => navigate(_, 'privacy_policy.txt')),
            settingTile(
                'adoption_form'.tr(),
                Icons.details_rounded,
                () => launchUrlString(
                      'https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2Fsahiplendirme%20formu.docx?alt=media&token=0d6d5ff7-812f-4274-beb9-75bf26f86b43',
                      mode: LaunchMode.externalApplication,
                    )),
          ],
        ),
      ),
    );
  }

  Widget settingTile(String title, IconData icon, Function ontap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        style: ListTileStyle.list,
        visualDensity: VisualDensity.compact,
        leading: Icon(icon, color: Colors.white, size: 32),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        onTap: () => ontap(),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white70,
        ),
      ),
    );
  }

  void navigate(BuildContext _, String asset) {
    Navigator.push(
        _,
        MaterialPageRoute(
            builder: (context) => DocumentView(assetName: asset)));
  }
}

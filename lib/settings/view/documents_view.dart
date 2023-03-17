import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/home/view/document_view.dart';
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
                () => navigate(_, 'privacy_policy.txt', [])),
            settingTile('termsofuse'.tr(), Icons.description_rounded,
                () => navigate(_, 'terms_of_use.txt', [])),
            settingTile(
                'adoption_form'.tr(),
                Icons.details_rounded,
                () => launchUrlString(
                      'https://firebasestorage.googleapis.com/v0/b/petjoo-129db.appspot.com/o/docs%2Fsahiplendirme%20formu.docx?alt=media&token=0d6d5ff7-812f-4274-beb9-75bf26f86b43',
                      mode: LaunchMode.externalApplication,
                    )),
            settingTile('Cezai Yaptırımlar'.tr(), Icons.privacy_tip_rounded,
                () => navigate(_, 'cezai_yaptirimlar.txt', [])),
            settingTile('Ödeme Sorumlulukları'.tr(), Icons.privacy_tip_rounded,
                () => navigate(_, 'odeme_sorumluluklari.txt', [])),
            settingTile('Belediye Vet. Akışı'.tr(), Icons.privacy_tip_rounded,
                () => navigate(_, 'belvetakis.txt', [])),
            settingTile(
                'Belediye Vet. Kanunları'.tr(),
                Icons.privacy_tip_rounded,
                () => navigate(_, 'belvetkan.txt', [
                      {
                        'name': 'Hayvan Hakları Yasası',
                        'link':
                            'https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=5199&MevzuatTur=1&MevzuatTertip=5'
                      }
                    ])),
            settingTile(
                'Trafik Kazaları Kanunları'.tr(),
                Icons.privacy_tip_rounded,
                () => navigate(_, 'kazakanun.txt', [
                      {
                        'link':
                            'https://www.resmigazete.gov.tr/eskiler/2006/05/20060512-7.htm',
                        'name': '5199 Sayılı Kanun'
                      },
                      {
                        'link':
                            'https://www.asayis.pol.tr/2023-yili-idari-para-cezalari ',
                        'name': 'İdari Para Cezaları'
                      },
                      {
                        'link':
                            'https://tsb.org.tr/media/attachments/Kara_Araclar%C4%B1_Kasko_Sigortas%C4%B1_Genel_Sartlar%C4%B1.pdf',
                        'name': 'Kara Araçları Kasko Şartları'
                      }
                    ])),
            settingTile('Sahipsiz Hayvan Akışı'.tr(), Icons.privacy_tip_rounded,
                () => navigate(_, 'sahipsizakis.txt', [])),
          ],
        ),
      ),
    );
  }

  Widget settingTile(String title, IconData icon, Function ontap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        dense: true,
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

  void navigate(BuildContext _, String asset, List<Map> links) {
    Navigator.push(
        _,
        MaterialPageRoute(
            builder: (context) =>
                DocumentView(assetName: asset, links: links)));
  }
}

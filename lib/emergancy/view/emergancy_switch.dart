import 'package:flutter/material.dart';
import 'package:petjoo/home/view/document_view.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/transport/model/transport_filter_model.dart';
import 'package:petjoo/transport/view/transport_filter_view.dart';
import 'package:petjoo/transport/view/transport_list_view.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/ui/ui_snackbar.dart';

Widget title1content(BuildContext context, int index) {
  TextStyle style = const TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300);
  String content = '';
  switch (index) {
    case 0:
      content =
          'Aracınızla yanlışlıkla bir hayvana çarptıysanız paniğe gerek yok, sakin olun ve bütün adımları dikkatlice takip edin. 😊';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 1:
      content =
          ' Acil Veterinerler  butonumuza tıklayarak size en yakın özel veterineri bulun.  (Zorunlu trafik sigortanız bütün veteriner masraflarını karşılayacaktır.)';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(uiSnackBar('Çok Yakında Hizmetinizde')),
              child: const Text('ACİL VETERİNERLER'))
        ],
      );
    case 2:
      content =
          'Veterineri arayıp can dostumuzun durumuyla ilgili tedaylı bilgileri ve ne zaman orada olacağınızı belirtin. ';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 3:
      content = 'Can dostumuzu aracınıza koyarak götürün.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 4:
      content =
          'Eğer aracınıza alamıyorsanız ve en yakında bulduğunuz veterinerin ambulans hizmeti yok ise Acil Pet Nakiller butonumuza tıklayıp, filtrelerden En Yakın’ı seçerek en yakınınızdaki pet nakil firmasını bulun.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                var filter = TransportFilterModel.filter(
                    hasIntercity: 0,
                    hasCage: 0,
                    hasCollar: 0,
                    hasCatch: 0,
                    is24: 1);
                TransportListView.vm.setFilter(filter);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeView(title: 'PET NAKİL')),
                );
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    backgroundColor: colorPalette['primary'],
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => TransportFilterView());
              },
              child: const Text('ACİL PET NAKİLLER'))
        ],
      );
    case 5:
      content =
          'Pet nakil personelini arayarak durumunuzun aciliyetini ve can dostumuzun durumunu belirtin. ';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 6:
      content =
          'Pet nakil yetkilisi eğer yardımcı olabileceğini belirtirse pet nakil sayfası üzerinden Acil Rezervasyon Oluştur butonumuza tıklayarak, net olarak bulunduğunuz konum, veterinerin adresi, iletişim numaranız, can dostumuzun türü, can dostumuzun durumu ve pet nakil yetkilisi ile telefonda görüştüğünüz gibi bilgileri girin. ';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 7:
      content =
          'Kaza yerinin ve can dostumuzun net bir şekilde fotoğraflarını çekin.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 8:
      content =
          'Kaza ile ilgili Cezai Yaptırımlar ve Ödeme Sorumlulukları butonlarımıza tıklayarak anayasal hak ve sorumluluklarınızı okuyup öğrenin.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 10),
          SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DocumentView(
                              assetName: 'cezai_yaptirimlar.txt', links: []))),
                  child: const Text('Cezai Yaptırımlar'))),
          const SizedBox(height: 10),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DocumentView(
                              assetName: 'odeme_sorumluluklari.txt',
                              links: [],
                            ))),
                child: const Text('Ödeme Sorumlulukları')),
          ),
        ],
      );
    case 9:
      content =
          'Can dostumuzu götürdüğünüz veteriner hekim ilk müdahalesini yaptıktan sonra can dostumuzun tedavi sürecini birlikte konuşun, planlayın ve durum ile ilgili hekim raporu talep edin.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );

    case 10:
      content =
          'Veteriner hekime tüm planladığınız süreç ile ilgili talep ettiği ödemesini yapın.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 11:
      content =
          'Ödediğiniz tutarı zorunlu sigortanızı yaptırdığınız firmaya can dostunuzun kaza da yaralandığına ilişkin fotoğraflarını, hekim raporunu ve tedavi masraflarının yazıldığı faturayı ileterek geri talep edin. ';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    default:
      return Container();
  }
}

Widget title2content(BuildContext context, int index) {
  TextStyle style = const TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300);
  String content = '';
  switch (index) {
    case 0:
      content =
          'Hayvanınız hastalandıysa, sakin olun ve bütün adımları dikkatlice takip edin. 😊';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 1:
      content =
          'Öncelikle Blog Yazılarını Oku butonumuza tıklayarak can dostunuzun şikayetlerine benzer durumlarla karşılaşan diğer hayvan sahiplerinin yazılarını okuyup fikir edinin.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeView(title: 'BLOG'))),
              child: const Text('BLOG YAZILARI'))
        ],
      );
    case 2:
      content =
          'Eğer evde kendiniz çözebileceğiniz bir durumsa gerekli müdahaleleri yaptıktan sonra 24 saat can dostunuzu gözlemleyerek durumu hakkında bilgi sahibi olun. Eğer evde çözülebilecek bir sorun değilse aşağıdaki adımları uygulayın.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );
    case 3:
      content =
          'Eğer can dostunuzu gözlemledikten sonra durumunda bir değişiklik yoksa uygulamamızdan Acil Veterinerler butonumuza tıklayarak size en yakın 7/24 hizmet veren veteriner bulun';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(uiSnackBar('Çok Yakında Hizmetinizde')),
              child: const Text('ACİL VETERİNERLER'))
        ],
      );
    case 4:
      content =
          'Eğer aracınız yoksa Acil Pet Nakiller butonumuz ile ücreti karşılığında can dostunuzu veterinere götürün.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                var filter = TransportFilterModel.filter(
                    hasIntercity: 0,
                    hasCage: 0,
                    hasCollar: 0,
                    hasCatch: 0,
                    is24: 1);
                TransportListView.vm.setFilter(filter);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeView(title: 'PET NAKİL')),
                );
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    backgroundColor: colorPalette['primary'],
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => TransportFilterView());
              },
              child: const Text('ACİL PET NAKİLLER'))
        ],
      );
    case 5:
      content =
          'Gerekli tedavileri yapıldıktan sonra can dostunuzun varsa kullanması gereken ilaçları temin etmek için uygulamamızdan hayvan sağlığı için ilaç satan, size en yakın eczaneyi Acil Eczaneler butonumuzdan bulun.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(uiSnackBar('Çok Yakında Hizmetinizde')),
              child: const Text('ACİL ECZANELER'))
        ],
      );
    default:
      return Container();
  }
}

Widget title3content(BuildContext context, int index) {
  TextStyle style = const TextStyle(
      color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300);
  String content = '';
  switch (index) {
    case 0:
      content =
          'Yaralı hayvan gördüyseniz, sakin olun ve bütün adımları dikkatlice takip edin. 😊';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
        ],
      );

    case 1:
      content =
          '5199 Sayılı Kanunun Uygulama Yönetmeliği Madde 6 uyarınca her ilin Belediye Veterinerliği sahipsiz can dostlarımızı bulundukları yerden alıp ücretsiz tedavi edip tekrardan aldıkları yere bırakmak zorundadır. Bu konu ile ilgili sahipsiz can dostlarımızın haklarını Belediye Vet. Kanun butonumuza tıklayarak öğrenebilirsiniz.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DocumentView(
                            assetName: 'belvetkan.txt',
                            links: [
                              {
                                'link':
                                    'https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=5199&MevzuatTur=1&MevzuatTertip=5',
                                'name': 'Hayvan Hakları Yasası'
                              }
                            ],
                          ))),
              child: const Text('Belediye Vet. Kanun')),
        ],
      );

    case 2:
      content =
          'Belediye Vet. Bul butonumuza tıklayarak size ne yakın Belediye Veterinerini bulup telefonla arayarak gördüğünüz yaralı ya da hasta sahipsiz can dostumuzu gelip alıp tedaviye götürmelerini rica edebilirsiniz. ( Bu canımızla ilgili tedavi sürecinde bilgi alabilmek için, canımızı alıp tedaviye götüren ekipten takip numarasını ve küpe numarasını almayı unutmayın! )';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () => null, child: const Text('Belediye Vet. Bul')),
        ],
      );
    case 3:
      content =
          'Belediye Veterinerliği Sahipsiz Hayvan Tedavi Akışı’nı Belediye Vet Akışı butonumuza tıklayarak okuyun. ';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DocumentView(
                          assetName: 'belvetakis.txt', links: []))),
              child: const Text('Belediye Vet. Akışı')),
        ],
      );
    case 4:
      content =
          'Eğer kendiniz veterinerine götürmek isterseniz Acil Veterinerler butonumuza tıklayarak konumunuza en yakın 7/24 açık olan veteriner bulup götürebilirsiniz.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(uiSnackBar('Çok Yakında Hizmetinizde')),
              child: const Text('ACİL VETERİNERLER'))
        ],
      );
    case 5:
      content =
          'Eğer kendiniz veterinere götürmeyi seçtiyseniz Sahipsiz Yaralı Hayvan Akışı butonumuza tıklayarak değerli tavsiyelerimizi inceleyebilirsiniz.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DocumentView(
                            assetName: 'sahipsizakis.txt',
                            links: [],
                          ))),
              child: const Text('Sahipsiz Hayvan Akışı')),
        ],
      );
    case 6:
      content =
          'Eğer aracınız yoksa Acil Pet Nakiller butonumuz ile ücreti karşılığında can dostunuzu veterinere götürün.';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(content, style: style),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                var filter = TransportFilterModel.filter(
                    hasIntercity: 0,
                    hasCage: 0,
                    hasCollar: 0,
                    hasCatch: 0,
                    is24: 1);
                TransportListView.vm.setFilter(filter);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeView(title: 'PET NAKİL')),
                );
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    enableDrag: true,
                    backgroundColor: colorPalette['primary'],
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    builder: (context) => TransportFilterView());
              },
              child: const Text('ACİL PET NAKİLLER'))
        ],
      );
    default:
      return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:im_stepper/stepper.dart';
import 'package:petjoo/blog/view/blog_list_view.dart';
import 'package:petjoo/emergancy/viewmodel/emergancy_detail_viewmodel.dart';
import 'package:petjoo/home/view/home_view.dart';
import 'package:petjoo/transport/model/transport_filter_model.dart';
import 'package:petjoo/transport/view/transport_filter_view.dart';
import 'package:petjoo/transport/view/transport_list_view.dart';
import 'package:petjoo/ui/color_palette.dart';
import 'package:petjoo/ui/ui_snackbar.dart';

class EmergancyDetailView extends StatelessWidget {
  final String title;
  final EmergancyDetailViewModel vm = EmergancyDetailViewModel();
  EmergancyDetailView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
          title: Text(title),
        ),
        body: Observer(builder: (_) {
          return GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0) {
                vm.newPage(vm.currentPage + 1);
              }
              if (details.delta.dx < 0) {
                vm.newPage(vm.currentPage - 1);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: timeLine(context)),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: content(context),
                )),
                Container(height: 100)
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget timeLine(BuildContext context) {
    DotStepper(
      activeStep: vm.currentPage,
      onDotTapped: (index) => vm.newPage(index),
      dotCount: counter(),
      shape: Shape.stadium,
      indicatorDecoration:
          IndicatorDecoration(color: Colors.yellowAccent.shade700),
      spacing: 20,
      lineConnectorsEnabled: true,
      indicator: Indicator.slide,
      fixedDotDecoration: FixedDotDecoration(color: Colors.grey.shade800),
    );

    return NumberStepper(
      activeStep: vm.currentPage,
      numbers: counterList(),
      lineLength: 20,
      activeStepColor: Colors.yellow.shade800,
      activeStepBorderColor: Colors.black,
      activeStepBorderWidth: 1.2,
      enableStepTapping: true,
      onStepReached: (index) => vm.newPage(index),
      numberStyle: const TextStyle(fontSize: 14, color: Colors.white),
      stepColor: Colors.grey.shade800,
      stepRadius: 25,
      steppingEnabled: true,
      nextButtonIcon: const Icon(Icons.navigate_next, color: Colors.black),
      previousButtonIcon:
          const Icon(Icons.navigate_before, color: Colors.black),
    );
  }

  Widget content(BuildContext context) {
    TextStyle style = const TextStyle(color: Colors.black, fontSize: 20);
    String content = '';

    if (title == 'Bir Hayvana Çarptım') {
      switch (vm.currentPage) {
        case 0:
          content = 'Panik olacak bir durum yok, sakin olun.';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content, style: style),
            ],
          );
        case 1:
          content = 'Acil Veteriner bulun.';
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
          content = 'Eğer aracınızla götüremiyorsanız Acil Petnakil bulun.';
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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (context) => TransportFilterView());
                  },
                  child: const Text('ACİL PETNAKİLLER'))
            ],
          );
        case 3:
          content =
              'Aracınızla yanlışlıkla bir hayvana çarptıysanız paniğe gerek yok. Can dostunuzu aracınıza alıp en yakın veterinere götürdüğünüz takdirde zorunlu trafik sigortanız tüm veteriner masraflarınızı ….. kanunu gereğince karşılayacaktır. Hakkınızı muhakkak arayınız. Eğer aracınıza alamıyorsanız ve ‘’Acil Veteriner’’inizin ambulans hizmeti yok ise ‘’Acil Petnakil’’ inizi arayarak ücreti karşılığında alıp veterinere götürmesini talep edebilirsiniz.';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content, style: style),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(appBar: AppBar()))),
                  child: const Text('ANAYASAL HAKLARIM'))
            ],
          );
        default:
          return Container();
      }
    } else if (title == 'Hayvanım Hastalandı') {
      switch (vm.currentPage) {
        case 0:
          content = 'Panik olacak bir durum yok, sakin olun.';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content, style: style),
            ],
          );
        case 1:
          content =
              'Öncelikle Bloglar Oku butonumuza tıklayarak can dostunuzun şikayetlerine benzer durumlarla karşılaşan diğer hayvan sahiplerinin yazılarını okuyup fikir edinebilirsiniz.';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content, style: style),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BlogListView())),
                  child: const Text('BLOGLAR'))
            ],
          );
        case 2:
          content =
              'Acil Veteriner Bul butonumuza tıklayarak size en yakın 7/24 hizmet veren veteriner bulun.';
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
        case 3:
          content =
              'Eğer aracınız yoksa Acil Petnakil Bul butonumuz ile ücreti karşılığında can dostunuzu veterinere götürün.';
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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (context) => TransportFilterView());
                  },
                  child: const Text('ACİL PETNAKİLLER'))
            ],
          );
        case 4:
          content =
              'Eğer can dostunuz için ilaca ihtiyacınız varsa Acil Eczane Bul butonumuzdan size en yakın nöbetçi eczaneyi bulun.';
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
    } else if (title == 'Yaralı Hayvan Gördüm') {
      switch (vm.currentPage) {
        case 0:
          content = 'Panik olacak bir durum yok, sakin olun.';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content, style: style),
            ],
          );
        case 1:
          content =
              '….. sayılı kanuna göre her ilin Belediye Veterinerliği sahipsiz can dostlarımızı bulundukları yerden alıp ücretsiz tedavi edip tekrardan aldıkları yere bırakmaktadırlar. Bu konu ile ilgili sahipsiz can dostlarımızın haklarını Bel. Vet. Kanun butonumuza tıklayarak öğrenebilirsiniz.';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content, style: style),
            ],
          );
        case 2:
          content =
              'Belediye Vet. Bul butonumuza tıklayarak size ne yakın Belediye Veterinerini bulup telefonla arayarak gördüğünüz yaralı ya da hasta sahipsiz can dostumuzu gelip alıp tedaviye götürmelerini rica edebilirsiniz. ( Sonradan bu canımızla ilgili bilgi alabilmek için takip numarasını almayı unutmayın! )';
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content, style: style),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context)
                      .showSnackBar(uiSnackBar('Çok Yakında Hizmetinizde')),
                  child: const Text('BELEDİYE VETERİNERİ'))
            ],
          );
        case 3:
          content =
              'Eğer kendiniz veterinerine götürmek isterseniz Acil Veteriner Bul butonumuza tıklayarak konumunuza en yakın 7/24 açık olan veteriner bulup götürebilirsiniz.';
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
              'Eğer aracınız yoksa Acil Petnakil Bul butonumuz ile ücreti karşılığında can dostunuzu veterinere götürün.';
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
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (context) => TransportFilterView());
                  },
                  child: const Text('ACİL PETNAKİLLER'))
            ],
          );
        default:
          return Container();
      }
    } else {
      return Container();
    }
  }

  int counter() {
    switch (title) {
      case 'Bir Hayvana Çarptım':
        return 4;
      case 'Hayvanım Hastalandı':
        return 5;
      case 'Yaralı Hayvan Gördüm':
        return 6;
      default:
        return 9;
    }
  }

  List<int> counterList() {
    switch (title) {
      case 'Bir Hayvana Çarptım':
        return [1, 2, 3, 4];
      case 'Hayvanım Hastalandı':
        return [1, 2, 3, 4, 5];
      case 'Yaralı Hayvan Gördüm':
        return [1, 2, 3, 4, 5, 6];
      default:
        return [1, 2, 3];
    }
  }
}

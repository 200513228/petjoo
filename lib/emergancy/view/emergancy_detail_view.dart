import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:im_stepper/stepper.dart';
import 'package:petjoo/emergancy/view/emergancy_switch.dart';
import 'package:petjoo/emergancy/viewmodel/emergancy_detail_viewmodel.dart';

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
                  padding: const EdgeInsets.all(18.0),
                  child: content(context),
                )),
                const SizedBox(height: 100)
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
      stepReachedAnimationEffect: Curves.fastLinearToSlowEaseIn,
      activeStepColor: Colors.yellow.shade800,
      activeStepBorderColor: Colors.black,
      activeStepBorderWidth: 1.2,
      enableStepTapping: true,
      onStepReached: (index) => vm.newPage(index),
      numberStyle: const TextStyle(fontSize: 14, color: Colors.white),
      stepColor: Colors.grey.shade800,
      stepRadius: 22,
      steppingEnabled: true,
      nextButtonIcon: const Icon(Icons.navigate_next, color: Colors.black),
      previousButtonIcon:
          const Icon(Icons.navigate_before, color: Colors.black),
    );
  }

  Widget content(BuildContext context) {
    if (title == 'Bir Hayvana Çarptım') {
      return title1content(context, vm.currentPage);
    } else if (title == 'Hayvanım Hastalandı') {
      return title2content(context, vm.currentPage);
    } else if (title == 'Yaralı Hayvan Gördüm') {
      return title3content(context, vm.currentPage);
    } else {
      return Container();
    }
  }

  int counter() {
    switch (title) {
      case 'Bir Hayvana Çarptım':
        return 12;
      case 'Hayvanım Hastalandı':
        return 6;
      case 'Yaralı Hayvan Gördüm':
        return 7;
      default:
        return 2;
    }
  }

  List<int> counterList() {
    switch (title) {
      case 'Bir Hayvana Çarptım':
        return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
      case 'Hayvanım Hastalandı':
        return [1, 2, 3, 4, 5, 6];
      case 'Yaralı Hayvan Gördüm':
        return [1, 2, 3, 4, 5, 6, 7];
      default:
        return [1, 2];
    }
  }
}

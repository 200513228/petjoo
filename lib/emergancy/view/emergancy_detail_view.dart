import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class EmergancyDetailView extends StatelessWidget {
  final String title;
  const EmergancyDetailView(this.title, {super.key});

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
        body: timeLine(context),
      ),
    );
  }

  Widget timeLine(BuildContext context) {
    List<TimelineModel> items = [
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Center(
                    child: Text('Panik Olacak Bir Durum Yok, Sakin Olun.')))),
        icon: const Icon(Icons.looks_one),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Center(child: Text('Acil Veteriner Bulun.')))),
        icon: const Icon(Icons.looks_two),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                          'Eğer aracınızla götüremiyorsanız Acil Petnakil Bulun.')),
                ))),
        icon: const Icon(Icons.looks_3),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                          'Anayasal Haklarım butonumuzdan bilgiler edinin.')),
                ))),
        icon: const Icon(Icons.looks_4),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Center(
                    child: Text('Panik Olacak Bir Durum Yok, Sakin Olun.')))),
        icon: const Icon(Icons.looks_one),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Center(child: Text('Acil Veteriner Bulun.')))),
        icon: const Icon(Icons.looks_two),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                          'Eğer aracınızla götüremiyorsanız Acil Petnakil Bulun.')),
                ))),
        icon: const Icon(Icons.looks_3),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                          'Anayasal Haklarım butonumuzdan bilgiler edinin.')),
                ))),
        icon: const Icon(Icons.looks_4),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Center(
                    child: Text('Panik Olacak Bir Durum Yok, Sakin Olun.')))),
        icon: const Icon(Icons.looks_one),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Center(child: Text('Acil Veteriner Bulun.')))),
        icon: const Icon(Icons.looks_two),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                          'Eğer aracınızla götüremiyorsanız Acil Petnakil Bulun.')),
                ))),
        icon: const Icon(Icons.looks_3),
        position: TimelineItemPosition.right,
      ),
      TimelineModel(
        const Card(
            child: SizedBox(
                height: 100,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                          'Anayasal Haklarım butonumuzdan bilgiler edinin.')),
                ))),
        icon: const Icon(Icons.looks_4),
        position: TimelineItemPosition.right,
      ),
    ];

    return Timeline(
      children: items,
      iconSize: 40,
      position: TimelinePosition.Left,
    );
  }
}

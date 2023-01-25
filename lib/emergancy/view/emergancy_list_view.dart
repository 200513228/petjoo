import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/emergancy/view/emergancy_detail_view.dart';
import 'package:petjoo/emergancy/viewmodel/emergancy_list_viewmodel.dart';

class EmergancyListView extends StatelessWidget {
  final EmergancyListViewModel vm = EmergancyListViewModel();
  EmergancyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.canPop(context),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
            title: Text('welcome_emergancy'.tr()),
          ),
          body: Column(
            children: [
              statusCard(context, 'Bir Hayvana Çarptım'),
              statusCard(context, 'Hayvanım Hastalandı'),
              statusCard(context, 'Yaralı Hayvan Gördüm'),
            ],
          )),
    );
  }

  Widget statusCard(BuildContext context, String title) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmergancyDetailView(title)));
        },
        style: ListTileStyle.list,
        title: Text(title),
      ),
    );
  }
}

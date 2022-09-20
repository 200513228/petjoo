import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/reservation/model/reservation_model.dart';
import 'package:petjoo/reservation/viewmodel/reservation_detail_viewmodel.dart';

class ReservationDetailView extends StatelessWidget {
  final ReservationDetailViewModel vm = ReservationDetailViewModel();
  final ReservationModel model;
  ReservationDetailView({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ElevatedButton(
        onPressed: () async {},
        child: Text('konum seç'.tr()),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black)),
      centerTitle: true,
      title: Text('reservation_details'.tr()),
      actions: [
        PopupMenuButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            color: Colors.black,
            itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: null,
                    child: Text(
                      'report'.tr(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ])
      ],
    );
  }
}

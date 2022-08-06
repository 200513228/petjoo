import 'package:flutter/material.dart';
import 'package:petjoo/modules/home/view/home_view.dart';
import 'package:petjoo/modules/store/view/store_list_view.dart';
import 'package:petjoo/modules/user/model/user_model.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_list_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_list_view.dart';
import 'package:petjoo/presentation/common/extra/extra_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('PETJOO'),
      ),
      body: Column(
        children: [
          const Expanded(flex: 3, child: Placeholder()),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                goButton(context, const AdvertListView(), 'Pet İlanları'),
                goButton(context, StoreListView(), 'Mağaza'),
                goButton(context, const TransportAdvertListView(),
                    'Pet Nakil İlanları'),
              ],
            ),
          ),
          userCard(context),
          const SizedBox(height: 0)
        ],
      ),
    );
  }

  Widget userCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 19),
      child: ListTile(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const ExtraView()));
          },
          leading: CircleAvatar(
            child: Text(CurrentUser.name != '' ? CurrentUser.name[0] : ''),
          ),
          title: Text(CurrentUser.name)),
    );
  }

  Widget goButton(BuildContext context, Widget page, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 70))),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeView(
                              pageView: page,
                              title: title,
                            )),
                    (route) => false);
              },
              child: Text(title)),
        ),
      ],
    );
  }
}

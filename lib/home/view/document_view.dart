import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DocumentView extends StatefulWidget {
  final String assetName;
  final List<Map> links;
  const DocumentView({required this.assetName, required this.links, Key? key})
      : super(key: key);

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  String data = '';
  @override
  void initState() {
    assetToString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: widget.links.isNotEmpty ? buildFab(context) : null,
    );
  }

  Widget buildBody() {
    return Container(
      padding: const EdgeInsets.all(18),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          )
        ],
      )),
    );
  }

  Widget buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Kaynaklar'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...widget.links.map(
                        (e) => TextButton(
                          onPressed: () {
                            launchUrlString(
                              e['link'],
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          child: Text(e['name']),
                        ),
                      )
                    ],
                  ),
                ));
      },
      label: Row(
        children: const [
          Icon(Icons.link, size: 32),
          SizedBox(width: 10),
          Text(
            'Kaynaklar',
            // style: TextStyle(fontSize: 10),
          )
        ],
      ),
    );
  }

  Future assetToString() async {
    data = await rootBundle.loadString('assets/docs/${widget.assetName}');
    setState(() {});
  }

  AppBar buildAppBar() {
    return AppBar(centerTitle: true, title: Text('Belge'.tr()));
  }
}

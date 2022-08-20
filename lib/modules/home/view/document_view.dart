import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DocumentView extends StatefulWidget {
  final String assetName;
  const DocumentView({required this.assetName, Key? key}) : super(key: key);

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
            style: const TextStyle(color: Colors.black),
          )
        ],
      )),
    );
  }

  Future assetToString() async {
    data = await rootBundle.loadString('assets/docs/${widget.assetName}');
    setState(() {});
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: widget.assetName == 'privacy_policy.txt'
          ? const Text('Gizlilik Sözleşmesi')
          : const Text('Kullanım Koşulları'),
    );
  }
}

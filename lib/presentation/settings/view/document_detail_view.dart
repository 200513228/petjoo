import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petjoo/core/base/state/state_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/docs.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';

class DocumentDetailView extends StatefulWidget {
  final String assetName;
  const DocumentDetailView(this.assetName, {Key? key}) : super(key: key);

  @override
  StateX<DocumentDetailView> createState() => _DocumentDetailViewState();
}

class _DocumentDetailViewState extends StateX<DocumentDetailView> {
  ValueNotifier<String?> source = ValueNotifier(null);

  String get getTitle {
    if (widget.assetName == Docs.termsOfUse) {
      return localization.termOfUse;
    } else if (widget.assetName == Docs.privacyPolicy) {
      return localization.privacyPolicy;
    } else {
      return "";
    }
  }

  @override
  void initState() {
    getSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
        child: Scaffold(
          appBar: AppBar(
            title: Text(getTitle),
          ),
          body: ValueListenableBuilder<String?>(
            valueListenable: source,
            builder: (context, value, child) => value == null
                ? const Loading()
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(Dimens.padding),
                    child: Text(value),
                  ),
          ),
        ),
      );

  void getSource() async {
    source.value = await rootBundle.loadString(widget.assetName);
  }
}

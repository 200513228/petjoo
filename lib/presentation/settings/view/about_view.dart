import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:petjoo/core/base/state/state_x.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/ui/widgets/separator.dart';

class AboutView extends StatefulWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  StateX<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends StateX<AboutView> {
  ValueNotifier<PackageInfo?> packageInfo = ValueNotifier(null);

  @override
  void initState() {
    PackageInfo.fromPlatform().then((value) => packageInfo.value = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(localization.about)),
        body: ValueListenableBuilder<PackageInfo?>(
            valueListenable: packageInfo,
            builder: (context, value, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: value == null
                      ? []
                      : [
                          Padding(
                              padding: const EdgeInsets.all(Dimens.padding),
                              child: Icon(Icons.pets_rounded,
                                  size: mediaQuery.size.width * .35, color: theme.colorScheme.surface)),
                          Text(
                            value.appName,
                            style: theme.textTheme.headline3?.copyWith(fontSize: 40),
                            textAlign: TextAlign.center,
                          ),
                          const Separator(size: Dimens.paddingSmall,),
                          Text(
                            value.version,
                            style: theme.textTheme.caption?.copyWith(fontSize: 14,color: theme.colorScheme.surface),
                            textAlign: TextAlign.center,
                          ),
                        ],
                )),
      );
}

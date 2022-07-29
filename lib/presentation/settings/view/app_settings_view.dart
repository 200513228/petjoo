import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/radio_tile.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/ui/widgets/subtitle.dart';
import '../../../../core/enums/languages.dart';
import '../../../../product/constants/dimens.dart';

class AppSettingsView extends StatefulWidget {
  const AppSettingsView({Key? key}) : super(key: key);

  @override
  State<AppSettingsView> createState() => _AppSettingsViewState();
}

class _AppSettingsViewState extends StateX<AppSettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.appSettings),
      ),
      body: Consumer(builder: (context, ref, child) {
        final provider = ref.watch(settingsProvider);
        return ListView(padding: const EdgeInsets.all(Dimens.padding), children: [
          Subtitle(localization.language),
          Container(
            margin: const EdgeInsets.symmetric(vertical: Dimens.padding),
            decoration: BoxDecoration(
              borderRadius: Dimens.radius.toBorderRadius(),
              color: theme.colorScheme.surface,
            ),
            child: Column(
              children: [
                RadioTile(
                  text: localization.english,
                  value: Languages.english,
                  groupValue: provider.language,
                  onChanged: provider.changeLanguage,
                ),
                RadioTile(
                  text: localization.turkish,
                  value: Languages.turkish,
                  groupValue: provider.language,
                  onChanged: provider.changeLanguage,
                ),
                RadioTile(
                  text: localization.german,
                  value: Languages.german,
                  groupValue: provider.language,
                  onChanged: provider.changeLanguage,
                ),
                RadioTile(
                  text: localization.system,
                  value: Languages.system,
                  groupValue: provider.language,
                  onChanged: provider.changeLanguage,
                ),
              ],
            ),
          ),
        ]);
      }),
    );
  }
}

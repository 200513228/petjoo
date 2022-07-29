import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/ui/tiles/settings_tile.dart';
import '../view_model/settings_view_model.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerStateX<SettingsView> {
  late final settingsViewModel = ChangeNotifierProvider.autoDispose((ref) => SettingsViewModel(context));
  late final viewModel = ref.read(settingsViewModel);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
        child: Scaffold(
          appBar: AppBar(title: Text(localization.settings)),
          body: ListView(padding: const EdgeInsets.all(Dimens.padding), children: [
            Visibility(
              visible: !FirebaseAuth.instance.currentUser!.isAnonymous,
              child: SettingsTile(
                icon: Icons.admin_panel_settings_rounded,
                title: localization.accountSettings,
                onTap: viewModel.accountSettings,
                margin: const EdgeInsets.only(top: Dimens.padding),
              ),
            ),
            SettingsTile(
              icon: Icons.settings_rounded,
              title: localization.appSettings,
              onTap: viewModel.appSettings,
              margin: const EdgeInsets.only(top: Dimens.padding),
            ),
            SettingsTile(
              icon: Icons.description_rounded,
              title: localization.termOfUse,
              onTap: viewModel.termsOfUse,
              margin: const EdgeInsets.only(top: Dimens.padding),
            ),
            SettingsTile(
              icon: Icons.privacy_tip_rounded,
              title: localization.privacyPolicy,
              onTap: viewModel.privacyPolicy,
              margin: const EdgeInsets.only(top: Dimens.padding),
            ),
            SettingsTile(
              icon: Icons.info_rounded,
              title: localization.about,
              onTap: viewModel.about,
              margin: const EdgeInsets.only(top: Dimens.padding),
            ),
          ]),
        ));
  }
}

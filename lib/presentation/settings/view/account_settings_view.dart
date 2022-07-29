import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/presentation/settings/view_model/account_settings_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';

import '../../../product/ui/tiles/settings_tile.dart';

class AccountSettingsView extends ConsumerStatefulWidget {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<AccountSettingsView> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends ConsumerStateX<AccountSettingsView> {
  late final accountSettingsViewModel = ChangeNotifierProvider.autoDispose((ref) => AccountSettingsViewModel(context, ref.read(userProvider)));
  late final viewModel = ref.read(accountSettingsViewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.accountSettings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimens.padding),
        children: [
          Consumer(builder: (context, ref, _) {
            final hasTransport = ref.watch(accountSettingsViewModel.select((value) => value.hasTransport));
            return SwitchListTile(
              tileColor: theme.colorScheme.surface,
              title: Text(localization.petTransport),
              subtitle: Text(localization.petTransportDescription),
              value: hasTransport,
              onChanged: viewModel.changeTransport,
            );
          }),
          SettingsTile(
            icon: Icons.person_remove_rounded,
            title: localization.deleteAccount,
            onTap: viewModel.deleteAccount,
            margin: const EdgeInsets.only(top: Dimens.padding),
          ),
        ],
      ),
    );
  }
}

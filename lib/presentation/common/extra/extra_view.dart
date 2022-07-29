import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/presentation/common/extra/extra_view_model.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/ui/tiles/settings_tile.dart';
import 'package:petjoo/product/ui/widgets/profile_container.dart';

class ExtraView extends ConsumerStatefulWidget {
  const ExtraView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<ExtraView> createState() => _ExtraViewState();
}

class _ExtraViewState extends ConsumerStateX<ExtraView> {
  late final extraViewModel = ChangeNotifierProvider.autoDispose((ref) => ExtraViewModel(context));
  late final viewModel = ref.read(extraViewModel);

  @override
  Widget build(BuildContext context) {
    final isAnonymous = FirebaseAuth.instance.currentUser?.isAnonymous == true;
    return Column(
      children: [
        const ProfileContainer(
          margin: EdgeInsets.only(top: Dimens.paddingSmall),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(Dimens.padding),
            children: [
              Visibility(
                  visible: !isAnonymous,
                  child: SettingsTile(
                    icon: Icons.person_rounded,
                    title: localization.profile,
                    onTap: viewModel.profile,
                    margin: const EdgeInsets.only(bottom: Dimens.padding),
                  )),
              Consumer(builder: (context, ref, _) {
                final hasTransport = ref.watch(userProvider.select((value) => value.user.hasTransport));
                return Visibility(
                  visible: hasTransport,
                  child: SettingsTile(
                    icon: MdiIcons.truck,
                    title: localization.myPetTransport,
                    onTap: () => context.pushNamed(Routes.transportAdvertDetailOwner),
                    margin: const EdgeInsets.only(bottom: Dimens.padding),
                  ),
                );
              }),
              SettingsTile(
                icon: Icons.settings_rounded,
                title: localization.settings,
                onTap: viewModel.settings,
                margin: const EdgeInsets.only(bottom: Dimens.padding),
              ),
              SettingsTile(
                icon: Icons.logout_rounded,
                title: localization.logout,
                showArrow: false,
                onTap: viewModel.signOut,
                margin: const EdgeInsets.only(bottom: Dimens.padding),
              )
            ],
          ),
        )
      ],
    );
  }
}

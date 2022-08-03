import 'package:badges/badges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:petjoo/core/extensions/build_context_extension.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/widgets/loading.dart';
import 'package:petjoo/presentation/common/navigation/navigation_view_model.dart';
import 'package:petjoo/infrastructure/repositories/advert_repository_impl.dart';
import 'package:petjoo/main.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import 'package:petjoo/product/constants/routes.dart';
import 'package:petjoo/product/services/dynamic_link_service.dart';
import 'package:petjoo/product/ui/widgets/bottom_navigation_bar_x.dart';

class NavigationView extends ConsumerStatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends ConsumerStateX<NavigationView> {
  late final navigationViewModel = ChangeNotifierProvider(
      (ref) => NavigationViewModel(context, AdvertRepositoryImpl()));
  late final viewModel = ref.read(navigationViewModel);

  @override
  void initState() {
    initializeDateFormatting();
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) context.pushNamed(Routes.chats);
      (Routes.chats);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final chatId = event.data['chatId'] as String?;
      final reservationId = event.data['reservationId'] as String?;
      if (chatId != null) {
        context.pushNamed(Routes.chats);
      } else if (reservationId != null) {
        if (ref.read(userProvider).user.hasTransport) {
          viewModel.jumpToPage(0);
        } else {
          context.pushNamed(Routes.reservationList);
        }
      }
    });
    FirebaseDynamicLinks.instance.onLink
        .listen(viewModel.checkDynamicLink)
        .onError((error) {
      // Handle errors
    });

    final initialLink = DynamicLinkService.instance.initialLink;
    if (initialLink != null) {
      viewModel.checkDynamicLink(initialLink);
      DynamicLinkService.instance.initialLink = null;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(navigationViewModel.select((value) => value.isLoading));
    final isAnonymous = FirebaseAuth.instance.currentUser?.isAnonymous == true;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toNavigationBar(
          theme.colorScheme.surface, Brightness.light),
      child: isLoading
          ? Loading(
              background: theme.colorScheme.surface,
            )
          : Scaffold(
              appBar: AppBar(
                title: getTitle(),
                automaticallyImplyLeading: false,
                actions: isAnonymous
                    ? []
                    : [
                        IconButton(
                          icon: Consumer(
                              child: const Icon(Icons.message_rounded),
                              builder: (context, ref, child) {
                                final unReadedChats = ref.watch(
                                    chatProvider.select(
                                        (value) => value.unReadedChatsCount));
                                return Badge(
                                    showBadge: unReadedChats > 0,
                                    position: BadgePosition.topEnd(end: -5),
                                    child: child);
                              }),
                          onPressed: () => context.pushNamed(Routes.chats),
                        )
                      ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: getFloatingActionButton(),
              body: Consumer(builder: (context, ref, child) {
                final hasUser =
                    ref.watch(userProvider.select((value) => value.hasUser));
                final isUserExist = ref
                    .watch(userProvider.select((value) => value.isUserExist));
                if (!isUserExist) viewModel.logout();
                return hasUser
                    ? PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: viewModel.pageController,
                        children: viewModel.pages,
                      )
                    : const Loading();
              }),
              bottomNavigationBar: Consumer(
                builder: (context, ref, child) {
                  final index = ref.watch(
                      navigationViewModel.select((value) => value.index));
                  return BottomNavigationBarX(
                    currentIndex: index,
                    onTap: viewModel.jumpToPage,
                    borderRadius: Dimens.radius.toTopBorderRadius(),
                    children: [
                      viewModel.hasTransport == true
                          ? Icons.notifications_rounded
                          : MdiIcons.truck,
                      Icons.pets_rounded,
                      Icons.menu_rounded,
                      Icons.store_rounded,
                    ],
                  );
                },
              ),
            ),
    );
  }

  getTitle() => Consumer(builder: ((context, ref, child) {
        switch (ref.watch(navigationViewModel.select((value) => value.index))) {
          case 0:
            return Text(viewModel.hasTransport == true
                ? localization.myReservationRequests
                : localization.transportAdverts);
          case 1:
            return Text(localization.adverts);
          case 2:
            return Text(localization.extra);
          default:
            return const Text("");
        }
      }));

  getFloatingActionButton() => Consumer(builder: (context, ref, _) {
        final hasTransport =
            ref.watch(userProvider.select((value) => value.hasTransport));
        switch (ref.watch(navigationViewModel.select((value) => value.index))) {
          case 0:
            return hasTransport
                ? FloatingActionButton.extended(
                    label: Text(localization.myReservationRequests),
                    onPressed: () =>
                        context.pushNamed(Routes.reservationRequestList),
                  )
                : FloatingActionButton.extended(
                    label: Text(localization.myReservations),
                    onPressed: () => context.pushNamed(Routes.reservationList),
                  );

          case 1:
            return FloatingActionButton.extended(
              label: Text(localization.myAdverts),
              onPressed: () => context.pushNamed(Routes.advertUserList),
            );
          default:
            return const SizedBox();
        }
      });
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petjoo/core/base/state/consumer_state_x.dart';
import 'package:petjoo/core/extensions/num_extension.dart';
import 'package:petjoo/core/widgets/button_x.dart';
import 'package:petjoo/product/constants/dimens.dart';
import 'package:petjoo/product/constants/overlay_styles.dart';
import '../view_model/tutorial_view_model.dart';

class TutorialView extends ConsumerStatefulWidget {
  const TutorialView({Key? key}) : super(key: key);

  @override
  ConsumerStateX<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends ConsumerStateX<TutorialView> {
  late final tutorialViewModel = ChangeNotifierProvider.autoDispose((ref) => TutorialViewModel(context));
  late final viewModel = ref.watch(tutorialViewModel);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: OverlayStyles.toAll(theme.scaffoldBackgroundColor, Brightness.dark),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: viewModel.pageController,
                children: List.generate(
                  5,
                  (index) => Center(
                    child: Image.asset(
                      'assets/images/tutorial.png',
                      width: mediaQuery.size.width * .6,
                    ),
                  ),
                ),
              ),
            ),
            ButtonX(
              width: double.maxFinite,
              color: theme.colorScheme.secondary,
              borderRadius: Dimens.radiusSmall.toBorderRadius(),
              margin: const EdgeInsets.all(Dimens.padding),
              onTap: viewModel.nextPage,
              child: Consumer(
                builder: (context, ref, _) {
                  final isLastPage = ref.watch(tutorialViewModel.select((value) => value.isLastPage));
                  return Text(
                    isLastPage ? localization.letsStart : localization.next,
                    textAlign: TextAlign.center,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

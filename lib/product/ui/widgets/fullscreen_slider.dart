import 'package:flutter/material.dart';

import '../../../core/base/state/state_x.dart';

class FullscreenSlider extends StatefulWidget {
  final int index;
  final List<String> images;
  const FullscreenSlider({Key? key, required this.images, required this.index}) : super(key: key);

  @override
  State<FullscreenSlider> createState() => _AdvertDetailFullScreenViewState();
}

class _AdvertDetailFullScreenViewState extends StateX<FullscreenSlider> {
  late final PageController pageController = PageController(initialPage: widget.index);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: pageController,
        itemCount: widget.images.length,
        itemBuilder: (context, index) => _tile(widget.images[index]),
      ),
    );
  }

  Widget _tile(String src) => Image.network(src); //InteractiveViewer(child: Image.network(src));
}

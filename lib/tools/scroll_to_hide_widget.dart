// ignore_for_file: unrelated_type_equality_checks

import 'tool_exports.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  const ScrollToHideWidget(
      {Key? key,
      required this.child,
      required this.controller,
      this.duration = const Duration(milliseconds: 200)})
      : super(key: key);

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHudeWidgetState();
}

class _ScrollToHudeWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = widget.controller.position.didUpdateScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      height: isVisible ? kBottomNavigationBarHeight : 0,
      child: Wrap(
        children: [widget.child],
      ),
    );
  }
}

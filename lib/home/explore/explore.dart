// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobileappconcorde/home/explore/display_products.dart';
import '../../style/colors.dart';
import 'explore_tools.dart';

class ExploreView extends StatefulWidget {
  ScrollController controller;
  ExploreView({Key? key, required this.controller}) : super(key: key);

  @override
  State<ExploreView> createState() => _Explore2ViewState();
}

class _Explore2ViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SafeArea(
          child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: CustomScrollView(
          slivers: <Widget>[
            appSliverAppBar(context),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Column(
                  children: [
                    DisplayProducts(controller: widget.controller),
                  ],
                );
              }, childCount: 1),
            )
          ],
        ),
      )),
    );
  }
}

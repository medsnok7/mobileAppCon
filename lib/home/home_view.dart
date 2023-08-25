// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:mobileappconcorde/home/profile/profile.dart';
import 'package:scroll_to_hide/scroll_to_hide.dart';

import '../style/colors.dart';
import 'explore/explore.dart';
import 'invoice_page/invoice_page.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  List<Widget> pages = [];
  late ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    pages = [
      ExploreView(
        controller: controller,
      ),
       InvoiceView(controller:controller),
      const ProfileView(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            child: ScrollToHide(
              scrollController: controller,
              height: 50,
              child: BottomNavigationBar(
                  currentIndex: currentIndex,
                  selectedItemColor: AppColors.selectedItemColor,
                  unselectedItemColor: AppColors.unselectedItemColor,
                  enableFeedback: true,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  iconSize: 20,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: AppColors.navigationBarColor,
                  elevation: 0,
                  onTap: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.explore,
                        ),
                        label: "explore"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.receipt,
                        ),
                        label: "invoices"),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                        ),
                        label: "profile"),
                  ]),
            ),
          ),
          body: pages[currentIndex],
        ),
      ),
    );
  }
}

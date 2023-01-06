import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:gift_app/helpers/color_helper.dart';
import 'package:gift_app/pages/add_page.dart';
import 'package:gift_app/pages/exchange_page.dart';
import 'package:gift_app/pages/give_page.dart';
import 'package:gift_app/widgets/app_bar.dart';

class ContainerPage extends StatefulWidget {
  const ContainerPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ContainerPage> createState() => _ContainerPageState();
}

class _ContainerPageState extends State<ContainerPage>
    with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  final iconList = <IconData>[
    Icons.card_giftcard,
    CommunityMaterialIcons.hand_heart,
  ];

  final navBottomBarTexts = <String>[
    "Echanges",
    "Dons",
  ];

  final pages = const <Widget>[
    ExchangePage(),
    GivePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        extendBody: true,
        appBar: getAppBar(widget.title),
        body: pages[_bottomNavIndex],
        floatingActionButton: FloatingActionButton(
          backgroundColor: myPurple,
          child: Icon(
            Icons.add_circle_outline,
            size: 50,
            color: myGrey,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddPage()),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: getBottomBar(),
      ),
    );
  }

  ///Navigation bar
  Widget getBottomBar() {
    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? myPurple : Colors.black;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index],
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AutoSizeText(
                navBottomBarTexts[index],
                maxLines: 1,
                style: TextStyle(color: color),
                group: autoSizeGroup,
              ),
            )
          ],
        );
      },
      backgroundColor: myGrey,
      activeIndex: _bottomNavIndex,
      splashColor: myPurple,
      splashSpeedInMilliseconds: 300,
      gapLocation: GapLocation.center,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() => _bottomNavIndex = index),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_oders/pages/acoount/account_page.dart';
import 'package:food_oders/pages/auth/sign_in_page.dart';
import 'package:food_oders/pages/auth/sign_up_page.dart';
import 'package:food_oders/pages/cart/cart_history.dart';
import 'package:food_oders/pages/home/main_food_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
     //use the persistent nav bar
    //  late PersistentTabController _controller;
  
   //create a list of pages that will be displayed when we click on bottomNavigation Icons
   int _selectedIndex = 0;
      List pages=[
        MainFoodPage(),
        Container(child: Center(child: Text("page history page")),),
        CartHistory(),
        AccountPage()
      ];

      //create a function that will be tapped and gives the index
      void onTapNav(int index){
       setState(() {
         _selectedIndex=index;
       });
      }

//u can use navigation bar plugin
      @override
 /* void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar:BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: true,
        backgroundColor: Colors.black,
        onTap: onTapNav,
        currentIndex: _selectedIndex,
        items: [
          //list item 1 home page
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_outlined),
            ),
          //list item 2 
          BottomNavigationBarItem(
            label: 'Cart',
            icon: Icon(Icons.archive),
            ),
            //list item 3
            BottomNavigationBarItem(
            label: 'History',
            icon: Icon(Icons.shopping_cart_rounded),
            ),
            //list item 4
            BottomNavigationBarItem(
            label: 'Me',
            icon: Icon(Icons.person),
            ),
        ],) ,
    );
  }
  /*
List<Widget> _buildScreens() {
        return [
        MainFoodPage(),
        Container(child:Center(child: Text("page 2"),),),
        Container(child:Center(child: Text("page 3"),),),
        Container(child:Center(child: Text("page 4"),),),
        ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.home),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.activeGreen,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.archivebox),
                title: ("History"),
                activeColorPrimary: CupertinoColors.activeGreen,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
                PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.cart_fill),
                title: ("Cart"),
                activeColorPrimary: CupertinoColors.activeGreen,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(CupertinoIcons.person_circle_fill),
                title: ("Me"),
                activeColorPrimary: CupertinoColors.activeGreen,
                inactiveColorPrimary: CupertinoColors.systemGrey,
            ),
        ];
    }
    
//new nav bar 
 @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
*/
}
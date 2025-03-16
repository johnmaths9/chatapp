import 'package:chatapp_2025/pages/contacts/contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../common/values/colors.dart';
import '../../calls/calls_page.dart';
import '../../stories/stories_page.dart';

Widget buildPage(int index) {
  List<Widget> _widget = [StoriesPage(), ContactsPage(), CallsPage()];

  return _widget[index];
}

AppBar buildAppBar(int index) {
  List<String> _titles = ['Stories', 'Chats', 'Calls'];

  return AppBar(
    centerTitle: true,
    foregroundColor: AppColors.primaryText,
    title: Text(_titles[index], style: TextStyle(color: AppColors.primaryText)),
    actions: [
      Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
            child: Icon(Icons.notifications, color: AppColors.primaryText),
          ),
          Positioned(
            top: 13,
            right: 2,
            child: Container(
              height: 15.h,
              width: 15.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: Text(
                  "1",
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(width: 5.w),
      PopupMenuButton<String>(
        icon: Icon(Icons.more_vert, color: AppColors.primaryText),
        onSelected: (String value) {
          // Handle the selected option
          print("Selected: $value");
        },
        itemBuilder:
            (BuildContext context) => [
              PopupMenuItem(
                onTap: () {
                  Navigator.pushNamed(context, "/new_user");
                },
                value: "New user",
                child: Text("New user"),
              ),
              PopupMenuItem(value: "Profile", child: Text("Profile")),
            ],
      ),

      SizedBox(width: 15.w),
    ],
  );
}

var bottomTabs = [
  /// Home
  SalomonBottomBarItem(
    icon: Icon(Icons.style, size: 16.w),
    title: Text("Stories"),
    selectedColor: AppColors.primaryColor,
  ),

  /// Likes
  SalomonBottomBarItem(
    icon: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'assets/icons/chat1.png',
            fit: BoxFit.cover,
            height: 16.h,
            width: 16.w,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 10.h,
            width: 10.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor,
            ),
            child: Center(
              child: Text(
                "1",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    ),
    title: Text("Chats"),
    selectedColor: AppColors.primaryColor,
    activeIcon: Image.asset(
      'assets/icons/chat1.png',
      height: 20.h,
      width: 20.w,
      color: AppColors.primaryColor,
    ),
  ),

  /// Search
  SalomonBottomBarItem(
    icon: Icon(Icons.call, size: 16.w),
    title: Text("Calls"),
    selectedColor: AppColors.primaryColor,
  ),
];

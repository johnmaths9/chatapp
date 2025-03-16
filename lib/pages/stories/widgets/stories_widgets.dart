import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

Widget addStoryWidget() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        height: 60.h,
        width: 60.w,
        child: Stack(
          children: [
            Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                //color: Colors.amber,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/icons/23.jpg"),
                ),
              ),
            ),
            _widgetAddIcon()
          ],
        ),
      ),
      SizedBox(
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //list item title
            _listContainer("My Stories", fontSize: 18),

            //list item description
            _listContainer("Tap to add",
                fontSize: 12, fontWeight: FontWeight.normal),
          ],
        ),
      )
    ],
  );
}

Widget _widgetAddIcon() {
  return Positioned(
    bottom: 0.h,
    right: 5.w,
    child: Container(
      height: 20.h,
      width: 20.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.h),
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: Icon(
          Icons.add,
          size: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget _listContainer(String text,
    {double fontSize = 13,
    Color color = AppColors.primaryText,
    FontWeight fontWeight = FontWeight.bold}) {
  return Container(
    width: 220.w,
    margin: EdgeInsets.only(left: 10.w),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: color,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget StoryContact() {
  return Container(
    padding: EdgeInsets.only(bottom: 10.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: BoxShape.circle,
          ),
          child: Align(
            alignment: AlignmentDirectional(0, 0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/icons/23.jpg"),
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //list item title
            _listContainer("Alina Finiti", fontSize: 16),
            SizedBox(
              height: 5,
            ),
            //list item description
            _listContainer("12:30 PM",
                fontSize: 12, fontWeight: FontWeight.normal),
          ],
        ),
      ],
    ),
  );
}

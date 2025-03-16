import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

Widget tabBarWidget({TabController? controller}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 60.w, vertical: 20.h),
    child: TabBar(
      indicator: BoxDecoration(
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, spreadRadius: 1, blurRadius: 1)
        ],
        borderRadius: BorderRadius.circular(5.w),
      ),
      dividerColor: AppColors.primaryColor,
      labelPadding: EdgeInsets.symmetric(vertical: 8.h),
      controller: controller,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black54,
      tabs: [
        Container(
          child: Text('All'),
        ),
        Container(
          child: Text('Missed'),
        ),
      ],
    ),
  );
}

Widget buildAllCalls() {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                //color: Colors.amber,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/icons/23.jpg"),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //list item title
                      _listContainer("Alina Finiti", fontSize: 16),
                      //list item description
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.call,
                            size: 15,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Incoming",
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "3m, 25s",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "03:46 PM",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    },
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

Widget buildMissedCalls() {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                //color: Colors.amber,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/icons/23.jpg"),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //list item title
                      _listContainer("Alina Finiti", fontSize: 16),
                      //list item description
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Icon(
                            Icons.call,
                            size: 15,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "Missed",
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "03:46 PM",
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    },
  );
}

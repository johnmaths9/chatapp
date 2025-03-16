import 'package:chatapp_2025/common/routes/names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSearch() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
    height: 50.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.w)),
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.grey.shade100, spreadRadius: 1, blurRadius: 1),
      ],
    ),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade100.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(15.w)),
        border: Border.all(color: Colors.blue.shade100.withOpacity(0.2)),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Avenir",
          fontWeight: FontWeight.normal,
          fontSize: 14.sp,
        ),
        decoration: const InputDecoration(
          hintText: "Search Name Or number phone",
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    ),
  );
}

Widget buildContacts() {
  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 10,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.CHATPAGE);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 55.h,
                width: 55.w,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        //color: Colors.amber,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/icons/23.jpg"),
                        ),
                      ),
                    ),
                    _widgetOnline(),
                  ],
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
                        _listContainer(
                          "Hello, i'am Alina Finiti nice to meet you 🥰",
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "03:46 PM",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Icon(Icons.done_all, size: 15, color: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _widgetOnline() {
  return Positioned(
    bottom: 0.h,
    right: 5.w,
    child: Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.h),
        color: Colors.green,
      ),
    ),
  );
}

Widget _listContainer(
  String text, {
  double fontSize = 13,
  Color color = Colors.black54,
  FontWeight fontWeight = FontWeight.bold,
}) {
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

import 'package:chatapp_2025/pages/chat/widgets/triangle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';

AppBar buildAppBar() {
  return AppBar(
    iconTheme: IconThemeData(color: AppColors.primaryColor),
    bottom: PreferredSize(
      child: Container(
        color: AppColors.primaryColor.withOpacity(0.2),
        height: 1,
      ),
      preferredSize: const Size.fromHeight(1),
    ),
    //centerTitle: true,
    title: Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
            //color: Colors.amber,
            shape: BoxShape.circle,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/icons/23.jpg"),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Alina Finiti",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "online",
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 11.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    ),
    actions: [
      Image.asset(
        "assets/icons/video_call.png",
        height: 18.h,
        width: 18.w,
        fit: BoxFit.contain,
      ),
      SizedBox(width: 15.w),
      Image.asset(
        "assets/icons/phone.png",
        height: 18.h,
        width: 18.w,
        fit: BoxFit.contain,
      ),
      SizedBox(width: 15.w),
    ],
  );
}

Widget createMessageInputComponent(context, TextEditingController controller) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      border: Border.all(color: Colors.grey),
      boxShadow: [],
    ),
    margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w),
              color: Colors.white,
            ),
            child: Row(
              //mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  width: 20,
                  height: 20,
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "send a message",
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 18,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Button(Icons.photo_camera_outlined),
                Text(
                  "|",
                  style: TextStyle(fontSize: 25.sp, color: Colors.grey),
                ),
                controller.text.isEmpty
                    ? Button(Icons.mic_none)
                    : Button(Icons.send),
              ],
            ),
          ),
        ),
        //SendButton()
      ],
    ),
  );
}

Widget Button(IconData icon) {
  return IconButton(
    color: Colors.grey,
    icon: Icon(icon),
    onPressed: () {
      //
    },
  );
}

Widget SendButton() {
  return Container(
    margin: EdgeInsets.only(left: 5.w),
    width: 45.w,
    height: 45.h,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.primaryColor,
    ),
    child: Icon(Icons.send, color: Colors.white, size: 24),
  );
}

Widget MessageTextWidget(String message, bool isMe) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    constraints: BoxConstraints(maxWidth: 280),
    child: Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMe
            ? Container()
            : CustomPaint(painter: Triangle(Colors.grey.shade300)),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isMe ? AppColors.primaryColor : Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: isMe ? Radius.circular(10) : Radius.zero,
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: isMe ? Radius.zero : Radius.circular(10),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : AppColors.primaryText,
                fontFamily: 'Monstserrat',
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
        isMe
            ? CustomPaint(painter: Triangle(AppColors.primaryColor))
            : Container(),
      ],
    ),
  );
}

class Message {
  final String text;
  final DateTime date;
  final bool isMe;

  Message({required this.text, required this.date, required this.isMe});
}

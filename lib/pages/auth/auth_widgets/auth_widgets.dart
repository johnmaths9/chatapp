import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/values/colors.dart';
import '../../../common/widgets/update_profile_pic_model_bottom_sheet.dart';

Widget DefaultButton({required String text, required VoidCallback onPress}) {
  return SizedBox(
    width: double.infinity,
    height: 45,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPress,
      child: Text(text, style: TextStyle(color: Colors.white)),
    ),
  );
}

Widget loginphotoURL(BuildContext context) {
  return GestureDetector(
    onTap: () {
      showUpdatephotoURLModelBottomSheet(context);
    },
    child: Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.add_a_photo, size: 35.sp, color: Colors.white),
    ),
  );
}

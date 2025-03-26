import 'package:chatapp_2025/common/values/colors.dart';
import 'package:chatapp_2025/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:chatapp_2025/pages/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/routes/names.dart';

class LoginProfileUserScreen extends StatefulWidget {
  const LoginProfileUserScreen({super.key});

  @override
  State<LoginProfileUserScreen> createState() => _LoginProfileUserScreenState();
}

class _LoginProfileUserScreenState extends State<LoginProfileUserScreen> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is SaveUserDataToFirebaseLoadingState) {
                  Navigator.popAndPushNamed(context, AppRoutes.INITIAL);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    Text(
                      "Profile Info",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Text(
                      "Please provide yuor name and an optional \n profile photo",
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.h),
                    loginphotoURL(context),
                    SizedBox(height: 40.h),
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.h),
                        border: Border.all(color: AppColors.primaryText),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.emoji_emotions_outlined,
                            color: AppColors.primaryText,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TextField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "type your name here",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    DefaultButton(
                      text: "Finish",
                      onPress: () {
                        context.read<AuthBloc>().add(
                          SaveUserDataToFirebase(name: nameController.text),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

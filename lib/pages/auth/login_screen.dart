import 'package:chatapp_2025/common/routes/names.dart';
import 'package:chatapp_2025/common/values/colors.dart';
import 'package:chatapp_2025/pages/auth/auth_widgets/auth_widgets.dart';
import 'package:chatapp_2025/pages/auth/bloc/auth_bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 25.w, right: 25.w),
          alignment: Alignment.center,
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignInSuccessState) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.VERIFY,
                  arguments: phoneController.text.trim(),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/icons/an1.json',
                      width: 200.w,
                      height: 200.h,
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      "Your Phone",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Please confirm your country code and enter your phone number",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.primaryText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50.h),
                    Container(
                      height: 55.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10.w),
                          GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode:
                                    true, // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  setState(() {
                                    countryController.text =
                                        '+' + country.phoneCode;
                                  });
                                },
                              );
                            },
                            child: SizedBox(
                              width: 40.w,
                              child: TextField(
                                textAlign: TextAlign.center,
                                enabled: false,
                                controller: countryController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                              fontSize: 33.sp,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    DefaultButton(
                      text: "Send the code",
                      onPress: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          SignInWithPhoneNumber(
                            phone:
                                countryController.text + phoneController.text,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/*await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber:
                              countryController.text + phoneController.text,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.pushNamed(context, AppRoutes.VERIFY);
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );*/

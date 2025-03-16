import 'package:chatapp_2025/common/repositories/auth/auth_repos.dart';
import 'package:chatapp_2025/common/routes/names.dart';
import 'package:chatapp_2025/common/service/auth_service.dart';
import 'package:chatapp_2025/global.dart';
import 'package:chatapp_2025/pages/application/bloc/app_bloc.dart';
import 'package:chatapp_2025/pages/auth/bloc/auth_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/routes/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBloc()),
        BlocProvider(
          create:
              (context) => AuthBloc(
                authRepository: AuthRepository(
                  authService: AuthService(
                    auth: FirebaseAuth.instance,
                    firestore: FirebaseFirestore.instance,
                    firebaseStorage: FirebaseStorage.instance,
                  ),
                  storageService: Global.storageService,
                ),
              ),
        ),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: Size(375, 812),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 0,
                backgroundColor: Colors.white,
              ),
            ),
            //home: const ApplicationPage(),
            initialRoute: AppRoutes.LOGIN,
            onGenerateRoute: AppPages.generateRouteSettings,
          );
        },
      ),
    );
  }
}

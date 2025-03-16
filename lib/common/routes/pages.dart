import 'package:chatapp_2025/common/routes/names.dart';
import 'package:chatapp_2025/pages/auth/login_profile_user.dart';
import 'package:chatapp_2025/pages/auth/login_screen.dart';
import 'package:chatapp_2025/pages/auth/verify_page.dart';
import 'package:chatapp_2025/pages/chat/chat_page.dart';
import 'package:chatapp_2025/pages/user/new_user_page.dart';
import 'package:flutter/material.dart';

import '../../pages/application/application_page.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.INITIAL,
        page: const ApplicationPage(),
        //bloc: BlocProvider(create: (_) => WelcomeBloc()),
      ),
      PageEntity(
        route: AppRoutes.LOGIN,
        page: const LoginScreen(),
        //bloc: BlocProvider(create: (_) => SigninBloc()),
      ),
      PageEntity(
        route: AppRoutes.VERIFY,
        page: const VerifyPage(),
        //bloc: BlocProvider(create: (_) => RegisterBloc()),
      ),
      PageEntity(
        route: AppRoutes.CHATPAGE,
        page: const ChatPage(),
        //bloc: BlocProvider(create: (_) => RegisterBloc()),
      ),
      PageEntity(
        route: AppRoutes.PROFILE_INFO,
        page: const LoginProfileUserScreen(),
        //bloc: BlocProvider(create: (_) => RegisterBloc()),
      ),
      PageEntity(
        route: AppRoutes.NEW_USER,
        page: const NewUserPage(),
        //bloc: BlocProvider(create: (_) => RegisterBloc()),
      ),
    ];
  }

  //return all the bloc providers
  /*static List<dynamic> allBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      blocProviders.add(bloc.bloc);
    }
    return blocProviders;
  }*/

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    print(settings.name);
    if (settings.name != null) {
      //check for route name
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
          builder: (_) => result.first.page,
          settings: settings,
        );
      }
    }
    print(settings.name);
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
      settings: settings,
    );
  }
}

// Blocs & Routes & Pages
class PageEntity {
  String route;
  Widget page;
  //dynamic bloc;

  PageEntity({required this.route, required this.page});
}

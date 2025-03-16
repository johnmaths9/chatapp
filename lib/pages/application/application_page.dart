import 'package:chatapp_2025/pages/application/widgets/application_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'bloc/app_bloc.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: buildAppBar(state.index),
            drawer: Drawer(),
            backgroundColor: Colors.white,
            body: buildPage(state.index),
            bottomNavigationBar: Container(
              height: 80.h,
              margin: EdgeInsets.symmetric(horizontal: 25.w),
              child: SalomonBottomBar(
                backgroundColor: Colors.white,
                currentIndex: state.index,
                onTap: (i) => context.read<AppBloc>().add(TriggerAppEvent(i)),
                items: bottomTabs,
              ),
            ),
          ),
        );
      },
    );
  }
}

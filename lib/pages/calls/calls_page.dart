import 'package:chatapp_2025/pages/calls/widgets/calls_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({super.key});

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 20.h),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                tabBarWidget(controller: tabController),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [buildAllCalls(), buildMissedCalls()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

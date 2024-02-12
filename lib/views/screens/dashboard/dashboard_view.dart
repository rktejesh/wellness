import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_drawer.dart';
import 'package:wellness/views/screens/dashboard/circular_icon_button.dart';
import 'package:wellness/views/screens/instructions/timer_screen.dart';
import 'package:wellness/views/screens/test/test_dashboard.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF884ad1), Color.fromARGB(255, 123, 64, 189)])),
      child: Scaffold(
        appBar: AppBar(),
        drawer: customDrawer(context),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(
                      Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                  child: SvgPicture.asset(
                    'assets/svg/logo.svg',
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: FittedBox(
                        child: CircularIconButton(
                          iconPath: "assets/images/test.png",
                          label: "TEST",
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TestDashboard()));
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: FittedBox(
                        child: CircularIconButton(
                            iconPath: "assets/images/track.png",
                            label: "TRACK",
                            onPressed: () {}),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.height * 0.2,
                      child: FittedBox(
                        child: CircularIconButton(
                            iconPath: "assets/images/shop.png",
                            label: "SHOP",
                            onPressed: () {}),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

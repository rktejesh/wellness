import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/image.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/screens/dashboard/circular_icon_button.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0070bc), Color(0xFF015a9f)])),
      child: Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('My Horses'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                },
              ),
            ],
          ),
        ),
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
                                builder: (context) => const ImageUpload()));
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

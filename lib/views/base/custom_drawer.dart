import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/rdttesting/rdt_screen_tests.dart';
import 'package:wellness/views/screens/horse/horse.dart';
import 'package:wellness/views/screens/profile/profile.dart';
import 'package:wellness/views/screens/test/test_list.dart';

Widget customDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Color(0xFF884ad1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            child: Image.asset(
              'assets/images/logo.png',
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
        ),
        ListTile(
          title: const Text('Profile'),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ProfileCard()));
          },
        ),
        ListTile(
          title: const Text('My Tests'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const TestListScreen()));
          },
        ),
        ListTile(
          title: const Text('My Horses'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HorseListScreen()));
          },
        ),
        // These are here for testing purposes only to test C++
        // code of PixelMatching for different image formats
        // ListTile(
        //   title: const Text('RDT Screen Tests'),
        //   onTap: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => const RDTScreenTests()));
        //   },
        // ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            BlocProvider.of<AuthBloc>(context).add(LoggedOut());
          },
        ),
      ],
    ),
  );
}

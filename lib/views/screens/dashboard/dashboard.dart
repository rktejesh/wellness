import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/image.dart';
import 'package:wellness/utils/dimensions.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0070bc), Color(0xFF015a9f)])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
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
                        child: FloatingActionButton.large(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const ImageUpload()));
                          },
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: Image.asset(
                                  "assets/images/test.png",
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Text(
                                'TEST',
                                style: TextStyle(
                                    color: Color(0xFF0070bc),
                                    fontSize: Dimensions.fontSizeDefault),
                              )
                            ],
                          ),
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
                        fit: BoxFit.fill,
                        child: FloatingActionButton.large(
                          onPressed: () {},
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/track.png",
                                width:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                'TRACK',
                                style: TextStyle(
                                    color: const Color(0xFF0070bc),
                                    fontSize: Dimensions.fontSizeExtraSmall),
                              )
                            ],
                          ),
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
                        child: FloatingActionButton.large(
                          onPressed: () {},
                          shape: const CircleBorder(),
                          backgroundColor: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: Image.asset(
                                  "assets/images/shop.png",
                                  width:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ),
                              Text(
                                'SHOP',
                                style: TextStyle(
                                    color: const Color(0xFF0070bc),
                                    fontSize: Dimensions.fontSizeExtraSmall),
                              )
                            ],
                          ),
                        ),
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

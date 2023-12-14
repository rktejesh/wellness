import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/blocs/auth/auth_bloc.dart';
import 'package:wellness/blocs/dashboard/dashboard_bloc.dart';
import 'package:wellness/views/screens/dashboard/dashboard_view.dart';
import 'package:wellness/views/screens/register/register_form.dart';
import 'package:wellness/views/screens/register/register_form_selection.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(DashboardFetchData()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DashboardLoaded) {
            if (state.data == "NA") {
              return const RegistrationFormSelection();
            } else {
              return const DashboardView();
            }
          } else if (state is DashboardFailure) {
            /// TODO
            return Scaffold(
                appBar: AppBar(),
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Text(''),
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
                body: Container());
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

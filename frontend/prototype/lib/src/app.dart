import 'package:flutter/material.dart';
import 'login/login_view.dart';
import 'unit_search/unit_search_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      // Define the named route for LoginView
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case UnitSearchView.routeName:
                return const UnitSearchView();
              default:
                return const LoginView();  // Default to LoginView
            }
          },
        );
      },
    );
  }
}
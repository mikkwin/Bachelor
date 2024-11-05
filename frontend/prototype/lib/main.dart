import 'package:flutter/material.dart';
import 'package:prototype/src/post_mortem/post_mortem_provider.dart';
import 'package:provider/provider.dart';

import 'src/app.dart';

void main() async {

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PostMortemProvider())
    ],
    child: MyApp(),
    )
    );
}

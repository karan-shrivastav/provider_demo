import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapi/providers/album_provider.dart';
import 'package:taskapi/providers/create_user_provider.dart';
import 'package:taskapi/providers/photos_provider.dart';
import 'package:taskapi/providers/user_provider.dart';
import 'package:taskapi/view/screens/my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AlbumProvider()),
        ChangeNotifierProvider(create: (_) => PhotosProvider()),
        ChangeNotifierProvider(create: (_) => CreateUserProvider()),

      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

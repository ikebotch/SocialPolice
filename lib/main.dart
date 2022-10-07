import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialpolice/src/providers/services_prov.dart';
import 'package:socialpolice/src/res/dimens.dart';
import 'package:socialpolice/src/ui/splash.dart';
import 'package:socialpolice/src/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Chat'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Dimens().init(context);
    Constants.init(isTest: true);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ServicesProv>(
          create: (_) => ServicesProv(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}

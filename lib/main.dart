import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialpolice/src/providers/services_prov.dart';
import 'package:socialpolice/src/res/dimens.dart';
import 'package:socialpolice/src/settings/secured_storage.dart';
import 'package:socialpolice/src/ui/splash.dart';
import 'package:socialpolice/src/utils/constants.dart';

List<CameraDescription> cameras = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
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
  final SecuredStorage _sec = SecuredStorage();
  @override
  Widget build(BuildContext context) {
    Dimens().init(context);
    Constants.init(isTest: true);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ServicesProv>(
          create: (_) => ServicesProv(),
        ),
        Provider<SecuredStorage>(create: (_) => _sec),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splash(),
      ),
    );
  }
}

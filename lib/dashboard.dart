import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Activities"),
        leading: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(image: AssetImage('assets/images/glogo.png')),
        ),
      ),
    );
  }
}

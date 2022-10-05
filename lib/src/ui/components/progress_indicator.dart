
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppProgressIndicator extends StatelessWidget {
  final double? width;
  final Color? color;

  const AppProgressIndicator({Key? key, this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator();
  }
}

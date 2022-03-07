import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key, required this.accessToken})
      : super(key: key);
  final String accessToken;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(accessToken),
    );
  }
}

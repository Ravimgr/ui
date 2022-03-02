import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xyba/widgets/custom_clipper.dart';
import 'package:xyba/widgets/custom_toggle_button.dart';
import 'package:xyba/widgets/log_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: HomeBodyScreen(
        context: context,
        customWidget: const AuthCard(),
      ),
    );
  }
}

class HomeBodyScreen extends StatefulWidget {
  const HomeBodyScreen({
    Key? key,
    required this.context,
    required this.customWidget,
  }) : super(key: key);

  final BuildContext context;
  final Widget customWidget;

  @override
  _HomeBodyScreenState createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/xyba_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(children: [
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  HexColor('#7B44A2'),
                  HexColor('#7B44A3'),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 100,
              child: Image.asset('assets/images/xyba_logo 1.png')),
        ),
        Positioned(
          child: widget.customWidget,
          top: 160,
          right: 10,
          left: 10,
        ),
        Positioned(
            child: IconToggleButton(
              isSelected: isSelected,
              onPressed: () {
                setState(
                  () {
                    isSelected = !isSelected;
                  },
                );
              },
            ),
            left: 15,
            bottom: 8),
      ]),
    );
  }
}

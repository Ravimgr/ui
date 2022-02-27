import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xyba/widgets/card.dart';
import 'package:xyba/widgets/custom_clipper.dart';
import 'package:xyba/widgets/custom_toggle_button.dart';

class OtpandForgetPassword extends StatefulWidget {
  const OtpandForgetPassword({Key? key, required this.cardmode})
      : super(key: key);

  final Cardmode cardmode;

  @override
  _OtpandForgetPasswordState createState() => _OtpandForgetPasswordState();
}

class _OtpandForgetPasswordState extends State<OtpandForgetPassword> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/xyba_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
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
              child: CustomCard(
                cardmode: widget.cardmode,
              ),
              top: 160,
              right: 10,
              left: 10,
              bottom: 360,
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
                top: 700,
                left: 15,
                right: 280,
                bottom: 8),
          ],
        ),
      ),
    );
  }
}

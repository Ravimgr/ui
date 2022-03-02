import 'package:flutter/material.dart';
import 'package:xyba/ui/homepage.dart';
import 'package:xyba/widgets/card.dart';

class OtpandForgetPassword extends StatelessWidget {
  const OtpandForgetPassword({Key? key, required this.cardmode})
      : super(key: key);

  final Cardmode cardmode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: HomeBodyScreen(
            context: context,
            customWidget: CustomCard(
              cardmode: cardmode,
            )));
  }
}

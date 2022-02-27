import 'package:flutter/material.dart';

enum Cardmode {
  otpVerify,
  forgetPassword,
}

class CustomCard extends StatefulWidget {
  CustomCard({Key? key, this.cardmode}) : super(key: key);

  Cardmode? cardmode;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.indigo[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 8.0,
      child: Container(
        height: deviceSize.height * 0.3,
        width: deviceSize.width * 0.8,
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                    widget.cardmode == Cardmode.forgetPassword
                        ? "Forget Password"
                        : "OTP Verification",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo[900])),
                const SizedBox(height: 10.0),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: widget.cardmode == Cardmode.forgetPassword
                        ? "Enter your mobile number "
                        : "Enter 6 digits OTP code here",
                    labelStyle: TextStyle(
                      color: Colors.indigo[900],
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return widget.cardmode == Cardmode.forgetPassword
                          ? "Please enter your mobile number"
                          : "Please enter 6 digits OTP code";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 50),
                    primary: const Color.fromRGBO(105, 49, 142, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                      widget.cardmode == Cardmode.forgetPassword
                          ? "Confirm Number"
                          : "Verify OTP",
                      style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            )),
      ),
    );
  }
}

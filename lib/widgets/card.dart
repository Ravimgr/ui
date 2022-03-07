import 'package:flutter/material.dart';
import 'package:xyba/network/api_client.dart';
import 'package:xyba/ui/homepage.dart';

enum Cardmode {
  otpVerify,
  forgetPassword,
}

class CustomCard extends StatefulWidget {
  CustomCard({Key? key, this.cardmode, this.deviceId, this.userId})
      : super(key: key);

  Cardmode? cardmode;
  String? deviceId;
  String? userId;

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _controller = TextEditingController();
  final ApiClient _apiClient = ApiClient();

  Future<void> verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Processing Data'),
          backgroundColor: Colors.green.shade300,
        ));
        dynamic res = await _apiClient.verifyOtp(
          _controller.text,
          widget.deviceId.toString(),
          widget.userId.toString(),
        );

        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        if (res['token'] != null) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${res['msg']}'),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('user:${widget.userId}');
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
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: widget.cardmode == Cardmode.forgetPassword
                        ? "Enter your mobile number "
                        : "Enter 4 digits OTP code here",
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
                          : "Please enter 4 digits OTP code";
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
                    verifyOtp();
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

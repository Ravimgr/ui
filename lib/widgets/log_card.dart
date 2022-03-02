import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xyba/ui/verification.dart';
import 'package:xyba/widgets/card.dart';
import 'package:xyba/widgets/custom_dropdown_button.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscurec = true;
  AuthMode _authMode = AuthMode.login;

  final _specialityfNode = FocusNode();
  final _dropdownfNode = FocusNode();
  final _mobilefNode = FocusNode();
  final _passwordfNode = FocusNode();
  final _confirmPasswordfNode = FocusNode();

  // Initial Selected Value
  String dropdownvalue = 'Item 1';
  int labled = 0;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
        width: deviceSize.width * 0.75,
        height: deviceSize.height * 0.65,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ToggleSwitch(
                  minHeight: 45,
                  minWidth: MediaQuery.of(context).size.width * 0.4,
                  cornerRadius: 20.0,
                  activeBgColors: const [
                    [Color.fromRGBO(105, 49, 142, 1)],
                    [Color.fromRGBO(105, 49, 142, 1)],
                  ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.white,
                  inactiveFgColor: Colors.black,
                  initialLabelIndex: labled,
                  totalSwitches: 2,
                  labels: const ['Login', 'Sign Up'],
                  radiusStyle: true,
                  onToggle: (v) {
                    setState(() {
                      _authMode = _authMode == AuthMode.login
                          ? AuthMode.signup
                          : AuthMode.login;
                    });
                    if (v == 0) {
                      labled = 0;
                      _authMode = AuthMode.login;
                    }
                    if (v == 1) {
                      labled = 1;
                      _authMode = AuthMode.signup;
                    }
                  },
                ),
                const SizedBox(height: 10.0),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    enabled: _authMode == AuthMode.signup,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name!';
                      }
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_dropdownfNode);
                    },
                  ),
                if (_authMode == AuthMode.signup)
                  CustomDropDownwithText(
                    value: dropdownvalue,
                    items: items,
                    focusNode: _dropdownfNode,
                  ),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Speciality",
                    ),
                    focusNode: _specialityfNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_mobilefNode);
                    },
                  ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || value.length != 10) {
                      return 'Invalid Number!';
                    }
                    return null;
                  },
                  focusNode: _mobilefNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordfNode);
                  },
                ),
                TextFormField(
                  textInputAction: _authMode == AuthMode.signup
                      ? TextInputAction.next
                      : TextInputAction.done,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: const Color.fromRGBO(105, 49, 142, 1),
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      )),
                  obscureText: _isObscure,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  focusNode: _passwordfNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_confirmPasswordfNode);
                  },
                ),
                if (_authMode == AuthMode.login) const SizedBox(height: 30.0),
                if (_authMode == AuthMode.login)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forget password?',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      TextButton(
                        child: const Text(
                          'Click here',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(105, 49, 142, 1)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const OtpandForgetPassword(
                                        cardmode: Cardmode.forgetPassword,
                                      )));
                        },
                      ),
                    ],
                  ),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscurec
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color.fromRGBO(105, 49, 142, 1),
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscurec = !_isObscurec;
                            });
                          },
                        )),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match!';
                      }
                      return null;
                    },
                  ),
                const SizedBox(
                  height: 20,
                ),
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
                    _authMode == AuthMode.signup
                        ? Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                            return const OtpandForgetPassword(
                                cardmode: Cardmode.otpVerify);
                          }))
                        : '';
                  },
                  child: Text(
                    _authMode == AuthMode.login ? 'Login' : 'Sign Up',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

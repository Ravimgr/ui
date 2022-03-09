import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xyba/network/api_client.dart';
import 'package:xyba/ui/dashboard.dart';
import 'package:xyba/ui/homepage.dart';
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
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _specialityController = TextEditingController();

  bool _isObscure = true;
  bool _isObscurec = true;
  AuthMode _authMode = AuthMode.login;

  final _specialityfNode = FocusNode();
  final _dropdownfNode = FocusNode();
  final _mobilefNode = FocusNode();
  final _passwordfNode = FocusNode();
  final _confirmPasswordfNode = FocusNode();

  // Initial Selected Value
  String dropdownvalue = 'Consultant';
  int labled = 0;
  late String accessToken;

  final ApiClient _apiClient = ApiClient();

  late String deviceID;
  late String userId;
  // List of items in our dropdown menu
  var items = [
    'Consultant',
    'Resident',
    'Medical Officer',
    'Nurse',
  ];
  Future<void> loginFunc() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));
      dynamic res = await _apiClient.loginUser(
        _emailController.text,
        "12345",
        _passwordController.text,
      );
      deviceID = res['device_id'].toString();
      userId = res['user'].toString();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res['isNumberVerified'] == true) {
        accessToken = res['token'].toString();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashBoardScreen(
                      accessToken: accessToken,
                    )));
      }
      if (res['isNumberVerified'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['msg']}'),
          backgroundColor: Colors.red.shade300,
        ));
        dynamic respo = await _apiClient.resendOtp(
          _emailController.text,
        );
        if (respo['isOTPSent'] == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpandForgetPassword(
                        cardmode: Cardmode.otpVerify,
                        deviceID: deviceID,
                        userId: userId,
                      )));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['msg']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  Future<void> registerFunc() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      Map<String, dynamic> userData = {
        "email": _emailController.text,
        "password": _passwordController.text,
        'name': _nameController.text,
        'is_verify': 'false',
        'qualification': dropdownvalue,
        'device_id': '12345',
        'contact_number': _emailController.text,
        'dob': '2 march 1989',
        'role': '2',
        'speciality': _specialityController.text,
        'userType': dropdownvalue
      };

      dynamic res = await _apiClient.registerUser(userData);
      deviceID = res['device_id'].toString();
      userId = res['user_id'].toString();

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (res['isOTPSent'] == true) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return OtpandForgetPassword(
            cardmode: Cardmode.otpVerify,
            deviceID: deviceID,
            userId: userId,
          );
        }));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['msg']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

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
                    controller: _nameController,
                    enabled: _authMode == AuthMode.signup,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    keyboardType: TextInputType.text,
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
                    onChanged: (String? newValue) {
                      dropdownvalue = newValue!;
                      print(dropdownvalue);
                    },
                  ),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    controller: _specialityController,
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
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Mobile Number'),
                  keyboardType: TextInputType.number,
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
                                  builder: (context) => OtpandForgetPassword(
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
                    _authMode == AuthMode.signup ? registerFunc() : loginFunc();
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

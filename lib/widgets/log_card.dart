import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  bool _isObscure = true;

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

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
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        width: deviceSize.width * 0.75,
        height: deviceSize.height * 0.5,
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
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: const ['Login', 'Sign Up'],
                  radiusStyle: true,
                  onToggle: (index) {
                    //print('switched to: $index');
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Full Name'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "I am a",
                    suffix: DropdownButton(
                      style: const TextStyle(color: Colors.deepPurple),
                      value: dropdownvalue,
                      items: items.map((String item) {
                        return DropdownMenuItem(
                          alignment: Alignment.centerLeft,
                          child: Text(item),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                          //print(dropdownvalue);
                        });
                      },
                    ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Mobile Number or E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
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
                ),
                const SizedBox(height: 20.0),
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
                      onPressed: () {},
                    ),
                  ],
                ),

                // TextFormField(
                //   decoration:
                //       const InputDecoration(labelText: 'Confirm Password'),
                //   obscureText: true,
                //   validator: (value) {
                //     if (value != _passwordController.text) {
                //       return 'Passwords do not match!';
                //     }
                //     return null;
                //   },
                // ),
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
                  onPressed: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
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

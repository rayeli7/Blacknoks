import 'package:flutter/material.dart';
import 'package:blacknoks/ui/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({Key? key}) : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  var _emailController;
  var _passwordController;
  bool isChecked = true;

    @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SharedPreferences.getInstance().then(
                    (prefs) {
                    prefs.setBool("remember_me", isChecked);                   
                    prefs.setString('email', _emailController.text);                   
                    prefs.setString('password', _passwordController.text);
                    },
                    );
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isChecked ? primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
          border: isChecked ? null : Border.all(color: textGrey, width: 1.5),
        ),
        width: 20,
        height: 20,
        child: isChecked
            ? const Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  //load email and password
void _loadUserEmailPassword() async {
try {
SharedPreferences _prefs = await SharedPreferences.getInstance();
var _email = _prefs.getString("email") ?? "";
var _password = _prefs.getString("password") ?? "";
var _rememberMe = _prefs.getBool("remember_me") ?? false;
print(_rememberMe);
print(_email);
print(_password);
if (_rememberMe) {
setState(() {
isChecked = true;
});
_emailController.text = _email;
_passwordController.text = _password;
}
} catch (e) 
{
print(e);
}
}
}



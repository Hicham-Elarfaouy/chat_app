import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget textField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefixIcon,
  Widget? suffixIcon,
  bool password = false,
  required GlobalKey<FormState> key,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: password,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field must not be empty";
        }
      },
      onFieldSubmitted: (value) {
        key.currentState!.validate();
      },
    );

Widget defaultButton({
  required GlobalKey<FormState> key,
  required String label,
}) =>
    MaterialButton(
      color: Colors.blue,
      minWidth: double.infinity,
      height: 55,
      onPressed: () {
        if (key.currentState!.validate()) {
          // cubit.checkUserRegister(
          //   email: emailController.text,
          //   name: nameController.text,
          //   phone: phoneController.text,
          //   password: passwordController.text,
          // );
        }
      },
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

/*
enum toastState {succes,error,warning}
Color toastColor (toastState state){
  Color color;
  switch(state){
    case toastState.succes:
      color = Colors.green;
      break;
    case toastState.error:
      color = Colors.red;
      break;
    case toastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void showToast ({
  required String msg,
  required toastState state,
  Toast? Toast = Toast.LENGTH_LONG,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: toastColor(state),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
*/

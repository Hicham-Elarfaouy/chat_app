import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/home_layout.dart';
import 'package:flutter_app7/modules/login_module/cubit/login_cubit.dart';
import 'package:flutter_app7/modules/login_module/cubit/login_states.dart';
import 'package:flutter_app7/modules/register_module/register_screen.dart';
import 'package:flutter_app7/shared/components/constants.dart';
import 'package:flutter_app7/shared/components/widgets.dart';
import 'package:flutter_app7/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(msg: state.error, state: toastState.error);
          } else if (state is LoginSuccessState) {
            CacheHelper.putshared(key: 'uid', value: state.uid).then((value) {
              uid = state.uid;
              navigateToAndFinish(context, HomeLayout());
            }).catchError((error) {
              print(error.toString());
            });
          }
          /*if(state is stateLoginSuccess){
            if(state.userModel!.status == true){
              CacheHelper.putshared(key: 'isLogin', value: true).then((value) {
                navigateToAndFinish(context, HomeLayout());

                showToast(msg: '${state.userModel!.message}', state: toastState.succes);
                CacheHelper.putshared(key: 'token', value: state.userData!.token);
                token = state.userData!.token;
              }).catchError((error) {
                print(error.toString());
              });
            }else{
              showToast(msg: '${state.userModel!.message}', state: toastState.error);
            }
          }else if(state is stateLoginError){
            showToast(msg: 'فقد الاتصال بالخادم', state: toastState.warning,);
          }*/
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'login now to communicate with your friends',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          textField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefixIcon: Icons.email_outlined,
                            key: formKey,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          textField(
                            controller: passwordController,
                            type: TextInputType.text,
                            password: isVisible ? false : true,
                            label: 'Password',
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            key: formKey,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (state is! LoginLoadingState)
                              ? defaultButton(
                                  label: 'login',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  })
                              : Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text("Register"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

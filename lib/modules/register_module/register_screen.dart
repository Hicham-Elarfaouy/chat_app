import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/home_layout.dart';
import 'package:flutter_app7/modules/register_module/cubit/register_cubit.dart';
import 'package:flutter_app7/modules/register_module/cubit/register_states.dart';
import 'package:flutter_app7/shared/components/constants.dart';
import 'package:flutter_app7/shared/components/widgets.dart';
import 'package:flutter_app7/shared/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isVisible = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            showToast(msg: state.error, state: toastState.error);
          } else if (state is RegisterFireStoreSuccessState) {
            CacheHelper.putshared(key: 'uid', value: state.model.uid)
                .then((value) {
              uid = state.model.uid;
              navigateToAndFinish(context, HomeLayout());
            }).catchError((error) {
              print(error.toString());
            });
          }
          /*if(state is stateRegisterSuccess){
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
          }else if(state is stateRegisterError){
            showToast(msg: 'فقد الاتصال بالخادم', state: toastState.warning,);
          }*/
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
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
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'register now to communicate with your friends',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          textField(
                              controller: nameController,
                              type: TextInputType.text,
                              label: 'Name',
                              prefixIcon: Icons.text_fields,
                              key: formKey),
                          SizedBox(
                            height: 20,
                          ),
                          textField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              label: 'Phone Number',
                              prefixIcon: Icons.phone,
                              key: formKey),
                          SizedBox(
                            height: 20,
                          ),
                          textField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: 'Email Address',
                              prefixIcon: Icons.email_outlined,
                              key: formKey),
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
                              key: formKey),
                          SizedBox(
                            height: 30,
                          ),
                          (state is RegisterLoadingState)
                              ? Center(child: CircularProgressIndicator())
                              : defaultButton(
                                  label: 'register',
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.userRegister(
                                        email: emailController.text,
                                        name: nameController.text.split(" ").map((str) => str[0].toUpperCase()+str.substring(1).toLowerCase()).join(" "),
                                        phone: phoneController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  }),
                          SizedBox(
                            height: 10,
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

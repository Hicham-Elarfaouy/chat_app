import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/shared/components/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appCubit()..getUserData(),
      child: BlocConsumer<appCubit, appStates>(
        listener: (context, state) {},
        builder: (context, state) {
          appCubit cubit = appCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Hi, ${cubit.userModel?.name?.toUpperCase()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            body: Column(
              children: [
                if (!FirebaseAuth.instance.currentUser!.emailVerified)
                  Container(
                    width: double.infinity,
                    color: Colors.red.withOpacity(0.2),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Please verify your email',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser
                                  ?.sendEmailVerification();
                              showToast(msg: 'chack your mail', state: toastState.success);
                            },
                            child: Text(
                              'send',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

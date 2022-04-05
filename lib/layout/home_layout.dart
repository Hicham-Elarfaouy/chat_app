import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/modules/add_post_module/add_post_screen.dart';
import 'package:flutter_app7/modules/login_module/login_screen.dart';
import 'package:flutter_app7/shared/components/constants.dart';
import 'package:flutter_app7/shared/components/widgets.dart';
import 'package:flutter_app7/shared/network/local/cache_helper.dart';
import 'package:flutter_app7/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appCubit()..getUserData()..getPosts(),
      child: BlocConsumer<appCubit, appStates>(
        listener: (context, state) {},
        builder: (context, state) {
          appCubit cubit = appCubit.get(context);

          return cubit.userModel != null && cubit.listPosts.isNotEmpty
              ? Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Hi, ${cubit.userModel?.name?.toUpperCase()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {}, icon: Icon(IconBroken.Search)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(IconBroken.Notification)),
                      IconButton(
                          onPressed: () {
                            CacheHelper.removeshared(key: 'uid');
                            uid = null;
                            navigateToAndFinish(context, LoginScreen());
                            showToast(msg: 'تم تسجيل الخروج', state: toastState.success);
                          },
                          icon: Icon(IconBroken.Logout)),
                    ],
                  ),
                  body: cubit.listScreen[cubit.currentIndex],
                  floatingActionButton: FloatingActionButton(
                    elevation: 1,
                    mini: true,
                    onPressed: () {
                      cubit.PostImage = null;
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (newcontext) => BlocProvider.value(
                                value: BlocProvider.of<appCubit>(context),
                                child: AddPostScreen(),
                              )
                          )
                      );
                    },
                    backgroundColor: Colors.blue,
                    child: Icon(
                      IconBroken.Plus,
                    ),
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: cubit.currentIndex,
                    onTap: (index) {
                      cubit.ChangeBottomNav(index);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.Home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.Chat),
                        label: 'Chats',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.User),
                        label: 'Users',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconBroken.Setting),
                        label: 'Settings',
                      ),
                    ],
                  ),
                )
              : Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
        },
      ),
    );
  }
}
/*
Column(
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
showToast(
msg: 'chack your mail',
state: toastState.success);
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
)*/

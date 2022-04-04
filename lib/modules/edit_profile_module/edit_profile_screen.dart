import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/models/user_model.dart';
import 'package:flutter_app7/shared/components/widgets.dart';
import 'package:flutter_app7/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, appStates>(
      listener: (context, state) {},
      builder: (context, state) {
        appCubit cubit = appCubit.get(context);
        UserModel? user = cubit.userModel;

        nameController.text = user?.name ?? '';
        bioController.text = user?.bio ?? '';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.save_outlined),
              )
            ],
          ),
          body: Column(
            children: [
              Container(
                height: 130,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          cubit.CoverImage != null
                              ? Image(
                                  image:
                                      FileImage(File(cubit.CoverImage!.path)),
                                  width: double.infinity,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image(
                                  image: NetworkImage('${user?.cover}'),
                                  width: double.infinity,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                          IconButton(
                            onPressed: () {
                              cubit.PickCover();
                            },
                            icon: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  IconBroken.Edit_Square,
                                  size: 20,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        cubit.ProfileImage != null
                            ? CircleAvatar(
                                radius: 54,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      FileImage(File(cubit.ProfileImage!.path)),
                                ),
                              )
                            : CircleAvatar(
                                radius: 54,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage('${user?.image}'),
                                ),
                              ),
                        IconButton(
                          onPressed: () {
                            cubit.PickProfile();
                          },
                          icon: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                IconBroken.Edit_Square,
                                size: 20,
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      if(state is appUpdateProfileLoading)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      textField(
                        controller: nameController,
                        type: TextInputType.text,
                        label: 'Name',
                        prefixIcon: Icons.text_fields,
                        key: formKey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      textField(
                        controller: bioController,
                        type: TextInputType.text,
                        label: 'Bio',
                        prefixIcon: Icons.info_outline,
                        key: formKey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                        label: 'update',
                        function: () {
                          if(user!.name != nameController.text){
                            cubit.updateName = nameController.text;
                          }
                          if(user.bio != bioController.text){
                            cubit.updateBio = bioController.text;
                          }
                          formKey.currentState!.validate();
                          cubit.updateUserProfile();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

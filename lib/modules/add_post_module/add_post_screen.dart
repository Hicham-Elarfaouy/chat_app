import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_cubit.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/models/user_model.dart';
import 'package:flutter_app7/shared/styles/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPostScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appCubit, appStates>(
      listener: (context, state) {},
      builder: (context, state) {
        appCubit cubit = appCubit.get(context);
        UserModel? user = cubit.userModel;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.uploadPost(
                      date: '${DateTime.now()}',
                      text: textController.text,
                    );
                  }
                },
                child: Text(
                  'POST',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is appUploadPostLoading) LinearProgressIndicator(),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage('${user?.image}'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${user?.name}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: 'whats is on your mind ...',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'this field must not be empty';
                        }
                      },
                      onFieldSubmitted: (v) {
                        formKey.currentState!.validate();
                      },
                    ),
                  ),
                  if (cubit.PostImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Image(
                            image: FileImage(File(cubit.PostImage!.path)),
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.removePostImage();
                          },
                          icon: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.close,
                                size: 25,
                              )),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 40,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      cubit.PickPostImage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(IconBroken.Image),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add Photo',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

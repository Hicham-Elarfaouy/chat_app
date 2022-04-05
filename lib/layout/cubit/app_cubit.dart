import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/models/post_model.dart';
import 'package:flutter_app7/models/user_model.dart';
import 'package:flutter_app7/modules/chat_module/chat_screen.dart';
import 'package:flutter_app7/modules/home_module/home_screen.dart';
import 'package:flutter_app7/modules/setting_module/setting_screen.dart';
import 'package:flutter_app7/modules/users_module/users_module.dart';
import 'package:flutter_app7/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class appCubit extends Cubit<appStates> {
  appCubit() : super(appInitialState());

  static appCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(appLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      print('${userModel!.image}');
      emit(appSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(appErrorState(error));
    });
  }

  List<PostModel> listPosts = [];
  List<String> listIdPosts = [];
  List<List<String>> listLiked = [];
  List<String> listLikedPost = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) async {
        await element.reference.collection('Likes').get().then((value) {
          listLikedPost = [];
          value.docs.forEach((element) {
            listLikedPost.add(element.id);
          });
          listLiked.add(listLikedPost);
        });
        listIdPosts.add(element.id);
        listPosts.add(PostModel.fromJson(element.data()));
      });
      emit(appgetPostsSuccess());
    }).catchError((error) {
      print(error);
      emit(appgetPostsError());
    });
  }

  void likePost(idPost, index, bool isLike) {
    if (isLike) {
      listLiked[index].remove(uid!);
      emit(applikePostSuccess());
      FirebaseFirestore.instance
          .collection('posts')
          .doc(idPost)
          .collection('Likes')
          .doc(uid)
          .delete()
          .then((value) {
        emit(applikePostSuccess());
      })
          .catchError((error) {
        emit(applikePostError());
      });
    } else {
      listLiked[index].add(uid!);
      emit(applikePostSuccess());
      FirebaseFirestore.instance
          .collection('posts')
          .doc(idPost)
          .collection('Likes')
          .doc(uid)
          .set({
        'like': true,
      }).then((value) {
        emit(applikePostSuccess());
      }).catchError((error) {
        print(error);
        emit(applikePostError());
      });
    }
  }

  int currentIndex = 0;
  List<Widget> listScreen = [
    HomeScreen(),
    ChatScreen(),
    UsersScreen(),
    SettingScreen(),
  ];

  void ChangeBottomNav(int index) {
    currentIndex = index;
    emit(appChangeBottomNav());
  }

  XFile? ProfileImage;
  XFile? CoverImage;
  ImagePicker picker = ImagePicker();

  Future<void> PickProfile() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      ProfileImage = XFile(PickedFile.path);
      emit(appPickedProfileSuccess());
    }
  }

  Future<void> PickCover() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      CoverImage = XFile(PickedFile.path);
      emit(appPickedCoverSuccess());
    }
  }

  String? updateName;
  String? updateBio;
  String? urlProfile;
  String? urlCover;

  void updateUserProfile() async {
    emit(appUpdateProfileLoading());
    urlProfile = null;
    urlCover = null;

    if (ProfileImage != null) {
      urlProfile = await updateProfileImage();
    }
    if (CoverImage != null) {
      urlCover = await updateCoverImage();
    }

    print(urlProfile);
    print(urlCover);
    if (urlProfile != null ||
        urlCover != null ||
        updateName != null ||
        updateBio != null) {
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'image': urlProfile ?? userModel!.image,
        'cover': urlCover ?? userModel!.cover,
        'name': updateName ?? userModel!.name,
        'bio': updateBio ?? userModel!.bio,
      }).then((value) {
        updateName = null;
        updateBio = null;
        getUserData();
      }).catchError((error) {
        print(error);
        emit(appUpdateProfileError());
      });
    }
    emit(appUpdateProfileSuccess());
  }

  Future<String> updateProfileImage() async {
    var url;
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .putFile(File(ProfileImage!.path))
        .then((value) async {
      url = await value.ref.getDownloadURL();
    }).catchError((error) {
      print(error.toString());
    });
    return url;
  }

  Future<String> updateCoverImage() async {
    var url;
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(CoverImage!.path).pathSegments.last}')
        .putFile(File(CoverImage!.path))
        .then((value) async {
      url = await value.ref.getDownloadURL();
    }).catchError((error) {
      print(error.toString());
    });
    return url;
  }

  XFile? PostImage;

  Future<void> PickPostImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      PostImage = XFile(PickedFile.path);
      emit(appPickedPostSuccess());
    }
  }

  Future<String> uploadPostImage() async {
    var url;
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(PostImage!.path).pathSegments.last}')
        .putFile(File(PostImage!.path))
        .then((value) async {
      url = await value.ref.getDownloadURL();
    }).catchError((error) {
      print(error.toString());
    });
    return url;
  }

  void removePostImage() {
    PostImage = null;
    emit(appRemovePostSuccess());
  }

  String? urlPost;

  void uploadPost({
    required String date,
    required String text,
  }) async {
    emit(appUploadPostLoading());
    urlPost = null;
    print(PostImage);

    if (PostImage != null) {
      urlPost = await uploadPostImage();
    }

    print(urlPost);

    PostModel model = PostModel(
      userModel?.uid,
      userModel?.image,
      userModel?.name,
      date,
      text,
      likes: 0,
      comments: 0,
      image: urlPost,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(appUploadPostSuccess());
    }).catchError((error) {
      print(error);
      emit(appUpdateProfileError());
    });
  }
}

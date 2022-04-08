import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/models/message_model.dart';
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

  List<UserModel> users = [];

  void getUsers() {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.get('uid') != uid)
          users.add(UserModel.fromJson(element.data()));
      });
      print('${users.length} users');
      emit(appgetUsersSuccess());
    }).catchError((error) {
      print(error);
      emit(appgetUsersError());
    });
  }

  List<PostModel> listPosts = [];
  List<String> listIdPosts = [];

  /*List<List<String>> listLiked = [];
  List<String> listLikedPost = [];*/
  /*List<List<Map<String, dynamic>>> listPC = [];
  List<Map<String, dynamic>> listC = [];
  CommentModel com = CommentModel();
  Map<String, dynamic> ff = {};*/

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .get()
        .then((value) async {
      listPosts = [];
      listIdPosts = [];
      value.docs.forEach((element) async {
        /*await element.reference.collection('Comments').get().then((value) {
          listC = [];
          value.docs.forEach((element) {
            element.reference.get().then((value) {
              value.data()?.forEach((key, value) {
                ff['$key'] = value;
              });
              print('${ff['text']}jjjjjjjjjj');
              listC.add(ff);
            });
            listPC.add(listC);
          });

        });*/
        /*await element.reference.collection('Likes').get().then((value) {
          listLikedPost = [];
          value.docs.forEach((element) {
            listLikedPost.add(element.id);
          });
          listLiked.add(listLikedPost);
        });*/
        listIdPosts.add(element.id);
        listPosts.add(PostModel.fromJson(element.data()));
      });
      emit(appgetPostsSuccess());
    }).catchError((error) {
      print(error);
      emit(appgetPostsError());
    });
  }

  List<CommentModel> listComments = [];

  void getComments(idPost) {
    FirebaseFirestore.instance
        .collection('comment')
        .doc(idPost)
        .collection('comments')
        .orderBy('date', descending: true)
        .get()
        .then((value) async {
      listComments = [];
      value.docs.forEach((element) async {
        listComments.add(CommentModel.fromJson(element.data()));
      });
      emit(appgetCommentsSuccess());
    }).catchError((error) {
      print(error);
      emit(appgetCommentsError());
    });
  }

  void addComment(idPost, date, text) {
    CommentModel model =
        CommentModel(userModel?.image, userModel?.name, date, text);
    FirebaseFirestore.instance
        .collection('comment')
        .doc(idPost)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      getComments(idPost);
      emit(appAddCommentSuccess());
      getPosts();
      FirebaseFirestore.instance.collection('posts').doc(idPost).update({
        'comments': FieldValue.increment(1),
      });
    }).catchError((error) {
      print(error);
      emit(appAddCommentError());
    });
  }

  void likePost(idPost, PostModel model, bool isLike) {
    if (isLike) {
      model.likes?.remove(uid);
      emit(applikePostSuccess());
      FirebaseFirestore.instance.collection('posts').doc(idPost).update({
        'likes': FieldValue.arrayRemove([uid]),
      }).then((value) {
        getPosts();
        emit(applikePostSuccess());
      }).catchError((error) {
        emit(applikePostError());
      });
    } else {
      model.likes?.add(uid);
      emit(applikePostSuccess());
      FirebaseFirestore.instance.collection('posts').doc(idPost).update({
        'likes': FieldValue.arrayUnion([uid]),
      }).then((value) {
        getPosts();
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
      likes: [],
      comments: 0,
      image: urlPost,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(appUploadPostSuccess());
      getPosts();
    }).catchError((error) {
      print(error);
      emit(appUpdateProfileError());
    });
  }

  List<MessageModel> listMessages = [];

  void sendMessage(idReceiver, date, message) {
    MessageModel model = MessageModel(idReceiver, uid, date, message);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(idReceiver)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(appSendMessageSuccess());
    }).catchError((error) {
      emit(appSendMessageError());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(idReceiver)
        .collection('chats')
        .doc(uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(appSendMessageSuccess());
    }).catchError((error) {
      emit(appSendMessageError());
    });
  }

  void getMessages(idReceiver) {

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(idReceiver)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      listMessages = [];
      event.docs.forEach((element) {
        listMessages.add(MessageModel.fromJson(element.data()));
      });
      emit(appgetMessagesSuccess());
    });
  }
}

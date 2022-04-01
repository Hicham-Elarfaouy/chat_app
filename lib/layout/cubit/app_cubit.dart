import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app7/layout/cubit/app_states.dart';
import 'package:flutter_app7/models/user_model.dart';
import 'package:flutter_app7/shared/components/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class appCubit extends Cubit<appStates> {
  appCubit() : super(appInitialState());

  static appCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(appLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
          userModel = UserModel.fromJson(value.data());
          emit(appSuccessState());
    })
        .catchError((error) {
          print(error.toString());
          emit(appErrorState(error));
    });
  }
/*void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(LoginSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }*/
}

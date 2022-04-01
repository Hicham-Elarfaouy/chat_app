import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app7/models/user_model.dart';
import 'package:flutter_app7/modules/register_module/cubit/register_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreateOnFireStore(name: name, phone: phone, email: email, uid: value.user!.uid);
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreateOnFireStore({
    required String name,
    required String phone,
    required String email,
    required String uid,
  }) {
    UserModel model = UserModel(uid, name, email, phone);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(RegisterFireStoreSuccessState(model));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterFireStoreErrorState(error));
    });
  }
}

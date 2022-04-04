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
    UserModel model = UserModel(
      uid,
      name,
      email,
      phone,
      bio: 'Write bio ...',
      image: 'https://cdn-icons.flaticon.com/png/512/3899/premium/3899618.png?token=exp=1649001359~hmac=2fb05b19e04f6f606a3130e14ecde0c9',
      cover: 'https://cdn.pixabay.com/photo/2021/09/12/07/58/banner-6617550__340.png',
    );
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

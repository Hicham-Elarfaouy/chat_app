import 'package:flutter_app7/models/user_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterFireStoreSuccessState extends RegisterStates {
  UserModel model;

  RegisterFireStoreSuccessState(this.model);
}

class RegisterFireStoreErrorState extends RegisterStates {
  final String error;

  RegisterFireStoreErrorState(this.error);
}

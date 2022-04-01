abstract class appStates {

}

class appInitialState extends appStates {

}

class appLoadingState extends appStates {

}

class appSuccessState extends appStates {

}

class appErrorState extends appStates {

  final String error;
  appErrorState(this.error);
}

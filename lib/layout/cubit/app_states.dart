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


class appChangeBottomNav extends appStates {

}


class appPickedProfileSuccess extends appStates {

}

class appPickedCoverSuccess extends appStates {

}


class appUpdateProfileLoading extends appStates {

}

class appUpdateProfileSuccess extends appStates {

}

class appUpdateProfileError extends appStates {

}
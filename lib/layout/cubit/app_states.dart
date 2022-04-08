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

class appgetUsersSuccess extends appStates {

}

class appgetUsersError extends appStates {

}

class appgetPostsSuccess extends appStates {

}

class appgetPostsError extends appStates {

}


class appgetCommentsSuccess extends appStates {

}

class appgetCommentsError extends appStates {

}


class appAddCommentSuccess extends appStates {

}

class appAddCommentError extends appStates {

}



class applikePostSuccess extends appStates {

}

class applikePostError extends appStates {

}




class appChangeBottomNav extends appStates {

}



class appPickedProfileSuccess extends appStates {

}

class appPickedCoverSuccess extends appStates {

}



class appPickedPostSuccess extends appStates {

}

class appRemovePostSuccess extends appStates {

}



class appUpdateProfileLoading extends appStates {

}

class appUpdateProfileSuccess extends appStates {

}

class appUpdateProfileError extends appStates {

}



class appUploadPostLoading extends appStates {

}

class appUploadPostSuccess extends appStates {

}

class appUploadPostError extends appStates {

}


class appSendMessageSuccess extends appStates {

}

class appSendMessageError extends appStates {

}

class appgetMessagesSuccess extends appStates {

}
abstract class LayoutStates {}

class GetUserInitialState extends LayoutStates {}

class GetUserLoadingState extends LayoutStates {}

class GetUserSuccessState extends LayoutStates {}

class GetUserErrorState extends LayoutStates {
  final String error;
  GetUserErrorState(this.error);
}

class ChangeBottomNavIndexState extends LayoutStates {}

class ChangePadding extends LayoutStates {}

class NewPostState extends LayoutStates {}

class ProfileImagePickedSuccessState extends LayoutStates {}

class ProfileImagePickedErrorState extends LayoutStates {}

class ProfileCoverPickedSuccessState extends LayoutStates {}

class ProfileCoverPickedErrorState extends LayoutStates {}

class ProfileImageUploadSuccessState extends LayoutStates {}

class ProfileImageUploadErrorState extends LayoutStates {}

class ProfileCoverUploadSuccessState extends LayoutStates {}

class ProfileCoverUploadErrorState extends LayoutStates {}

class ProfileUploadImageLoadingState extends LayoutStates {}

class ProfileUploadCoverLoadingState extends LayoutStates {}

class ProfileUpdateErrorState extends LayoutStates {}

class ChangeEditIconState extends LayoutStates {}

class ProfilePostImagePickedSuccessState extends LayoutStates {}

class ProfilePostImagePickedErrorState extends LayoutStates {}

class UploadPostImageLoadingState extends LayoutStates {}

class UploadPostImageSuccessState extends LayoutStates {}

class UploadPostImageErrorState extends LayoutStates {}

class CreatePostLoadingState extends LayoutStates {}

class CreatePostSuccessState extends LayoutStates {}

class CreatePostErrorState extends LayoutStates {}
class RemovePostImageState extends LayoutStates {}

class GetPostsLoadingState extends LayoutStates {}

class GetPostsSuccessState extends LayoutStates {}

class GetPostsErrorState extends LayoutStates {
  final String error;
  GetPostsErrorState(this.error);
}

class PostLikeSuccessState extends LayoutStates {}

class PostLikeErrorState extends LayoutStates {
  final String error;
  PostLikeErrorState(this.error);
}

/*
class PostCommentSuccessState extends LayoutStates {}

class PostCommentErrorState extends LayoutStates {
  final String error;
  PostCommentErrorState(this.error);
}*/

class GetAllUsersLoadingState extends LayoutStates {}

class GetAllUsersSuccessState extends LayoutStates {}

class GetAllUsersErrorState extends LayoutStates {
  final String error;
  GetAllUsersErrorState(this.error);
}

class SendMessageSuccessState extends LayoutStates{}
class SendMessageErrorState extends LayoutStates{}

class ReceiveMessageSuccessState extends LayoutStates{}

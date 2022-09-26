import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialjetx/models/message_model.dart';
import 'package:socialjetx/models/post_model.dart';
import 'package:socialjetx/models/user_model.dart';
import 'package:socialjetx/modules/home_timeline/time_line_screen.dart';
import 'package:socialjetx/modules/messages/messages_screen.dart';
import 'package:socialjetx/modules/new_post/new_post_screen.dart';
import 'package:socialjetx/modules/notification/users_screen.dart';
import 'package:socialjetx/modules/profile/user_profile_screen.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(GetUserInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(GetUserErrorState(error.toString()));
    });
  }

  double padding = 0;

  void changePadding({required double value}) {
    padding = value;
    emit(ChangePadding());
  }

  List<Widget> screens = [
    const TimeLineScreen(),
    const ChatScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const ProfileScreen(),
  ];

  List<String> titles = [
    'Timeline',
    'Chat',
    'What\'s on ur mind ?',
    'Users',
    'Profile',
  ];
  int currentIndex = 0;

  void changeBottomNavIndex(int index,BuildContext context) {
    if(index == 1){
      getAllUsers();
    }
    if (index == 2) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavIndexState());
    }
  }

  var picker = ImagePicker();

  File? profileImage;
  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No image selected');
      }
      emit(ProfileImagePickedErrorState());
    }
  }

  File? profileCover;
  Future getProfileCover() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileCover = File(pickedFile.path);
      emit(ProfileCoverPickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No cover selected');
      }
      emit(ProfileCoverPickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(ProfileUploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child("Users Images/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(ProfileImageUploadSuccessState());
        updateUserData(
          name: name,
          bio: bio,
          phone: phone,
          image: value,
        );
        if (kDebugMode) {
          print(value);
        }
      }).catchError((error) {
        emit(ProfileImageUploadErrorState());
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }).catchError((error) {
      emit(ProfileImageUploadErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void uploadProfileCover({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(ProfileUploadCoverLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('Users Covers/${Uri.file(profileCover!.path).pathSegments.last}')
        .putFile(profileCover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(ProfileCoverUploadSuccessState());
        updateUserData(
          name: name,
          bio: bio,
          phone: phone,
          cover: value,
        );
        if (kDebugMode) {
          print(value);
        }
      }).catchError((error) {
        emit(ProfileCoverUploadErrorState());
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }).catchError((error) {
      emit(ProfileCoverUploadErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateUserData({
    required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,
  }) {
    UserModel model = UserModel(
      name: name,
      bio: bio,
      phone: phone,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      uId: userModel!.uId,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ProfileUpdateErrorState());
    });
  }

  IconData editIcon = Icons.edit_outlined;
  bool isEnabled = false;
  void changeEditIcon() {
    isEnabled = !isEnabled;
    editIcon = isEnabled ? Icons.check : Icons.edit_outlined;
    emit(ChangeEditIconState());
  }

  File? postImage;
  Future getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(ProfilePostImagePickedSuccessState());
    } else {
      if (kDebugMode) {
        print('No image selected');
      }
      emit(ProfilePostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String? postCaption,
    required String? dateTime,
  }) {
    emit(UploadPostImageLoadingState());

    FirebaseStorage.instance
        .ref()
        .child("Posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          postCaption: postCaption,
          postImage: value,
          dateTime: dateTime,
        );
      }).catchError((error) {
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(UploadPostImageErrorState());
    });
  }

  void createPost({
    String? postCaption,
    String? postImage,
    required String? dateTime,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userModel!.name!,
      image: userModel!.image!,
      uId: userModel!.uId!,
      postCaption: postCaption ?? '',
      postImage: postImage ?? '',
      dateTime: dateTime,
    );

    FirebaseFirestore.instance
        .collection("Posts")
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection("Posts")
        .get()
        .then((value) async {
        for (var element in value.docs) {
        await element.reference
            .collection("Likes")
            .get()
            .then((value) {
          posts.add(PostModel.fromJson(element.data()));
          likes.add(value.docs.length);
          postsId.add(element.id);
          });
      }
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(postId)
        .collection("Likes")
        .doc(userModel!.uId)
        .set({"like": true}).then((value) {
      emit(PostLikeSuccessState());
    }).catchError((error) {
      emit(PostLikeErrorState(error.toString()));
    });
  }
  List<UserModel> users = [];
  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    if(users.isEmpty){
      FirebaseFirestore.instance
          .collection('Users')
          .get()
          .then((value) {
        for (var element in value.docs) {
          if(element.data()["uId"] != userModel!.uId){
            users.add(UserModel.fromJson(element.data()));
          }
        }
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        emit(GetAllUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }){
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel!.uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value)
    {
          emit(SendMessageSuccessState());
    }).catchError((error)
    {
      emit(SendMessageErrorState());
    });

    //set receiver chats
    FirebaseFirestore.instance
        .collection("Users")
        .doc(receiverId)
        .collection("Chats")
        .doc(userModel!.uId)
        .collection("Messages")
        .add(messageModel.toMap())
        .then((value)
    {
      emit(SendMessageSuccessState());
    }).catchError((error)
    {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({required String receiverId}){
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userModel!.uId)
        .collection("Chats")
        .doc(receiverId)
        .collection("Messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
          messages = [];
          for (var element in event.docs) {
            messages.add(MessageModel.fromJson(element.data()));
          }
          emit(ReceiveMessageSuccessState());
    });
  }

}

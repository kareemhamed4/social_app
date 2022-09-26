import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/colors.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

//ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var userModel = LayoutCubit.get(context).userModel!;
        var profileImage = LayoutCubit.get(context).profileImage;
        var coverImage = LayoutCubit.get(context).profileCover;

        nameController.text = userModel.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Form(
          key: formKey,
          child: Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: "Edit Profile",
                icon: Icons.close,
                actions: [
                  IconButton(
                    icon: Icon(LayoutCubit.get(context).editIcon,color: Colors.blue,),
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        LayoutCubit.get(context).changeEditIcon();
                        if (!LayoutCubit.get(context).isEnabled) {
                          LayoutCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              bio: bioController.text);
                        }
                      }
                    },
                  )
                ]),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        SizedBox(
                          height: 190,
                          child: Stack(
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                      ),
                                      image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage(userModel.cover!)
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.grey[300],
                                    child: IconButton(
                                        onPressed: () {
                                          LayoutCubit.get(context)
                                              .getProfileCover();
                                        },
                                        icon: const Icon(
                                          IconBroken.Camera,
                                          color: Colors.black,
                                          size: 20,
                                        ))),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            CircleAvatar(
                                radius: 52,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage(userModel.image!)
                                        : FileImage(profileImage)
                                            as ImageProvider)),
                            CircleAvatar(
                              radius: 19,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.grey[300],
                                  child: IconButton(
                                      onPressed: () {
                                        LayoutCubit.get(context)
                                            .getProfileImage();
                                      },
                                      icon: const Icon(
                                        IconBroken.Camera,
                                        color: Colors.black,
                                        size: 20,
                                      ))),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (LayoutCubit.get(context).profileImage != null || LayoutCubit.get(context).profileCover != null)
                      Row(
                        children: [
                          if (LayoutCubit.get(context).profileImage != null)
                            Expanded(
                                child: Column(
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {
                                          LayoutCubit.get(context).uploadProfileImage(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                                        },
                                        child: Text(
                                          'Upload Profile Image',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                        )),
                                    const SizedBox(height: 6,),
                                    if(state is ProfileUploadImageLoadingState)
                                      LinearProgressIndicator(color: myFavColor5,)
                                  ],
                                )),
                          const SizedBox(width: 10,),
                          if (LayoutCubit.get(context).profileCover != null)
                            Expanded(
                                child: Column(
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {
                                          LayoutCubit.get(context).uploadProfileCover(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                                        },
                                        child: Text(
                                          'Upload Profile Cover',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                        )),
                                    const SizedBox(height: 6,),
                                    if(state is ProfileUploadCoverLoadingState)
                                      LinearProgressIndicator(color: myFavColor5,)
                                  ],
                                )),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validator: (value) {
                        return null;
                      },
                      onTap: () {},
                      enabled: LayoutCubit.get(context).isEnabled,
                      label: "username",
                      prefix: Icon(
                        IconBroken.Profile,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      controller: bioController,
                      type: TextInputType.name,
                      onTap: () {},
                      enabled: LayoutCubit.get(context).isEnabled,
                      label: "bio",
                      prefix: Icon(
                        IconBroken.Paper,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validator: (value) {
                        return null;
                      },
                      onTap: () {},
                      enabled: LayoutCubit.get(context).isEnabled,
                      label: "phone",
                      prefix: Icon(
                        IconBroken.Call,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/modules/edit_profile/edit_profile_screen.dart';
import 'package:socialjetx/modules/setting/setting_screen.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel = LayoutCubit.get(context).userModel;
        return ConditionalBuilder(
            condition: LayoutCubit.get(context).userModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        SizedBox(
                          height: 190,
                          child: Align(
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
                                    image: NetworkImage(
                                      userModel!.cover!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                            radius: 52,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(userModel.image!),
                            )
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(userModel.name!,overflow: TextOverflow.ellipsis,
                            maxLines: 3, style: Theme.of(context).textTheme.subtitle2,),
                        ),
                        const SizedBox(width: 5,),
                        const Icon(Icons.check_circle,color: Colors.blue,size: 15,),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Text(
                      userModel.bio!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.grey,fontSize: 14),
                    ),
                    const SizedBox(height: 25,),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: (){},
                            child: Column(
                              children: [
                                Text(
                                  '100',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                const SizedBox(height: 6,),
                                Text(
                                  'Posts',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.grey,fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: (){},
                            child: Column(
                              children: [
                                Text(
                                  '98',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                const SizedBox(height: 6,),
                                Text(
                                  'Photos',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.grey,fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: (){},
                            child: Column(
                              children: [
                                Text(
                                  '64k',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                const SizedBox(height: 6,),
                                Text(
                                  'Followers',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.grey,fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: (){},
                            child: Column(
                              children: [
                                Text(
                                  '1',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                const SizedBox(height: 6,),
                                Text(
                                  'Following',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(color: Colors.grey,fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: OutlinedButton(
                            onPressed: (){
                              NavigateTo(context: context, widget: EditProfileScreen());
                            },
                            child: Text(
                              'Edit Profile',
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(color: Colors.blue),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                              onPressed: (){
                                NavigateTo(context: context, widget: const SettingScreen());
                              },
                              child: const Icon(
                                IconBroken.Setting,color: Colors.blue,
                              )
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.grid_view_outlined,color: Colors.grey,),
                        SizedBox(width: 10,),
                        Icon(IconBroken.Filter_2,color: Colors.grey,),
                      ]
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator()),
        );


      },
    );
  }

}

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/colors.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

//ignore: must_be_immutable
class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  TextEditingController postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LayoutCubit cubit = BlocProvider.of(context);
        var now = TimeOfDay.now().format(context);
        return Scaffold(
          appBar:
              defaultAppBar(
                  context: context,
                  title: "Create Post",
                  actions: [
            myTextButton(
              context: context,
              label: "POST",
              onTap: () {
                if(cubit.postImage == null){
                  cubit.createPost(postCaption: postController.text,dateTime: now);
                }else{
                  cubit.uploadPostImage(postCaption: postController.text, dateTime: now);
                }
              },
            )
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState || state is UploadPostImageLoadingState)
                  LinearProgressIndicator(color: myFavColor5,),
                if(state is CreatePostLoadingState || state is UploadPostImageLoadingState)
                  const SizedBox(height: 20,),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/pleased-european-woman-with-curly-hair-keeps-hands-cheeks-smiles-pleasantly-keeps-eyes-closed-recalls-pleasant-memories-wears-shirt-isolated-beige-background-happy-feelings-concept_273609-62609.jpg',
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cubit.userModel!.name!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 16,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 16,
                            width: 16,
                            child: IconButton(
                                onPressed: (){},
                                icon: const Icon(FluentIcons.people_community_16_regular,size: 16,
                                ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_horiz_outlined,
                        )),
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 200,
                    style: Theme.of(context).textTheme.bodyText2,
                    controller: postController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: "what's on ur mind, ${cubit.userModel!.name}",
                      hintStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12),
                    ),
                  ),
                ),
                if(cubit.postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(cubit.postImage!),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey[300],
                            child: IconButton(
                                onPressed: (){
                                  cubit.removePostImage();
                                },
                                icon: const Icon(
                                    Icons.close,
                                  size: 16,
                                  color: Colors.black,
                                ),
                            ),
                        ),
                      ),
                    ],
                  ),
                if(cubit.postImage != null)
                  const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: (){
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image,color: Colors.blue,),
                              SizedBox(width: 5,),
                              Text("add media",style: TextStyle(color: Colors.blue),),
                            ],
                          ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: (){},
                          child: const Text("#tags",style: TextStyle(color: Colors.blue),),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

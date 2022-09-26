/*
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/models/message_model.dart';
import 'package:socialjetx/models/user_model.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/styles/colors.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

//ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  final messageController = TextEditingController();
  final UserModel model;
  ChatDetailsScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        LayoutCubit.get(context).getMessages(receivedId: model.uId!);
        return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            LayoutCubit cubit = BlocProvider.of(context);
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(65),
                child: AppBar(
                  leading: IconButton(
                    icon: const Icon(
                      IconBroken.Arrow___Left_2,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(model.image!),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        model.name!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 2),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          IconBroken.Info_Circle,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context,index)
                            {
                              var message = cubit.messages[index];
                              if(cubit.userModel!.uId == message.senderId)
                              {
                                return buildMyChat(context,message);
                              }else{
                                return buildReceivingChat(context,message);
                              }
                            },
                            separatorBuilder: (context,index) => const SizedBox(
                              height: 10,
                            ),
                            itemCount: cubit.messages.length
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Colors.grey
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    cursorHeight: 20,
                                    cursorColor: myFavColor5,
                                    controller: messageController,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 200,
                                    style: Theme.of(context).textTheme.bodyText2,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "type your message hear ...",
                                      hintStyle: Theme.of(context).textTheme.caption,
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  height: 49,
                                  minWidth: 1,
                                  color: myFavColor5,
                                  onPressed: (){
                                    cubit.sendMessage(
                                      receiverId: model.uId!,
                                      dateTime: DateTime.now().toString(),
                                      message: messageController.text,
                                    );
                                  },
                                  child: const Icon(IconBroken.Send,size: 22,color: Colors.white,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => const Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },

    );
  }

  Widget buildReceivingChat(BuildContext context,MessageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Align(
                alignment: AlignmentDirectional.center,
                child: Text("${model.message}",
                  style: Theme.of(context).textTheme.bodyText2,
                ))),
      );
  Widget buildMyChat(BuildContext context,MessageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: myFavColor5,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  "${model.message}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.white),
                ))),
      );
}
*/

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/models/message_model.dart';
import 'package:socialjetx/models/user_model.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/styles/colors.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

//ignore: must_be_immutable
class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  var messageController = TextEditingController();
  ChatDetailsScreen({Key? key,required this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        LayoutCubit.get(context).getMessages(receiverId: userModel.uId!);
        return BlocConsumer<LayoutCubit,LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(userModel.image!),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      userModel.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 2),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Info_Circle,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              body: ConditionalBuilder(
                condition: LayoutCubit.get(context).messages.isNotEmpty,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children:
                    [
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                            itemBuilder: (context,index)
                            {
                              var message = LayoutCubit.get(context).messages[index];
                              if(LayoutCubit.get(context).userModel!.uId == message.senderId){
                                return buildMyMessage(context,message);
                              }
                              return buildMessage(context,message);
                            },
                            separatorBuilder: (context,index) => const SizedBox(height: 15,),
                            itemCount: LayoutCubit.get(context).messages.length,
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  cursorColor: myFavColor5,
                                  cursorHeight: 20,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 6,
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "type your message here ...",
                                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                height: 49,
                                color: myFavColor5,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: (){
                                    LayoutCubit.get(context).sendMessage(
                                        receiverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text
                                    );
                                    messageController.clear();
                                  },
                                  child: const Icon(IconBroken.Send,size: 16,color: Colors.white,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Center(child: Text('No messages yet ...',style: Theme.of(context).textTheme.bodyText2,))),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyText2,
                                  cursorColor: myFavColor5,
                                  cursorHeight: 20,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 6,
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "type your message here ...",
                                    hintStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
                                  ),
                                ),
                              ),
                              Container(
                                height: 49,
                                color: myFavColor5,
                                child: MaterialButton(
                                  minWidth: 1,
                                  onPressed: (){
                                    LayoutCubit.get(context).sendMessage(
                                        receiverId: userModel.uId!,
                                        dateTime: DateTime.now().toString(),
                                        text: messageController.text
                                    );
                                    messageController.clear();
                                  },
                                  child: const Icon(IconBroken.Send,size: 16,color: Colors.white,),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],),
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  Widget buildMessage(BuildContext context,MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
        color: Colors.grey[300],
      ),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Text(
        model.text!,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black87),
      ),
    ),
  );
  Widget buildMyMessage(BuildContext context,MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
        color: myFavColor5.withOpacity(.8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Text(
        model.text!,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),
      ),
    ),
  );
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/models/user_model.dart';
import 'package:socialjetx/modules/chat_details/chat_details_screen.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/components/components.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context,state) {
        return ConditionalBuilder(
            condition: LayoutCubit.get(context).userModel != null && LayoutCubit.get(context).users.isNotEmpty,
            builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index) => buildChatItem(context,LayoutCubit.get(context).users[index]),
                separatorBuilder: (context,index) => myDivider(),
                itemCount: LayoutCubit.get(context).users.length
            ),
            fallback: (context) => const Center(child: CircularProgressIndicator())
        );
      },

    );
  }
  Widget buildChatItem(BuildContext context,UserModel model) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: InkWell(
      onTap: (){
        NavigateTo(context: context, widget: ChatDetailsScreen(userModel: model,));
      },
      borderRadius: BorderRadius.circular(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(model.image!),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    const SizedBox(height: 30,),
                    Text(model.name!,
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
                /*const SizedBox(
                  height: 5,
                ),
                Text(
                  'آسف والله بالغلط',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: Colors.grey),
                ),*/
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/models/post_model.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/colors.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: LayoutCubit.get(context).posts.isNotEmpty && LayoutCubit.get(context).userModel != null ,
            builder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Image(
                              image: const NetworkImage(
                                'https://img.freepik.com/free-photo/stunned-afro-american-woman-looks-with-scared-speechless-expression_273609-37377.jpg',
                              ),
                              width: double.infinity,
                              height: size.height * 0.2,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  top: 60, end: 10),
                              child: Text(
                                'Communicate with friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(
                            LayoutCubit.get(context).posts[index],
                            context,
                            size,
                            index),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                        itemCount: LayoutCubit.get(context).posts.length,
                      ),
                    ],
                  ),
                ),
          fallback: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No posts yet, ',style: Theme.of(context).textTheme.bodyText2,),
                            Text(
                              'refresh...',style: Theme.of(context).textTheme.bodyText2!.copyWith(color: myFavColor5),),
                          ],
                        ))),
              ],),
          ),
        );
      },
    );
  }
}

Widget buildPostItem(PostModel model, BuildContext context, Size size, index) =>
    Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name!,
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
                      Text(
                        model.dateTime!,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.grey),
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
            myDivider(),
            if(model.postCaption != "")
              Text(
              model.postCaption!,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6.0),
                  child: SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#beauty',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6.0),
                  child: SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#Care',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 6.0),
                  child: SizedBox(
                    height: 25,
                    child: MaterialButton(
                      onPressed: () {},
                      minWidth: 1,
                      padding: EdgeInsets.zero,
                      child: Text(
                        '#btngana',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Colors.blue, fontSize: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            if (model.postImage != "")
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 10,
                child: Image(
                  image: NetworkImage(model.postImage!),
                  width: double.infinity,
                  height: size.height * 0.3,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        LayoutCubit.get(context).likePost(LayoutCubit.get(context).postsId[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${LayoutCubit.get(context).likes[index]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              '5',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            myDivider(),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              LayoutCubit.get(context).userModel!.image!),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          'write a comment ...',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    LayoutCubit.get(context)
                        .likePost(LayoutCubit.get(context).postsId[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        const Icon(
                          IconBroken.Heart,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          IconBroken.Send,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Share',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

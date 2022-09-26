/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialjetx/layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/layout/cubit/states/states.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LayoutCubit()..getUserData(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(65.0),
              child: AppBar(
                title: Text(
                  'SocialJetX',
                  style: Theme.of(context).textTheme.headline5,
                ),
                titleSpacing: 20,
                actions: [
                  CircleAvatar(
                    backgroundColor: Colors.white10,
                    child: IconButton(
                      onPressed: () {},
                      icon: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                             Icon(
                              Icons.notifications,
                              color: myFavColor3,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.blue, shape: BoxShape.circle),
                              height: 6,
                              width: 6,
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16),
                    child: CircleAvatar(
                      backgroundColor: Colors.white10,
                      child: IconButton(
                        onPressed: () {},
                        icon: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                               Icon(
                                Icons.message,
                                color: myFavColor3,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.blue, shape: BoxShape.circle),
                                height: 6,
                                width: 6,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if(!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      color: myFavColor3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline,color: Colors.white,),
                            const SizedBox(width: 10,),
                            Text('Please Verify your email',style: Theme.of(context).textTheme.bodyText2,),
                            const Spacer(),
                            myTextButton(context: context, label: 'SEND', onTap: (){
                              FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value){
                                Fluttertoast.showToast(
                                    msg: "Check your mail",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.pink,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }).catchError((error){});
                            }),
                          ],
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Stories",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: size.height * 0.22,
                                child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        buildStoryItem(size, context),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          width: 10,
                                        ),
                                    itemCount: 10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Stack(children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: LayoutCubit.get(context).padding),
                              child: Container(
                                height: 50,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      myFavColor3,
                                      Colors.pink
                                    ]),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Container(
                              width: size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  myMaterialButtonWithoutIcon(
                                      context: context,
                                      label: "Explore",
                                      onTap: () {
                                        LayoutCubit.get(context).changePadding(value: 0);
                                      }),
                                  const Spacer(),
                                  myMaterialButtonWithoutIcon(
                                      context: context,
                                      label: "Discover",
                                      onTap: () {
                                        LayoutCubit.get(context).changePadding(value: 150);
                                      }),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ListView.separated(
                            shrinkWrap: true,

                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) =>
                                  buildPostItem(size, context),
                              separatorBuilder: (context, index) => const SizedBox(
                                    height: 20,
                                  ),
                              itemCount: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildStoryItem(Size size, BuildContext context) => Container(
        width: size.width * 0.36,
        height: size.height * 0.22,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              width: size.width * 0.36,
              height: size.height * 0.22,
              image: const NetworkImage(
                  'https://www.egypttoday.com/siteimages/Larg/6325.jpg'),
              fit: BoxFit.fill,
            ),
            Stack(alignment: AlignmentDirectional.topCenter, children: [
              Container(
                width: size.width * 0.36,
                height: size.height * 0.09,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 30.0),
                child: Container(
                    width: size.width * 0.2,
                    height: size.height * 0.05,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/kareem.jpg'),
                          fit: BoxFit.contain),
                    )),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Kareem Mohamed',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ],
        ),
      );
  Widget buildPostItem(Size size, BuildContext context) => Container(
    height: 380,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white10,
        ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15,),
        Row(
          children: [
            const SizedBox(width: 20,),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 22,
              child: Container(
                  width: size.width * 0.2,
                  height: size.height * 0.05,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/kareem.jpg'),
                        fit: BoxFit.cover),
                  )),
            ),
            const SizedBox(width: 12,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Kareem Mohamed',style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 14),),
                const SizedBox(height: 5,),
                Text('22min',style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),),
              ],
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: Colors.white10,
                child: IconButton(onPressed: (){}, icon: const Icon(Icons.keyboard_control_outlined,color: Colors.grey,))),
            const SizedBox(width: 20,),
          ],
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Text('palestine 🇵🇸 ',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 200,
            width: double.infinity,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image:const DecorationImage(image: AssetImage('assets/images/palestine.jpg'),fit: BoxFit.fill)
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0),
          child: Row(
            children: const [
              Icon(Icons.favorite,color: Colors.redAccent,),
              SizedBox(width: 15,),
              Icon(Icons.mode_comment_outlined,color: Colors.grey,size: 20,),
              SizedBox(width: 15,),
              Icon(Icons.send,color: Colors.grey,size: 20,),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          children: [
            const SizedBox(width: 22,),
            Text('229',style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 10),),
            const SizedBox(width: 6,),
            Text('Likes',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),),
            const SizedBox(width: 6,),
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6,),
            Text('200',style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 10),),
            const SizedBox(width: 6,),
            Text('Comment',style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 12),),
          ],
        ),
      ],
    ),
      );
}
*/

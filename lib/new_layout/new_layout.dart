import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/modules/new_post/new_post_screen.dart';
import 'package:socialjetx/modules/search/search_screen.dart';
import 'package:socialjetx/new_layout/cubit/cubit/cubit.dart';
import 'package:socialjetx/new_layout/cubit/states/states.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

class NewLayout extends StatelessWidget {
  const NewLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state){
        if(state is NewPostState){
          NavigateTo(context: context, widget: NewPostScreen());
        }
      },
      builder: (context,state){
        LayoutCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: AppBar(
              title: Text(cubit.titles[cubit.currentIndex],style: Theme.of(context).textTheme.subtitle1,),
              actions: [
                 IconButton(icon: const Icon(IconBroken.Notification), onPressed:(){},),
                 const SizedBox(width: 5,),
                 Padding(
                   padding: const EdgeInsetsDirectional.only(end: 14.0),
                   child: IconButton(icon: const Icon(IconBroken.Search),
                     onPressed:(){
                       NavigateTo(context: context, widget: SearchScreen());
                   },),
                 ),
              ],
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              NavigateTo(context: context, widget: NewPostScreen());
            },
            child: const Icon(IconBroken.Upload),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home,),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chat'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Upload,size: 0,),label: ''),
                BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Profile),label: 'Profile'),
              ],
            onTap: (int index){
              cubit.changeBottomNavIndex(index,context);
            },
          ),
        );
      },
    );
  }
}

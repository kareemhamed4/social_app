import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/main_cubit/cubit/cubit.dart';
import 'package:socialjetx/main_cubit/states/states.dart';
import 'package:socialjetx/modules/login/login_screen.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: "Setting",
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: (){
                          MainCubit.get(context).changeAppMode();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Change app mode",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.blue),),
                            const SizedBox(width: 10,),
                            const Icon(FluentIcons.brightness_high_16_regular,color: Colors.blue,)
                          ],
                        )
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: (){
                          MainCubit.get(context).signOut();
                          NavigateTo(context: context, widget: LoginScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Log Out",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.blue),),
                            const SizedBox(width: 10,),
                            const Icon(IconBroken.Logout,color: Colors.blue,)
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/modules/login/cubit/cubit/cubit.dart';
import 'package:socialjetx/modules/login/cubit/states/states.dart';
import 'package:socialjetx/modules/signup/signup_screen.dart';
import 'package:socialjetx/network/local/shared_helper.dart';
import 'package:socialjetx/new_layout/new_layout.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/constants/constants.dart';
import 'package:socialjetx/shared/styles/colors.dart';

//ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              uId = state.uId;
            });
            NavigateToReb(context: context, widget: const NewLayout());
          }
        },
        builder: (context, state) {
          LoginCubit cubit = BlocProvider.of(context);
          return Form(
            key: formKey,
            child: Scaffold(
              body: SizedBox(
                height: size.height,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: size.height * 0.3,
                            width: double.infinity,
                          ),
                          const Positioned(
                              left: -150,
                              top: -120,
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/login_shape_1.png'))),
                          const Positioned(
                              right: 25,
                              top: 60,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/login_shape_2.png',
                                ),
                                width: 120,
                                height: 120,
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: myMaterialButton(
                                  context: context,
                                  label: 'Continue with Google',
                                  iconPath: 'assets/icons/google.png',
                                  onTap: () {}),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: myMaterialButton(
                                  context: context,
                                  label: 'Continue with Facebook',
                                  iconPath: 'assets/icons/facebook.png',
                                  onTap: () {}),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: myMaterialButton(
                                  context: context,
                                  label: 'Continue with Apple',
                                  iconPath: 'assets/icons/apple_black.png',
                                  onTap: () {}),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'or',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            MyTextFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                return null;
                              },
                              onTap: () {},
                              label: "Email",
                              prefix: const Icon(FluentIcons.mail_16_regular),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MyTextFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validator: (value) {
                                return null;
                              },
                              onTap: () {},
                              prefix:
                                  const Icon(FluentIcons.password_16_regular),
                              label: "Password",
                              suffix: cubit.suffixIcon,
                              suffixPressed: () {
                                cubit.changeLoginSuffixIcon();
                              },
                              isPassword: cubit.isPassword,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingState,
                              builder: (context) => Container(
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      myFavColor3,
                                      Colors.pink,
                                    ]),
                                  ),
                                  child: myMaterialButtonWithoutIcon(
                                      context: context,
                                      label: "Sign In",
                                      onTap: () {
                                        cubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      })),
                              fallback: (context) => Container(
                                  height: size.height * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      myFavColor3,
                                      Colors.pink,
                                    ]),
                                  ),
                                  child: Center(
                                      child: Transform.scale(
                                          scale: 0.5,
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                          )))),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account ?",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                myTextButton(
                                    context: context,
                                    label: "Sign Up",
                                    onTap: () {
                                      NavigateTo(
                                          context: context,
                                          widget: RegisterScreen());
                                    }),
                              ],
                            ),
                            myTextButton(
                                context: context,
                                label: "Forgot Password ?",
                                onTap: () {}),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

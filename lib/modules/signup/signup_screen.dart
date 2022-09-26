import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialjetx/modules/login/login_screen.dart';
import 'package:socialjetx/modules/signup/cubit/cubit/cubit.dart';
import 'package:socialjetx/modules/signup/cubit/states/states.dart';
import 'package:socialjetx/shared/components/components.dart';
import 'package:socialjetx/shared/styles/colors.dart';

//ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is UserCreateSuccessState) {
            NavigateTo(context: context, widget: LoginScreen());
          }
        },
        builder: (context, state) {
          SignUpCubit cubit = BlocProvider.of(context);
          return Form(
            key: formKey,
            child: Scaffold(
              body: Center(
                child: SizedBox(
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
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Register Now',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              MyTextFormField(
                                controller: usernameController,
                                type: TextInputType.text,
                                validator: (value) {
                                  return null;
                                },
                                onTap: () {},
                                label: "Username",
                                prefix: const Icon(FluentIcons.emoji_smile_slight_20_regular),
                              ),
                              const SizedBox(
                                height: 8,
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
                                label: "Password",
                                prefix: const Icon(FluentIcons.password_16_regular),
                                isPassword: cubit.isPassword,
                                suffix: cubit.suffixIcon,
                                suffixPressed: () {
                                  cubit.changeSignUpSuffixIcon();
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MyTextFormField(
                                controller: phoneController,
                                type: TextInputType.number,
                                validator: (value) {
                                  return null;
                                },
                                onTap: () {},
                                label: "Phone",
                                prefix: const Icon(FluentIcons.call_16_regular),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ConditionalBuilder(
                                condition: state is! SignUpLoadingState,
                                builder: (context) => Container(
                                    width: double.infinity,
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
                                        label: "Register",
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.userRegister(
                                                name: usernameController.text,
                                                email: emailController.text,
                                                phone: phoneController.text,
                                                password: passwordController.text);
                                          }
                                        })),
                                fallback: (context) => Container(
                                    width: double.infinity,
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
                                    "already have an account ?",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  myTextButton(
                                      context: context,
                                      label: "Sign In",
                                      onTap: () {
                                        NavigateTo(
                                            context: context,
                                            widget: LoginScreen());
                                      }),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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

import 'package:flutter/material.dart';
import 'package:socialjetx/shared/styles/icon_broken.dart';

// ignore: non_constant_identifier_names
Future NavigateToReb({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));

// ignore: non_constant_identifier_names
Future NavigateTo({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  final Function onTap;
  final Function? suffixPressed;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  final TextEditingController controller;
  final TextInputType type;
  FormFieldValidator<String>? validator;
  final double? radius;
  final Widget? prefix;
  final IconData? suffix;
  String? label;
  bool isPassword;
  bool enabled;
  MyTextFormField(
      {required this.controller,
      required this.type,
      this.validator,
      required this.onTap,
      this.suffixPressed,
      this.onSubmit,
      this.onChange,
      this.radius = 10.0,
      this.prefix,
      this.label = '',
      this.suffix,
      this.isPassword = false,
      this.enabled = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorHeight: 20,
      onTap: () {
        onTap();
      },
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      controller: controller,
      keyboardType: type,
      enabled: enabled,
      obscureText: isPassword,
      validator: validator != null ? (value) {
        if (value!.isEmpty) {
          return "$label must not be empty";
        }
        return null;
      } : null ,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        filled: false,
        fillColor: Colors.red[100],
        hintText: label,
        hintStyle:
            Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        floatingLabelStyle: const TextStyle(color: Colors.white),
        prefixIcon: prefix,
        suffixIcon: IconButton(
          icon: Icon(
            suffix,
          ),
          onPressed: () {
            suffixPressed!();
          },
        ),
        label: Text(
          label!,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}

Widget myMaterialButton({
  required BuildContext context,
  required String label,
  required String iconPath,
  required Function onTap,
  Color? color,
}) =>
    MaterialButton(
      color: color,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      splashColor: Colors.transparent,
      onPressed: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(iconPath),
            height: 25,
            width: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );

Widget myTextButton(
        {required BuildContext context,
        required String label,
        required Function onTap,
        double size = 12}) =>
    SizedBox(
      height: 30,
      child: TextButton(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onPressed: () {
          onTap();
        },
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontSize: 12, color: Colors.blue),
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.only(right: 0,left: 0,top: 10,bottom: 10,),
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1,
      ),
    );

Widget defaultMaterialButton({
  required Size size,
  required BuildContext context,
  IconData? prefixIcon,
  IconData? suffixIcon,
  required String label,
}) =>
    Container(
      color: Colors.white,
      height: size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MaterialButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(
                prefixIcon,
                color: Colors.redAccent,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontSize: 16),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    suffixIcon,
                    color: Colors.redAccent,
                  )),
            ],
          ),
        ),
      ),
    );

Widget myMaterialButtonWithoutIcon({
  required BuildContext context,
  required String label,
  required Function onTap,
}) =>
    MaterialButton(
      height: 50,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)),
      splashColor: Colors.transparent,
      onPressed: () {
        onTap();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.button,
          ),
        ],
      ),
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String title = '',
  List<Widget>? actions,
  IconData icon = IconBroken.Arrow___Left_2,
}) =>
    PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: AppBar(
        actions: actions,
        titleSpacing: 5.0,
        title: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(icon),
        ),
      ),
    );

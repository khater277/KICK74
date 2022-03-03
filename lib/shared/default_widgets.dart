import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:kick74/styles/icons_broken.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:transparent_image/transparent_image.dart';

import 'constants.dart';


SnackbarController showSnackBar (){
  return Get.snackbar(
      "Please wait...",
      "we are poor, only have 10 requests per minute",
      titleText: const Text("Please wait..",
        style: TextStyle(
            fontSize: 20,
            color: Colors.white
        ),),
      messageText: const Text(
        "we are poor, only have 10 requests per minute",
        style: TextStyle(
            fontSize: 16,
            color: Colors.white
        ),
      ),
      icon: const Icon(
        IconBroken.Danger,
        color: Colors.white,
        size: 30,),
      duration: const Duration(seconds: 5),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: havan,
      borderRadius: 10,
      margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 15)
    //padding: const EdgeInsets.all(0)
  );
}


class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }
    return newValue;
  }
}

// ignore: must_be_immutable
class DefaultProgressIndicator extends StatelessWidget {
  final IconData icon;
  final double size;
  const DefaultProgressIndicator({Key? key, required this.icon, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlowingProgressIndicator(
            child: Icon(
              icon,
              size: size,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}

class DefaultLinerIndicator extends StatelessWidget {
  const DefaultLinerIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        LinearProgressIndicator(
          color: havan.withOpacity(0.3),
          backgroundColor: Colors.white,
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class DefaultButtonLoader extends StatelessWidget {
  final double size;
  final double width;
  final Color color;
  const DefaultButtonLoader(
      {Key? key, required this.size, required this.width, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: width,
      ),
    );
  }
}

class BackIcon extends StatelessWidget {
  final double size;
  const BackIcon({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      languageFun(
          ar: IconBroken.Arrow___Right_2, en: IconBroken.Arrow___Left_2),
      size: size,
      color: darkGrey,
    );
  }
}

Widget buildFlushBar({
  @required Color? color,
  @required String? message,
  @required Color? messageColor,
  @required int? duration,
  @required context,
  @required FlushbarPosition? position,
  @required IconData? icon,
}) {
  return Flushbar(
    backgroundColor: color!,
    messageColor: messageColor,
    message: message,
    flushbarPosition: position!,
    duration: Duration(seconds: duration!),
    icon: Icon(
      icon,
      color: messageColor,
    ),
    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
    borderRadius: BorderRadius.circular(5),
  )..show(context);
}

class FailedImage extends StatelessWidget {
  const FailedImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: double.infinity,
      child: Center(
        child: DefaultProgressIndicator(icon: IconBroken.Image,size: 80,),
      ),
    );
  }
}

class DefaultFadedImage extends StatelessWidget {
  final String imgUrl;
  final double height;
  final double width;
  const DefaultFadedImage(
      {Key? key,
      required this.imgUrl,
      required this.height,
      required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: imgUrl,
      fit: BoxFit.cover,
      height: height,
      width: width,
      imageErrorBuilder: (context, s, d) =>
          ErrorImage(width: width, height: height),
    );
  }
}

class ErrorImage extends StatelessWidget {
  final double? width;
  final double? height;
  const ErrorImage({Key? key, @required this.width, @required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              IconBroken.Danger,
              size: 50,
              color: Colors.grey,
            ),
            Text(
              "connection error",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class DefaultSvgNetworkImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  const DefaultSvgNetworkImage(
      {Key? key, required this.url, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.network(
        url,
        placeholderBuilder: (BuildContext context) => DefaultProgressIndicator(
          icon: IconBroken.Image,
          size: (width + height) / 2-10,
        ),
      ),
    );
  }
}

class DefaultNetworkImage extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  const DefaultNetworkImage(
      {Key? key, required this.url, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url != null
        ? url!.endsWith("svg")
            ? DefaultSvgNetworkImage(url: url!, width: width, height: height)
            : DefaultFadedImage(imgUrl: url!, width: width, height: height)
        : SizedBox(
            width: width,
            height: height,
            child: Image.asset('assets/images/no_image.png'));
  }
}

class DefaultElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double rounded;
  final double height;
  final double width;
  final onPressed;
  const DefaultElevatedButton(
      {Key? key,
      required this.child,
      required this.color,
      required this.rounded,
      required this.height,
      required this.width,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded),
          ),
          minimumSize: Size(width, height)),
    );
  }
}

//ignore: must_be_immutable
class DefaultOutLinedButton extends StatelessWidget {
  final Widget child;
  final double rounded;
  final double height;
  final double width;
  final onPressed;
  Color? borderColor;
  DefaultOutLinedButton(
      {Key? key,
      required this.child,
      required this.rounded,
      required this.height,
      required this.width,
      required this.onPressed,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: child,
      style: OutlinedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded),
        ),
        minimumSize: Size(width, height),
        side: BorderSide(color: borderColor ?? const Color(0xFF000000)),
      ),
    );
  }
}

class BuildBackButton extends StatelessWidget {
  const BuildBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const BackIcon(size: 22),
    );
  }
}

class NoItemsFounded extends StatelessWidget {
  final String text;
  final Widget widget;
  const NoItemsFounded({
    Key? key,
    required this.text,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget,
            const SizedBox(
              height: 15,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 20,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}

class DefaultSeparator extends StatelessWidget {
  const DefaultSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

void toastBuilder({
  @required String? msg,
  @required Color? color,
}) {
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 13.0);
}

//ignore: must_be_immutable
class DefaultTextFormFiled extends StatelessWidget {
  final TextEditingController? controller;
  final Color? textColor;
  final TextInputType? inputType;
  final IconData? prefixIcon;
  final String? label;
  final Color? borderColor;
  final Color? preIconColor;
  final String? validateText;
  double? height;
  double? cursorHeight;
  Color? suffixIconColor;
  bool? isPassword;
  // Function? onSubmit(value)?;
  // Function? onChanged(value)?;
  Function? suffixPressed;
  IconData? suffixIcon;

  DefaultTextFormFiled(
      {Key? key,
      required this.controller,
      required this.textColor,
      required this.inputType,
      required this.prefixIcon,
      required this.label,
      required this.borderColor,
      required this.preIconColor,
      this.validateText,
      this.cursorHeight,
      this.height,
      this.isPassword,
      this.suffixIcon,
      this.suffixIconColor,
      this.suffixPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: textColor,
      validator: (value) {
        if (value!.isEmpty) {
          return "$validateText can't be empty";
        }
        return null;
      },
      style: TextStyle(
        color: textColor,
      ),
      cursorHeight: cursorHeight,
      keyboardType: inputType,
      obscureText: isPassword == null ? false : isPassword!,
      //onFieldSubmitted: (value) => onSubmit!(value),
      //onChanged: (value)=>onChanged!(value),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.symmetric(vertical: height == null ? 18 : height!),
        prefixIcon: Icon(
          prefixIcon,
          color: preIconColor,
        ),
        //hintText: "ASD",
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: () => suffixPressed!(),
                icon: Icon(suffixIcon),
                color: suffixIconColor,
                //focusColor: suffixIconColor,
              )
            : null,
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: borderColor!,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: borderColor!,
            )),
        labelText: label,
        labelStyle: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}

//ignore: must_be_immutable
class DefaultTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double hintSize;
  final double height;
  final double rounded;
  final Widget suffix;
  final Color focusBorder;
  final Color border;
  bool? validate;
  bool? obscure;
  var onSubmitted;
  var onChanged;

  DefaultTextFiled(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.hintSize,
      required this.height,
      required this.suffix,
      required this.focusBorder,
      required this.border,
      this.validate,
      this.onChanged,
      this.onSubmitted,
      required this.rounded,
      this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: [NoLeadingSpaceFormatter()],
      cursorColor: focusBorder,
      controller: controller,
      onSubmitted: onSubmitted ?? (value) {},
      onChanged: onChanged ?? (value) {},
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        errorText: validate == true ? null : "$hint ${"notEmpty".tr}",
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: hintSize,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: height, horizontal: 15),
        suffixIcon: suffix,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(rounded),
            borderSide: BorderSide(
              color: border,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(rounded),
            borderSide: BorderSide(
              color: focusBorder,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(rounded),
            borderSide: BorderSide(
              color: border,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(rounded),
            borderSide: BorderSide(
              color: focusBorder,
            )),
      ),
    );
  }
}

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey.shade300,
    );
  }
}

class OfflineWidget extends StatelessWidget {
  final Widget onlineWidget;
  const OfflineWidget({Key? key, required this.onlineWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected
              ? onlineWidget
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      IconBroken.Danger,
                      size: 250,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No internet connection found",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 20,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                        ),
                      ],
                    ),
                  ],
                );
        },
        child: const Center(
          child: Text("Online OR Offline"),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class CustomTextfield extends StatefulWidget {
  CustomTextfield({
    super.key,
    required this.text,
    this.suffix = false,
  });
  final String text;
  final bool suffix;
  static GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();
  static bool complete = false;
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isNull = true;
  bool obscure = false;
  IconData iconObscure = Icons.visibility_off;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Form(
        child: TextFormField(
          cursorColor: AppColor.kPrimaryColor,
          obscureText: obscure,
          onChanged: (val) {
            setState(() {
              val.isNotEmpty
                  ? CustomTextfield.complete = true
                  : CustomTextfield.complete = false;
              if (val.isNotEmpty) {
                isNull = false;
              } else {
                isNull = true;
              }
            });
          },
          validator: (val) {
            setState(() {});
            if (val == null) {
              print(val);
              return "Error Text";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary)),
            errorBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            label: Text(
              widget.text,
              style: TextStyle(color: AppColor.kThirtColorDarkMode),
            ),
            suffix: widget.suffix
                ? isNull
                    ? null
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                            if (iconObscure == Icons.visibility) {
                              iconObscure = Icons.visibility_off;
                            } else {
                              iconObscure = Icons.visibility;
                            }
                          });
                        },
                        icon: Icon(iconObscure))
                : null,
            floatingLabelStyle: TextStyle(),
            labelStyle: TextStyle(),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
          ),
        ),
      ),
    );
  }
}

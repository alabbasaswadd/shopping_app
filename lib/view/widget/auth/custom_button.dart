import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/view/widget/auth/custom_textfield.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        color: CustomTextfield.complete == false
            ? AppColor.kSecondColor
            : AppColor.kPrimaryColor,
        textColor: Theme.of(context).colorScheme.surface,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            content: Container(
              child: ListTile(
                leading: VerticalDivider(
                  thickness: 7,
                  color: AppColor.kRedColor,
                ),
                title: Text("Single-line snack bar with close  affordance"),
                trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        if (AdaptiveTheme.of(context).mode ==
                            AdaptiveThemeMode.light) {
                          AdaptiveTheme.of(context)
                              .setDark(); // تعيين الوضع النهاري
                        } else {
                          AdaptiveTheme.of(context)
                              .setLight(); // تعيين الوضع الليلي
                        }
                      });

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    icon: Icon(Icons.close)),
              ),
            ),
          ));
        },
        child: Text("Login"),
      ),
    );
  }
}

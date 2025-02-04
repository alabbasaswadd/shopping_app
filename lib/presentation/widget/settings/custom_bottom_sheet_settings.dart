import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class CustomBottomSheetSettings extends StatelessWidget {
  const CustomBottomSheetSettings(
      {super.key, required this.widget, required this.textBottomSheet});
  final Widget widget;
  final String textBottomSheet;
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        enableDrag: true,
        showDragHandle: true,
        onClosing: () {},
        builder: (context) => SizedBox(
            height: 260,
            child: Column(children: [
              Text(
                textBottomSheet,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: widget,
              )
            ])));
  }
}

class CustomCardSettings extends StatelessWidget {
  const CustomCardSettings(
      {super.key, this.lang, required this.onChanged, this.widget});
  final String? lang;
  final Function(Object? val) onChanged;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Card(
        elevation: 8,
        color: Theme.of(context).colorScheme.secondary,
        child: InkWell(onTap: () {}, child: widget),
      ),
    );
  }
}

class CustomTextFieldSettings extends StatelessWidget {
  const CustomTextFieldSettings({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Form(
        child: TextFormField(
          cursorColor: AppColor.kPrimaryColor,
          decoration: InputDecoration(
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            label: Text(
              label,
              style: TextStyle(color: AppColor.kSecondColor),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class CustomButtonSettings extends StatelessWidget {
  const CustomButtonSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: MaterialButton(
        color: AppColor.kPrimaryColor,
        textColor: Colors.white,
        onPressed: () {},
        child: Text("Save"),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

import '../../../screens/card/card.dart';
import '../../../screens/notifications/notifications.dart';

class CustomActionsAppbarProducts extends StatelessWidget {
  const CustomActionsAppbarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Notifications.id);
              },
              icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CardPage.id);
              },
              icon: Icon(Icons.shopping_cart)),
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheet(
                        enableDrag: true,
                        showDragHandle: true,
                        onClosing: () {},
                        builder: (context) => Container(
                                child: Column(children: [
                              Text(
                                "Filter",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              CustomFilterButtonProducts(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => DatePickerDialog(
                                          firstDate: DateTime(2012),
                                          lastDate: DateTime(2100)));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(DateTime.now().toString()),
                                    Icon(Icons.calendar_month)
                                  ],
                                ),
                              ),
                              CustomFilterButtonProducts(
                                child: Text("Product(145)"),
                                onPressed: () {},
                              )
                            ]))));
              },
              icon: Icon(
                Icons.tune,
              )),
        ],
      ),
    );
  }
}

class CustomFilterButtonProducts extends StatelessWidget {
  CustomFilterButtonProducts({required this.child, required this.onPressed});

  final Widget child;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        color: AppColor.kPrimaryColor,
        textColor: AppColor.kWhiteColor,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

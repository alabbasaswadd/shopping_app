import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/presentation/screens/card.dart';
import 'package:shopping_app/presentation/screens/filter.dart';
import 'package:shopping_app/presentation/screens/notifications.dart';


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
                showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheet(
                        enableDrag: true,
                        showDragHandle: true,
                        onClosing: () {},
                        builder: (context) => const Filter()));
              },
              icon: Icon(Icons.filter_alt)),
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
        ],
      ),
    );
  }
}

class CustomFilterButtonProducts extends StatelessWidget {
 const CustomFilterButtonProducts({super.key, required this.child, required this.onPressed});

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

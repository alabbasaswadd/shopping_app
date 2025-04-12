import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/screens/card.dart';
import 'package:shopping_app/presentation/screens/filter.dart';
import 'package:shopping_app/presentation/screens/notifications.dart';

class ProductsAppbarActions extends StatelessWidget {
  const ProductsAppbarActions({super.key});

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


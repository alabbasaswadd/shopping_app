import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.children,
      required this.ontap});
  final IconData icon;
  final String title;
  final List<Widget> children;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 8,
        child: InkWell(
          onTap: ontap,
          child: ListTile(
            leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 17),
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

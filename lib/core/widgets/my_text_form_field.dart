// import 'package:flutter/material.dart';
// import 'package:shopping_app/core/constants/colors.dart';

// class MyTextFormField extends StatelessWidget {
//    MyTextFormField({
//     super.key,
//     required this.text,
//     this.suffix = false,
//     this.controller,
//   });
//   final String text;
//   final bool suffix;
//   final TextEditingController? controller;
//   static GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();
//   static bool complete = false;
//   bool isNull = true;

//   bool obscure = false;

//   IconData iconObscure = Icons.visibility_off;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       child: Form(
//         child: TextFormField(
//           controller: controller,
//           cursorColor: AppColor.kPrimaryColor,
//           obscureText: obscure,
//           onChanged: (val) {
//             val.isNotEmpty
//                 ? MyTextFormField.complete = true
//                 : MyTextFormField.complete = false;
//             if (val.isNotEmpty) {
//               isNull = false;
//             } else {
//               isNull = true;
//             }
//           },
//           validator: (val) {
//             if (val == null) {
//               return "Error Text";
//             } else {
//               return null;
//             }
//           },
//           decoration: InputDecoration(
//             border: OutlineInputBorder(borderSide: BorderSide.none),
//             focusedBorder: UnderlineInputBorder(
//                 borderSide:
//                     BorderSide(color: Theme.of(context).colorScheme.primary)),
//             errorBorder:
//                 UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
//             label: Text(
//               text,
//               style: TextStyle(color: AppColor.kThirtColorDarkMode),
//             ),
//             suffix: suffix
//                 ? isNull
//                     ? null
//                     : IconButton(
//                         onPressed: () {
//                           obscure = !obscure;
//                           if (iconObscure == Icons.visibility) {
//                             iconObscure = Icons.visibility_off;
//                           } else {
//                             iconObscure = Icons.visibility;
//                           }
//                         },
//                         icon: Icon(iconObscure))
//                 : null,
//             floatingLabelStyle: TextStyle(),
//             labelStyle: TextStyle(),
//             fillColor: Theme.of(context).colorScheme.secondary,
//             filled: true,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shopping_app/core/constants/colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {super.key, required this.label, this.controller, this.suffix});
  final String label;
  final TextEditingController? controller;
  final bool? suffix;
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

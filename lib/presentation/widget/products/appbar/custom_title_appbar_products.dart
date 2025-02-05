// import 'package:flutter/material.dart';
// import 'package:shopping_app/data/model/products_model.dart';

// class CustomTitleAppbarProducts extends StatefulWidget {
//   const CustomTitleAppbarProducts({super.key});
//   static TextEditingController controller = TextEditingController();
//   static List<ProductsModel> productsSearch = [];

//   @override
//   State<CustomTitleAppbarProducts> createState() =>
//       _CustomTitleAppbarProductsState();
// }

// class _CustomTitleAppbarProductsState extends State<CustomTitleAppbarProducts> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50,
//       child: Form(
//         child: TextFormField(
//           onChanged: (val) {
//             if (val == "f") {
//               setState(() {});
//               CustomTitleAppbarProducts.controller.text = val;
//               CustomTitleAppbarProducts.productsSearch.add(ProductsModel(
//                   title: "fff",
//                   image:
//                       "https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg",
//                   price: 41));
//             }
//           },
//           controller: CustomTitleAppbarProducts.controller,
//           decoration: InputDecoration(
//               filled: true,
//               hintText: "Search...",
//               hintStyle:
//                   TextStyle(color: Theme.of(context).colorScheme.onSurface),
//               border: OutlineInputBorder(borderSide: BorderSide.none)),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/business_logic/cubit/searching/cubit/searching_cubit.dart';

class CustomTitleAppbarProducts extends StatefulWidget {
  const CustomTitleAppbarProducts({super.key});
  static TextEditingController controller = TextEditingController();

  @override
  State<CustomTitleAppbarProducts> createState() =>
      _CustomTitleAppbarProductsState();
}

class _CustomTitleAppbarProductsState extends State<CustomTitleAppbarProducts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: CustomTitleAppbarProducts.controller,
        onChanged: (query) {
          BlocProvider.of<SearchingCubit>(context).searchProducts(query);
        },
        decoration: InputDecoration(
          filled: true,
          hintText: "Search...",
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

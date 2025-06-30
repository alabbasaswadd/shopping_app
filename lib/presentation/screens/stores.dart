import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/core/constants/colors.dart';
import 'package:shopping_app/core/constants/images.dart';
import 'package:shopping_app/core/widgets/my_app_bar.dart';
import 'package:shopping_app/core/widgets/my_card.dart';

class Stores extends StatelessWidget {
  Stores({super.key});
  static String id = "stores";

  final List<Store> stores = [
    Store(
      name: "Fashion Hub",
      image: AppImages.klogo,
      rating: 4.8,
      category: "Clothing",
    ),
    Store(
      name: "Tech Galaxy",
      image: AppImages.klogo,
      rating: 4.5,
      category: "Electronics",
    ),
    Store(
      name: "Home Comfort",
      image: AppImages.klogo,
      rating: 4.2,
      category: "Home Goods",
    ),
    Store(
      name: "Beauty Palace",
      image: AppImages.klogo,
      rating: 4.7,
      category: "Cosmetics",
    ),
    Store(
      name: "Sports World",
      image: AppImages.klogo,
      rating: 4.3,
      category: "Sporting Goods",
    ),
    Store(
      name: "Book Haven",
      image: AppImages.klogo,
      rating: 4.6,
      category: "Books",
    ),
    Store(
      name: "Toy Land",
      image: AppImages.klogo,
      rating: 4.4,
      category: "Toys",
    ),
    Store(
      name: "Gourmet Delights",
      image: AppImages.klogo,
      rating: 4.9,
      category: "Food & Beverage",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: myAppBar("stores".tr, context),
      body: Column(
        children: [
          // Search and Filter
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "search_stores".tr,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          // Categories
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip("all".tr, true),
                _buildCategoryChip("clothing".tr),
                _buildCategoryChip("electronics".tr),
                _buildCategoryChip("home".tr),
                _buildCategoryChip("beauty".tr),
                _buildCategoryChip("food".tr),
              ],
            ),
          ),
          // Stores Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 600 ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: stores.length,
              itemBuilder: (context, index) => _buildStoreCard(stores[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, [bool isActive = false]) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isActive,
        onSelected: (bool selected) {
          // Filter stores
        },
        backgroundColor: Colors.grey.withOpacity(0.1),
        selectedColor: AppColor.kPrimaryColor,
        labelStyle: TextStyle(
          color: isActive ? Colors.white : Colors.black,
        ),
        shape: StadiumBorder(
          side: BorderSide(
            color: isActive ? AppColor.kPrimaryColor : Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildStoreCard(Store store) {
    return MyCard(
      onTap: () {
        // Navigate to store
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Store Image
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                store.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Store Info
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      store.rating.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                    Spacer(),
                    Text(
                      store.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Store {
  final String name;
  final String image;
  final double rating;
  final String category;

  const Store({
    required this.name,
    required this.image,
    required this.rating,
    required this.category,
  });
}

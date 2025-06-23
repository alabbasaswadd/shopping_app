import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_app/core/constants/colors.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  DateTime _selectedDate = DateTime.now();
  final List<String> _selectedTypes = [];
  final List<String> _selectedCategories = [];
  final List<String> _selectedBrands = [];

  final List<String> _types = [
    "Image",
    "Filter",
    "Slides",
    "Ramp access",
    "Cats OK",
    "Garden",
    "Smoke-free"
  ];

  final List<String> _categories = [
    "Coffee",
    "Phones",
    "Laptops",
    "Tablets",
    "Cameras",
    "Game consoles"
  ];

  final List<String> _brands = [
    "Dell",
    "Samsung",
    "Apple",
    "Redmi",
    "Cats OK",
    "Smoke-free"
  ];

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: _FilterContent(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filter")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showFilterBottomSheet(context),
          child: const Text("Show Filters"),
        ),
      ),
    );
  }
}

class _FilterContent extends StatefulWidget {
  @override
  __FilterContentState createState() => __FilterContentState();
}

class __FilterContentState extends State<_FilterContent> {
  late DateTime _selectedDate;
  late List<String> _selectedTypes;
  late List<String> _selectedCategories;
  late List<String> _selectedBrands;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTypes = [];
    _selectedCategories = [];
    _selectedBrands = [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with drag handle
        Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),

        // Title and close button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter Products",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),

        Divider(height: 1),

        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterSection("Product Types", [], _selectedTypes),
                SizedBox(height: 24),
                _buildFilterSection("Categories", [], _selectedCategories),
                SizedBox(height: 24),
                _buildFilterSection("Brands", [], _selectedBrands),
                SizedBox(height: 24),
                _buildDateSelector(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),

        // Action buttons
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _resetFilters,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: AppColor.kPrimaryColor),
                  ),
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.kPrimaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    "Apply Filters",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(
      String title, List<String> options, List<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              selectedColor: AppColor.kPrimaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              onSelected: (selected) {
                setState(() {
                  selected
                      ? selectedOptions.add(option)
                      : selectedOptions.remove(option);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivery Date",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: _selectDate,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy-MM-dd').format(_selectedDate),
                  style: TextStyle(fontSize: 14),
                ),
                Icon(Icons.calendar_today, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.kPrimaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedTypes.clear();
      _selectedCategories.clear();
      _selectedBrands.clear();
      _selectedDate = DateTime.now();
    });
  }

  void _applyFilters() {
    Navigator.pop(context, {
      'types': _selectedTypes,
      'categories': _selectedCategories,
      'brands': _selectedBrands,
      'date': _selectedDate,
    });
  }
}

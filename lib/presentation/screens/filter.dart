import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<Filter> {
  DateTime selectedDate = DateTime.now();
  List<String> selectedTypes = [];
  List<String> selectedCategories = [];
  List<String> selectedBrands = [];

  final List<String> types = ["Image", "Filter", "Slides", "Ramp access", "Cats OK", "Garden", "Smoke-free"];
  final List<String> categories = ["Coffee", "Phones", "Laptops", "Tablets", "Cameras", "Game consoles"];
  final List<String> brands = ["Dell", "Samsung", "Apple", "Redmi", "Cats OK", "Smoke-free"];

  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Filter", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: Icon(Icons.refresh, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          selectedTypes.clear();
                          selectedCategories.clear();
                          selectedBrands.clear();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Divider(),

                _buildFilterSection("Types", types, selectedTypes),
                _buildFilterSection("Categories", categories, selectedCategories),
                _buildFilterSection("Brand", brands, selectedBrands),

                const SizedBox(height: 10),
                _buildDateSelector(),
                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Apply Filters", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterSection(String title, List<String> options, List<String> selectedOptions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              selectedColor: Colors.blue.shade100,
              onSelected: (selected) {
                setState(() {
                  selected ? selectedOptions.add(option) : selectedOptions.remove(option);
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null && pickedDate != selectedDate) {
          setState(() {
            selectedDate = pickedDate;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('dd.MM.yyyy').format(selectedDate), style: TextStyle(fontSize: 16)),
            Icon(Icons.calendar_today, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filter Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: _openFilterBottomSheet,
          child: const Text("Open Filters"),
        ),
      ),
    );
  }
}

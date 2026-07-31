import 'package:flutter/material.dart';
import 'package:nutrido/logic.dart';

class FoodInputForm extends StatefulWidget {
  final Logic logic;
  final VoidCallback onSubmit;

  const FoodInputForm({
    super.key,
    required this.logic,
    required this.onSubmit,
  });

  @override
  State<FoodInputForm> createState() => _FoodInputFormState();
}

class _FoodInputFormState extends State<FoodInputForm> {
  final List<TextEditingController> _foodItemControllers = [
    TextEditingController()
  ];

  @override
  void dispose() {
    for (var controller in _foodItemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // These values can't be const because they depend on runtime values
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final textTheme = Theme.of(context).textTheme;
    
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                
                // Header
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    _HeaderText("Log your meal!"),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Food item list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _foodItemControllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildTextField(index),
                          ),
                          if (_foodItemControllers.length > 1)
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _foodItemControllers[index].dispose();
                                  _foodItemControllers.removeAt(index);
                                });
                              },
                            ),
                        ],
                      ),
                    );
                  },
                ),
                
                // Add another item button
                InkWell(
                  onTap: () {
                    setState(() {
                      _foodItemControllers.add(TextEditingController());
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Add another item",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Analyze button - fixed width to prevent overflow
                Container(
                  width: double.infinity, // Full width container
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 200), // Constrain width
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFEDCA95),
                            Color(0xFFFD8E51),
                            Color(0xFFFF0055),
                            Color(0xFF0015FF),
                          ],
                          stops: [0.2, 0.4, 0.6, 1.0],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _handleAnalyze,
                          borderRadius: BorderRadius.circular(16),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Analyze",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Extracted method for text field to improve readability
  Widget _buildTextField(int index) {
    return TextField(
      controller: _foodItemControllers[index],
      decoration: InputDecoration(
        labelText: 'Food Item ${index + 1}',
        hintText: 'e.g., Rice 200g or 2 Rotis',
        filled: true,
        fillColor: Colors.grey[850],
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  // Extracted method for analyze button functionality
  void _handleAnalyze() {
    final foodItems = _foodItemControllers
        .where((controller) => controller.text.isNotEmpty)
        .map((controller) => controller.text)
        .join('\n, ');
    
    if (foodItems.isNotEmpty) {
      widget.logic.logMealViaText(
        foodItemsText: foodItems,
      );
      Navigator.pop(context);
      widget.onSubmit();
    }
  }
}

// Extracted widget for header text to allow const constructor
class _HeaderText extends StatelessWidget {
  final String text;
  
  const _HeaderText(this.text);
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
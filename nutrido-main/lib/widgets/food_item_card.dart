import 'package:flutter/material.dart';
import 'package:nutrido/logic.dart';
import 'package:nutrido/main.dart';
import '../models/food_item.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItem item;
  final Function setState;
  final Logic logic;

  const FoodItemCard({
    super.key,
    required this.item,
    required this.setState,
    required this.logic,
  });

  @override
  Widget build(BuildContext context) {
    final nutrients = item.calculateTotalNutrients();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${item.quantity}${item.unit}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () => _showEditDialog(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Nutrient list - column layout
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Calories
                _buildNutrientRow(
                  context,
                  'Calories',
                  nutrients['calories']?.toStringAsFixed(1) ?? '0',
                  'kcal',
                  Icons.local_fire_department_outlined,
                ),
                const SizedBox(height: 8),
                
                // Protein
                _buildNutrientRow(
                  context,
                  'Protein',
                  nutrients['protein']?.toStringAsFixed(1) ?? '0',
                  'g',
                  Icons.fitness_center_outlined,
                ),
                const SizedBox(height: 8),
                
                // Carbohydrates - with special handling for the long text
                _buildNutrientRow(
                  context,
                  'Carbohydrates',
                  nutrients['carbohydrates']?.toStringAsFixed(1) ?? '0',
                  'g',
                  Icons.grain_outlined,
                  isLongLabel: true,
                ),
                const SizedBox(height: 8),
                
                // Fat
                _buildNutrientRow(
                  context,
                  'Fat',
                  nutrients['fat']?.toStringAsFixed(1) ?? '0',
                  'g',
                  Icons.opacity_outlined,
                ),
                const SizedBox(height: 8),
                
                // Fiber
                _buildNutrientRow(
                  context,
                  'Fiber',
                  nutrients['fiber']?.toStringAsFixed(1) ?? '0',
                  'g',
                  Icons.grass_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNutrientRow(
    BuildContext context, 
    String label, 
    String value, 
    String unit, 
    IconData icon, 
    {bool isLongLabel = false}
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900], // Darker background like in the image
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[850], // Darker background for icon
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          
          // Label - with adaptive sizing for long labels
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: isLongLabel ? 14 : 16, // Smaller font for long labels
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Value - with fixed width to ensure consistent alignment
          Container(
            alignment: Alignment.centerRight,
            width: 100, // Fixed width for value
            child: Text(
              '$value$unit',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Edit Quantity',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontFamily: 'Poppins',
          ),
        ),
        content: TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter quantity in ${item.unit}',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontFamily: 'Poppins',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontFamily: 'Poppins',
          ),
          onChanged: (value) {
            double? newQuantity = double.tryParse(value);
            if (newQuantity != null) {
              setState(() {
                item.quantity = newQuantity;
                logic.updateTotalNutrients();
              });
            }
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: 'Poppins',
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              setState(() {
                logic.updateTotalNutrients();
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
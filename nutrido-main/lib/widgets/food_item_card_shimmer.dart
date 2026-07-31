import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FoodItemCardShimmer extends StatelessWidget {
  const FoodItemCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[700]!,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[800]!.withOpacity(0.3),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title placeholder
                  Container(
                    width: 120,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Row(
                    children: [
                      // Quantity pill placeholder
                      Container(
                        width: 80,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Edit button placeholder
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Nutrients section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900], // Darker background like in the image
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  // Generate 5 nutrient rows
                  _buildNutrientShimmerRow(),
                  const SizedBox(height: 8),
                  _buildNutrientShimmerRow(),
                  const SizedBox(height: 8),
                  _buildNutrientShimmerRow(isLongLabel: true), // Carbohydrates row
                  const SizedBox(height: 8),
                  _buildNutrientShimmerRow(),
                  const SizedBox(height: 8),
                  _buildNutrientShimmerRow(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildNutrientShimmerRow({bool isLongLabel = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 16),
          
          // Label - with adaptive sizing for long labels
          Expanded(
            flex: 2,
            child: Container(
              height: isLongLabel ? 14 : 16, // Smaller height for long labels
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          
          // Value - with fixed width
          Container(
            width: 80,
            height: 16,
            margin: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
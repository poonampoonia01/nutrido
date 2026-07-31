import 'package:flutter/material.dart';

Widget MacronutrientSummaryCard(
    BuildContext context, Map<String, double> dailyIntake) {
  final calories = dailyIntake['Energy'] ?? 0.0;
  const calorieGoal = 2000.0;
  final caloriePercent = (calories / calorieGoal);
  const Color mintGreen = Color(0xFFACC8A2); // Mint green from splash screen

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          mintGreen, // Changed to mint green
          mintGreen.withOpacity(0.3), // Changed to mint green with opacity
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: mintGreen.withOpacity(0.5), // Changed to mint green shadow
          blurRadius: 20,
          offset: const Offset(5, 5),
        ),
      ],
    ),
    child: Column(
      children: [
        // Calories Row (unchanged)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Calories',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  '${calories.toStringAsFixed(0)} / ${calorieGoal.toStringAsFixed(0)} kcal',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 75,
                  height: 75,
                  child: CircularProgressIndicator(
                    value: caloriePercent,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Center(
                  child: Text(
                    '${(caloriePercent * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        // ↓ Changed this Row → Column to stack indicators vertically ↓
        Column(
          children: [
            _buildMacronutrientIndicator(
              'Protein',
              dailyIntake['Protein'] ?? 0.0,
              50.0,
              Icons.fitness_center,
            ),
            const SizedBox(height: 16),
            _buildMacronutrientIndicator(
              'Carbs',
              dailyIntake['Carbohydrate'] ?? 0.0,
              275.0,
              Icons.grain,
            ),
            const SizedBox(height: 16),
            _buildMacronutrientIndicator(
              'Fat',
              dailyIntake['Fat'] ?? 0.0,
              78.0,
              Icons.opacity,
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildMacronutrientIndicator(
  String label,
  double value,
  double goal,
  IconData icon,
) {
  final percent = (value / goal).clamp(0.0, 1.0);

  return Column(
    // `spacing` was removed—Flutter's Column doesn't take `spacing`
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(height: 4),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${value.toStringAsFixed(1)}g',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            ' / ${goal.toStringAsFixed(1)}g',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 6,
        width: double.infinity,
        child: LinearProgressIndicator(
          value: percent,
          backgroundColor: Colors.white24,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          minHeight: 5,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ],
  );
}


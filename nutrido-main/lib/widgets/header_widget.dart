import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget HeaderCard(BuildContext context, DateTime selectedDate, [Function(DateTime)? onDateChanged]) {
  // Mint green color from splash screen
  const Color mintGreen = Color(0xFFACC8A2);

  // Function to show date picker
  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: mintGreen,
              onPrimary: Colors.black,
              surface: Colors.grey[900]!,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey[850],
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: mintGreen,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && onDateChanged != null) {
      onDateChanged(picked);
    }
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Nutrition',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                DateFormat('EEEE, MMMM d').format(selectedDate),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[800]?.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.calendar_today,
              color: mintGreen,
              size: 24,
            ),
            onPressed: _showDatePicker,
            tooltip: 'Select Date',
            padding: const EdgeInsets.all(8),
          ),
        ),
      ],
    ),
  );
}


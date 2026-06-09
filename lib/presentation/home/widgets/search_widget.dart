import 'package:flutter/material.dart';
import 'package:movies_app/core/confg/colors/app_colors.dart';

class MovieSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;
  final bool isSearching;

  const MovieSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
    required this.isSearching,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primary,

        onChanged: onChanged,
        decoration: InputDecoration(
          // focusedBorder: OutlineInputBorder(),
          hintText: "Search movies...",
          prefixIcon: const Icon(Icons.search, color: AppColors.primary),
          suffixIcon: isSearching
              ? IconButton(
                  icon: const Icon(Icons.close, color: AppColors.primary),
                  onPressed: onClear,
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.grey),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
      ),
    );
  }
}

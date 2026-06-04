import 'package:flutter/material.dart';

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
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: "Search movies...",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: isSearching
              ? IconButton(icon: const Icon(Icons.close), onPressed: onClear)
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}

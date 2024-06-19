import 'package:flutter/material.dart';

class SearchTexField extends StatelessWidget {
  const SearchTexField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search for treatment',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}

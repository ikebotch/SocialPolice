import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.3),
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '',
          suffixIcon: Icon(Icons.search, size: 30),
        ),
      ),
    );
  }
}

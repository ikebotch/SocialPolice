import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.3),
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: InputBorder.none,
          hintText: 'Search',
          suffixIcon: Icon(Icons.search, size: 30),
        ),
      ),
    );
  }
}

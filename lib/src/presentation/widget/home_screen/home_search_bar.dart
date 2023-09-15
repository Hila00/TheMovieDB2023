import 'package:flutter/material.dart';

class HomeScreenSearchBar extends StatelessWidget {
  static const String searchBarText = 'Search here';
  static const double searchBarPadding = 15.0;

  const HomeScreenSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(
        searchBarPadding,
      ),
      child: SearchBar(
        leading: Icon(
          Icons.search,
        ),
        hintText: searchBarText,
      ),
    );
  }
}

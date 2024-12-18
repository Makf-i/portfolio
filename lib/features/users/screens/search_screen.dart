import 'package:flutter/material.dart';
import 'package:portfolio/models/user_model.dart';

class SearchScreen extends SearchDelegate {
  final List<UserModel> userList;
  final ValueChanged<String> onSearchQueryChanged;
  final Widget Function(UserModel?) listView;

  SearchScreen({
    required this.userList,
    required this.onSearchQueryChanged,
    required this.listView,
  });

  @override
  String? get searchFieldLabel => "Search users...";

  @override
  TextStyle? get searchFieldStyle => TextStyle(
        color: const Color.fromARGB(
            255, 0, 175, 32), // Change text color of the search field
      );

  @override
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
      hintStyle: TextStyle(
          color: const Color.fromARGB(
              179, 120, 185, 157)), // Change hint text color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      isDense: true);

  @override
  TextInputType get keyboardType => TextInputType.text;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
          onSearchQueryChanged(query); // Update the state with an empty query
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Filter results based on search query
    final filteredResults = userList.where((user) {
      return user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.email.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        final val = filteredResults[index];
        return listView(val);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context); // Display the same as results
  }
}

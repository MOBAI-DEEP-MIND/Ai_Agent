import 'package:flutter/material.dart';

import 'custom_search_text_field.dart';
import 'search_result_list_view.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchTextField(controller: TextEditingController(),),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Search Results",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(child: SearchResultListView())
        ],
      ),
    );
  }
}

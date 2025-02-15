import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/search_books_cubit/search_books_cubit.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key, required this.controller});

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      decoration: InputDecoration(
          border: buildInputOutlineBorder(),
          hintText: "Search",
          suffixIcon: IconButton(
            icon: const Opacity(
              opacity: .8,
              child: Icon(
                Icons.search,
              ),
            ),
            onPressed: () {
              BlocProvider.of<SearchBooksCubit>(context)
                  .fetchSearchBooks(category: controller.text);
            },
          )),
    );
  }

  OutlineInputBorder buildInputOutlineBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(20));
  }
}

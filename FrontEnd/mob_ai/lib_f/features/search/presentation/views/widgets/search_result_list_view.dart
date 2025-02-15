import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/domain/entities/book.dart';
import '../../manager/search_books_cubit/search_books_cubit.dart';
import '../../manager/search_books_cubit/search_books_state.dart';
import 'custom_result_list_view_item.dart' show CustomResultListViewItem;

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBooksCubit, SearchBooksState>(
      builder: (context, state) {
        if (state is SearchBooksSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount:10,
            itemBuilder: (context, index) =>
                CustomResultListViewItem(book: Book(id: 1, title: 'title', url: 'url', description: 'description', price: 121,publisher: 'publisher', publicationDate: 'author',),),
          );
        } else if (state is SearchBooksFailure) {
          return Center(
            child: Text(state.errMessage),
          );
        } else if (state is SearchBooksLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_books_state.dart'
    show
        InitialState,
        SearchBooksFailure,
        SearchBooksLoading,
        SearchBooksState,
        SearchBooksSuccess;

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit() : super(InitialState());
  // final HomeRepo homerepo;
  Future<void> fetchSearchBooks({required String category}) async {
    emit(SearchBooksLoading());
    emit(SearchBooksSuccess([]));
    var response;
    // var response = await homerepo.fetchSearchedBook(bookName: category);
    response.fold(
      (failure) {
        emit(SearchBooksFailure(failure.errMessage));
      },
      (books) {
        emit(SearchBooksSuccess(books));
      },
    );
  }
}

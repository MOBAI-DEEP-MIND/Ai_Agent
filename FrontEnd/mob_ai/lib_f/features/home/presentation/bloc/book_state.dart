part of 'book_bloc.dart';

@immutable
sealed class BookState {}

final class BookInitial extends BookState {}

final class BookLoading extends BookState {}

final class FetchBooksSuccess extends BookState {
  final List<Book> books;
  FetchBooksSuccess({required this.books});
}
final class FetchRecommendedBooksSuccess extends BookState {
  final List<Book> books;
  FetchRecommendedBooksSuccess({required this.books});
}
final class FetchBooksfailure extends BookState {
  final String errMessage;
  FetchBooksfailure({required this.errMessage});
}
final class FetchBooksByAISuccess extends BookState {
  final List<Book> books;
 FetchBooksByAISuccess({required this.books});
}


final class AddBookToCartSuccess  extends BookState {
  final Book book;
  AddBookToCartSuccess({required this.book});
}

final class AddBookToCartFailure extends BookState {
  final String errMessage;
  AddBookToCartFailure({required this.errMessage});
}

final class FetchBooksInCartSuccess extends BookState {
  final List<Book> books;
 FetchBooksInCartSuccess({required this.books});
}

final class FetchBooksInCartfailure extends BookState {
  final String errMessage;
  FetchBooksInCartfailure({required this.errMessage});
}

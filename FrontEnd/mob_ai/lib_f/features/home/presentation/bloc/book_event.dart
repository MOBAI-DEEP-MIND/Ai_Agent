part of 'book_bloc.dart';

@immutable
sealed class BookEvent {}

class FetchBooks extends BookEvent {}

class FetchBooksInCart extends BookEvent {}

class FetchRecommended extends BookEvent {}

class FetchBooksByAI extends BookEvent {
  final Message message;
  FetchBooksByAI(this.message);
}

class AddBookToCart extends BookEvent {
  final Book book;
  AddBookToCart(this.book);
}

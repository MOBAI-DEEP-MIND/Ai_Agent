
import '../../../../home/domain/entities/book.dart';

abstract class SearchBooksState {}

class InitialState extends SearchBooksState {}

class SearchBooksSuccess extends SearchBooksState{
  final List<Book> books;
  SearchBooksSuccess(this.books);
}

class SearchBooksLoading extends SearchBooksState {}

class SearchBooksFailure extends SearchBooksState{
  String errMessage;
  SearchBooksFailure(this.errMessage);
}
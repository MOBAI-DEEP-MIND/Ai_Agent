import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/use_case.dart';
import '../../../AI-Assistant/domain/entity/message.dart';
import '../../../AI-Assistant/domain/usecase/send_message.dart';
import '../../domain/entities/book.dart';
import '../../domain/usecase/add_book_to cart.dart';
import '../../domain/usecase/fetch_books.dart';
import '../../domain/usecase/get_books_in_cart.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final FetchBooksUseCase _fetchBooks;
  final AddBookToCartUseCase _addBookToCart;
  final GetBooksInCartUseCase _getBooksInCartUseCase;
  final SendMessage _sendMessage;
  List<Book> booksInCart = [];
  BookBloc({
    required FetchBooksUseCase fetchBooks,
    required AddBookToCartUseCase addBookToCart,
    required GetBooksInCartUseCase getBooksInCartUseCase,
    required SendMessage sendMessage,
  }) : _addBookToCart = addBookToCart,
       _fetchBooks = fetchBooks,
       _sendMessage = sendMessage,
       _getBooksInCartUseCase = getBooksInCartUseCase,
       
       super(BookInitial()) {
    on<BookEvent>((event, emit) {
      emit(BookLoading());
    });
    on<FetchBooks>((event, emit) async {
      final response = await _fetchBooks(NoParams());
      response.fold(
        (failure) {
          emit(FetchBooksfailure(errMessage: failure.errMessage));
        },
        (books) {
          emit(FetchBooksSuccess(books: books));
        },
      );
    });
   
    // FetchRecommended
    on<FetchBooksInCart>((event, emit) async {
      final response = await _getBooksInCartUseCase(NoParams());
      response.fold(
        (failure) {
          emit(FetchBooksInCartfailure(errMessage: failure.errMessage));
        },
        (books) {
          emit(FetchBooksInCartSuccess(books: books));
        },
      );
    });
    on<AddBookToCart>((event, emit) async {
      final response = await _addBookToCart(AddBookToCartParams(event.book));
      response.fold(
        (failure) {
          emit(AddBookToCartFailure(errMessage: failure.errMessage));
        },
        (book) {
          emit(AddBookToCartSuccess(book: book));
        },
      );
    });
    on<FetchBooksByAI>((event, emit) async {
      final response = await _sendMessage(
        MessageParams(message: event.message),
      );
      response.fold(
        (failure) {
          emit(FetchBooksfailure(errMessage: failure.errMessage));
        },
        (books) {
          emit(FetchBooksByAISuccess(books: books));
        },
      );
    });
  }
}

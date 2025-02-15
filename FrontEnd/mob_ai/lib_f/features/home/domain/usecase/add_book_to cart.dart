import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/book.dart';
import '../repository/books_repository.dart';

class AddBookToCartUseCase implements UseCase<Book,AddBookToCartParams> {
  final BooksRepository blogRepository;
  AddBookToCartUseCase(this.blogRepository);
  @override
  Future<Either<Failure, Book>> call(AddBookToCartParams params) async {
    return await blogRepository.addBookToMyCart( params.book);
  }
}
class AddBookToCartParams {
  final Book book;
  AddBookToCartParams(this.book);
}

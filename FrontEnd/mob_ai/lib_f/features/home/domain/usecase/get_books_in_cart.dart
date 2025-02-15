import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/book.dart';
import '../repository/books_repository.dart';

class GetBooksInCartUseCase implements UseCase<List<Book>, NoParams> {
  final BooksRepository blogRepository;
  GetBooksInCartUseCase(this.blogRepository);
  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) async {
    return await blogRepository.getCartBooks();
  }
}

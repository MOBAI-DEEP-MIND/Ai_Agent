import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/book.dart';
import '../repository/books_repository.dart';

class FetchRecomendedBooksUseCase implements UseCase<List<Book>, NoParams> {
  final BooksRepository blogRepository;
  FetchRecomendedBooksUseCase(this.blogRepository);
  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) async {
    return await blogRepository.fetchBooks();
  }
}

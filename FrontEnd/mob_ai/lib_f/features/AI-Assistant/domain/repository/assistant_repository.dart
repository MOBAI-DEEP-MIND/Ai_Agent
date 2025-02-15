import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../../../home/domain/entities/book.dart';
import '../entity/message.dart';

abstract interface class AssistantRepository {
  Future <Either<Failure,List<Book>>> sendMessage({required Message message});
}
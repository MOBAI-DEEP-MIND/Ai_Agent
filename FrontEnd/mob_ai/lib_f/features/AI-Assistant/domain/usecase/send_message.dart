import 'package:fpdart/src/either.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/use_case.dart';
import '../../../home/domain/entities/book.dart';
import '../entity/message.dart';
import '../repository/assistant_repository.dart';

class SendMessage implements UseCase<List<Book>, MessageParams> {
  final AssistantRepository assisstantRepository;
  SendMessage(this.assisstantRepository);
  @override
  Future<Either<Failure, List<Book>>> call(params) async {
    return await assisstantRepository.sendMessage(message: params.message);
  }
}

class MessageParams {
  final Message message;
  MessageParams({required this.message});
}

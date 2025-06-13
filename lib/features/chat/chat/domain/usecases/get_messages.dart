import 'package:dartz/dartz.dart';
import 'package:trust_zone/core/error/failure.dart';
import 'package:trust_zone/features/chat/chat/domain/entities/message_entity.dart';
import 'package:trust_zone/features/chat/chat/domain/repos/message_repo.dart';

class GetMessagesUseCase {
  final MessageRepository repository;

  GetMessagesUseCase(this.repository);

  Future<Either<Failure, List<MessageEntity>>> call(int conversationId) async {
    try {
      final messages = await repository.getMessages(conversationId, 1);
      return Right(messages); // MessageModel extends MessageEntity
    } catch (e) {
      return Left(ServerFailure(error: 'error')); // أو نوع الفشل اللي عندك
    }
  }
}


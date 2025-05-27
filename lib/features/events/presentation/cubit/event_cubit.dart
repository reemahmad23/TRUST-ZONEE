import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/event.dart';
import '../../domain/repositories/event_repository.dart';
part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final EventRepository repository;

  EventCubit(this.repository) : super(EventInitial());

  Future<void> fetchEvents() async {
    emit(EventLoading());
    try {
      final events = await repository.getEvents();
      emit(EventLoaded(events));
    } catch (e) {
      emit(EventError('Failed to load events'));
    }
  }
}
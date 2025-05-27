import 'package:dio/dio.dart';
import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<List<EventModel>> getEvents();
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final Dio dio;

  EventRemoteDataSourceImpl(this.dio);

  @override
  Future<List<EventModel>> getEvents() async {
    final response = await dio.get('https://trustzone.azurewebsites.net/api/Event');
    final List data = response.data;
    return data.map((e) => EventModel.fromJson(e)).toList();
  }
}
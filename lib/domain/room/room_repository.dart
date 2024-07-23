import 'package:simple_sns_app/domain/room/room_entity.dart';
import 'package:simple_sns_app/utils/api.dart';

class RoomRepository {
  Future<List<Room>> getRooms() async {
    try {
      final res = await api.get('/rooms');
      final rooms = (res.data['rooms'] as List<dynamic>)
          .map((room) => Room.fromJson(room))
          .toList();
      return rooms;
    } catch (e) {
      throw Exception('Failed to get rooms: $e');
    }
  }
}

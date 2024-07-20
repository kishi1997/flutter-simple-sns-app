import 'package:simple_sns_app/domain/room/room_entity.dart';
import 'package:simple_sns_app/domain/room/room_repository.dart';

class RoomService {
  Future<List<Room>> getRooms() async {
    final rooms = await RoomRepository().getRooms();
    return rooms;
  }

  Future<Room> findRoom(String roomId) async {
    final room = await RoomRepository().findRoom(roomId);
    return room;
  }
}

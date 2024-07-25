import 'package:flutter/material.dart';
import 'package:simple_sns_app/components/header/app_header.dart';
import 'package:simple_sns_app/domain/room/room_entity.dart';
import 'package:simple_sns_app/domain/room/room_service.dart';
import 'package:simple_sns_app/utils/logger_utils.dart';
import 'package:simple_sns_app/widgets/room/room_tile.dart';

class RoomListScreen extends StatefulWidget {
  const RoomListScreen({super.key});
  @override
  RoomListScreenState createState() => RoomListScreenState();
}

class RoomListScreenState extends State<RoomListScreen> {
  List<Room> _rooms = [];
  bool _isLoading = false;

  Future<void> fetchRooms() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final rooms = await RoomService().getRooms();
      setState(() {
        _rooms = rooms;
      });
    } catch (e) {
      logError(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_rooms.isEmpty) {
      return const Center(child: Text('チャットルームは存在しません'));
    }

    return Center(
      child: ListView.builder(
        itemCount: _rooms.length,
        itemBuilder: (BuildContext context, int index) {
          final room = _rooms[index];
          return RoomTile(
            room: room,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchRooms();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'ルーム一覧'),
      body: Padding(
          padding: const EdgeInsets.only(
            top: 0,
            right: 24.0,
            bottom: 24.0,
            left: 24.0,
          ),
          child: _buildBody()),
    );
  }
}

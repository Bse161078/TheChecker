// ignore_for_file: public_member_api_docs, sort_constructors_first

class NotificationModel {
  final String roomName;
  final String roomId;
  final List<String> reports;

  NotificationModel({
    required this.roomName,
    required this.roomId,
    required this.reports,
  });

  @override
  String toString() {
    return 'NotificationModel(roomName: $roomName, roomId: $roomId, reports: $reports)';
  }
}

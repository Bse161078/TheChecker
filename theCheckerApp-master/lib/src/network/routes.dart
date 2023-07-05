class Routes {
  static const String baseURL = 'https://the-checkerapp.com:3000';

  static const String login = "$baseURL/auth/login";
  static const String profile = "$baseURL/auth/check-login";
  static const String cleaner = "$baseURL/cleaner";
  static const String room = "$baseURL/room";
  static const String floor = "$baseURL/floor";
  static const String bed = "$baseURL/bed";
  static const String shelves = "$baseURL/shelves";
  static const String bathroom = "$baseURL/bathroom";
  static const String curtains = "$baseURL/curtains";
  static const String set_room_status = "$baseURL/room/set-room-status";
  static const String send_alert = "$baseURL/room/send-alert";
  static const String materials = "$baseURL/material-list";
}

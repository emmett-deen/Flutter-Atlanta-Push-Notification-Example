import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notification with _$Notification {
  factory Notification({
    String? id,
    required String title,
    required String body,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) =>
    _$NotificationFromJson(json);
}
import 'package:flutter/material.dart';
import 'package:virtualclass/core/http_service.dart';

class NotificationsModel extends ChangeNotifier {
  List<dynamic> userNotification = [];

  Future<dynamic> getNotifications() async {
    var response = await HttpService.getrequest('notifications');
    if (response is int) {
      return userNotification;
    } else {
      userNotification = response;
      return userNotification;
    }
  }

  Future<dynamic> getSomecnotifications() async {
    var response = await HttpService.getrequest('notifications?amount=3');
    if (response is int) {
      return userNotification;
    } else {
      userNotification = response;
      return userNotification;
    }
  }
}

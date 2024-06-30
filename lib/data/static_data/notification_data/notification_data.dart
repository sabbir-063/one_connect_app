// notification_data.dart

import 'package:flutter/material.dart';
import '../../../models/notificationModel/notification_model.dart';

List<NotificationModel> mockNotifications = [
  NotificationModel(
    id: 0,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    header: "Donation Received",
    subheader: "You received a donation of 50 Taka from John Doe.",
  ),
  NotificationModel(
    id: 1,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    header: "Donation Received",
    subheader: "You received a donation of 50 Taka from John Doe.",
  ),
  NotificationModel(
    id: 2,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    header: "Donation Made",
    subheader: "You donated 20 Taka to support Education Fund.",
  ),
  NotificationModel(
    id: 3,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    header: "Donation Processed",
    subheader: "Your donation of 30 Taka to Animal Shelter was processed.",
  ),
  NotificationModel(
    id: 4,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    header: "Donation Received",
    subheader: "You received a donation of 50 Taka from John Doe.",
  ),
  NotificationModel(
    id: 5,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    header: "Donation Made",
    subheader: "You donated 20 Taka to support Education Fund.",
  ),
  NotificationModel(
    id: 6,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    header: "Donation Processed",
    subheader: "Your donation of 30 Taka to Animal Shelter was processed.",
  ),
  NotificationModel(
    id: 7,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    header: "Donation Received",
    subheader: "You received a donation of 50 Taka from John Doe.",
  ),
  NotificationModel(
    id: 8,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    header: "Donation Made",
    subheader: "You donated 20 Taka to support Education Fund.",
  ),
  NotificationModel(
    id: 9,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    header: "Donation Processed",
    subheader: "Your donation of 30 Taka to Animal Shelter was processed.",
  ),
  NotificationModel(
    id: 10,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    header: "Donation Received",
    subheader: "You received a donation of 50 Taka from John Doe.",
  ),
  NotificationModel(
    id: 11,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    header: "Donation Made",
    subheader: "You donated 20 Taka to support Education Fund.",
  ),
  NotificationModel(
    id: 12,
    source: "OneConnect",
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    header: "Donation Processed",
    subheader: "Your donation of 30 Taka to Animal Shelter was processed.",
  ),
];

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AdminAnalysis/donation_charts.dart';
import '../controllers/admin_profile.controller.dart';

class AdminGraphStaticsPage extends StatelessWidget {
  const AdminGraphStaticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AdminController adminController = Get.find<AdminController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Oneconnect Analysis'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (adminController.isLoadingCharts.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DonationGivenChart(
                  users: adminController.dataController.users,
                ),
                const SizedBox(height: 20),
                DonationReceivedChart(
                  users: adminController.dataController.users,
                ),
                const SizedBox(height: 20),
                DonationNeededVsRaisedChart(
                  posts: adminController.dataController.posts,
                ),
                const SizedBox(height: 20),
                DaywisePostCountChart(
                  posts: adminController.dataController.posts,
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

import 'package:get/get.dart';

import '../../../data/static_data/donation_data/donation_data.dart';
import '../../../models/DonationModel/donation_model.dart';

class DonationHistoryController extends GetxController {
  var donations = <DonationModel>[].obs;
  var filteredDonations = <DonationModel>[].obs;
  var startDate = DateTime.now().subtract(const Duration(days: 30)).obs;
  var endDate = DateTime.now().obs;


  void fetchData(String email) {
    donations.value = DonationData.sampleData.where((d) => d.email == email).toList();
    filterDonations();
  }

  void filterDonations() {
    DateTime start = startDate.value;
    DateTime end = endDate.value;

    filteredDonations.value = donations
        .where((d) => d.timestamp.isAfter(start) && d.timestamp.isBefore(end))
        .toList();
  }

  void changeStartDate(DateTime date) {
    startDate.value = date;
    filterDonations();
  }

  void changeEndDate(DateTime date) {
    endDate.value = date;
    filterDonations();
  }
}

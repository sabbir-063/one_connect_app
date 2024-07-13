import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../models/CreatePostModel/admin_post_model.dart';
import '../../models/UserModel/user_model.dart';

class DonationGivenChart extends StatelessWidget {
  final List<UserModel> users;

  const DonationGivenChart({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Total Donations Given by Users',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: users.length *
                      50.0, // Adjust the width based on the number of users
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: users.asMap().entries.map((entry) {
                            int index = entry.key;
                            UserModel user = entry.value;
                            return FlSpot(index.toDouble(),
                                user.donationGiven.toDouble());
                          }).toList(),
                          isCurved: true,
                          color: Colors.blue,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(show: true),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index < 0 || index >= users.length) {
                                return const Text('');
                              }
                              return Text(
                                users[index].lastName,
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonationReceivedChart extends StatelessWidget {
  final List<UserModel> users;

  const DonationReceivedChart({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            const Text('Total Donations Received by Users'),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: users.length *
                      50.0, // Adjust the width based on the number of users
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: users.asMap().entries.map((entry) {
                            int index = entry.key;
                            UserModel user = entry.value;
                            return FlSpot(index.toDouble(),
                                user.donationReceived.toDouble());
                          }).toList(),
                          isCurved: true,
                          color: Colors.green,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(show: true),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index < 0 || index >= users.length) {
                                return const Text('');
                              }
                              return Text(
                                users[index].lastName,
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DonationNeededVsRaisedChart extends StatelessWidget {
  final List<AdminPostModel> posts;

  const DonationNeededVsRaisedChart({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            const Text('Donation Needed vs. Donation Raised for Posts'),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  barGroups: posts.asMap().entries.map((entry) {
                    int index = entry.key;
                    AdminPostModel post = entry.value;
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: post.donationNeeded.toDouble(),
                          color: Colors.red,
                        ),
                        BarChartRodData(
                          toY: post.donationRaised.toDouble(),
                          color: Colors.green,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DaywisePostCountChart extends StatelessWidget {
  final List<AdminPostModel> posts;

  const DaywisePostCountChart({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    // Create a map of days to post count
    final Map<String, int> daywisePostCount = {};

    for (var post in posts) {
      final day = DateFormat('dd/MM/yyyy').format(post.timestamp);
      if (daywisePostCount.containsKey(day)) {
        daywisePostCount[day] = daywisePostCount[day]! + 1;
      } else {
        daywisePostCount[day] = 1;
      }
    }

    // Set the range of dates
    DateTime startDate = DateFormat('dd/MM/yyyy').parse('10/07/2024');
    DateTime endDate = DateFormat('dd/MM/yyyy').parse('20/07/2024');

    // Ensure all days between the start and end dates are included in the map
    while (startDate.isBefore(endDate) || startDate.isAtSameMomentAs(endDate)) {
      final day = DateFormat('dd/MM/yyyy').format(startDate);
      daywisePostCount.putIfAbsent(day, () => 0);
      startDate = startDate.add(const Duration(days: 1));
    }

    // Sort the days
    final sortedDays = daywisePostCount.keys.toList()
      ..sort((a, b) => DateFormat('dd/MM/yyyy')
          .parse(a)
          .compareTo(DateFormat('dd/MM/yyyy').parse(b)));

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Daywise Post Count',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: sortedDays.length *
                      60.0, // Adjust the width based on the number of days
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: sortedDays.asMap().entries.map((entry) {
                            int index = entry.key;
                            String day = entry.value;
                            return FlSpot(
                              index.toDouble(),
                              daywisePostCount[day]!.toDouble(),
                            );
                          }).toList(),
                          isCurved: true,
                          color: Colors.green,
                          barWidth: 4,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(show: true),
                        ),
                      ],
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 12),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index < 0 || index >= sortedDays.length) {
                                return const Text('');
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 8.0,
                                child: Transform.rotate(
                                  angle: 0, // -90 degrees in radians
                                  child: Text(
                                    sortedDays[index],
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: true),
                      minY: 0, // Start the y-axis from 0
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

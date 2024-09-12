import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/features/authentication/screens/login/login.dart';
import 'package:one_connect_app/utils/constants/colors.dart';

class DonationOnboardingPage extends StatelessWidget {
  final List<Map<String, String>> featureList = [
    {
      'title': 'Seeking Donation',
      'description':
          'Users can post requests for donations and receive support from the community.',
      'image':
          'assets/images/onboarding/img1.png' // Replace with your own image path
    },
    {
      'title': 'Central Fund',
      'description':
          'Users can contribute to our central fund to help those in need.',
      'image':
          'assets/images/onboarding/img2.png' // Replace with your own image path
    },
    {
      'title': 'Help the Poor',
      'description':
          'We donate to poor people from our central fund to provide them with essential support.',
      'image':
          'assets/images/onboarding/img3.jfif' // Replace with your own image path
    },
    {
      'title': 'Top Donators',
      'description':
          'Users can view the list of top donators and get inspired by their generosity.',
      'image':
          'assets/images/onboarding/img4.png' // Replace with your own image path
    },
  ];

  final List<Map<String, String>> quotes = [
    {
      'quote': '“No one has ever become poor by giving.” – Anne Frank',
      'image':
          'assets/images/quotes/anne_frank.jfif' // Replace with your own image path
    },
    {
      'quote':
          '“It’s not how much we give but how much love we put into giving.” – Mother Teresa',
      'image':
          'assets/images/quotes/mother_teresa.jfif' // Replace with your own image path
    },
    {
      'quote': '“For it is in giving that we receive.” – Francis of Assisi',
      'image':
          'assets/images/quotes/francis_of_assisi.jfif' // Replace with your own image path
    },
  ];

// List of team members
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Mohammad Sabbir Musfique',
      'designation': 'Leader',
      'image':
          'assets/images/team/sabbir_musfique.jpg' // Replace with your own image path
    },
    {
      'name': 'Maar Zuun',
      'designation': 'Frontend Developer',
      'image':
          'assets/images/team/maar_zuun.jpg' // Replace with your own image path
    },
    {
      'name': 'Arr Rafi',
      'designation': 'Frontend Developer',
      'image':
          'assets/images/team/arr_rafi.jpg' // Replace with your own image path
    },
    {
      'name': 'Abdullah Omar Nasif',
      'designation': 'Backend Developer',
      'image':
          'assets/images/team/abdullah_omar_nasif.jpg' // Replace with your own image path
    },
    {
      'name': 'Imran Khan',
      'designation': 'Database Expert',
      'image':
          'assets/images/team/imran_khan.jpg' // Replace with your own image path
    },
  ];

  DonationOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to ONECONNECT'),
        centerTitle: true,
        backgroundColor: OneColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ...featureList.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        feature['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feature['description']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(
                          feature['image']!,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 250,
                        ),
                      ),
                      const Divider(height: 5),
                      const SizedBox(height: 50),
                    ],
                  ),
                )),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Famous Quotes on Giving',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ...quotes.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, String> quote = entry.value;

                    bool isImageLeft = index % 2 == 0;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: [
                          if (isImageLeft)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                quote['image']!,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 150,
                              ),
                            ),
                          Expanded(
                            child: Padding(
                              padding: isImageLeft
                                  ? const EdgeInsets.only(left: 10.0)
                                  : const EdgeInsets.only(right: 10.0),
                              child: Text(
                                quote['quote']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          if (!isImageLeft)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                quote['image']!,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 150,
                              ),
                            ),
                        ],
                      ),
                    );
                  }),

                  const Divider(height: 2),
                  // Meet Our Team section code
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Meet Our Team',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        // Leader
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage(teamMembers[0]['image']!),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              teamMembers[0]['name']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              teamMembers[0]['designation']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Other team members
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 20,
                            childAspectRatio: 3 / 4,
                          ),
                          itemCount: teamMembers.length - 1,
                          itemBuilder: (context, index) {
                            final teamMember = teamMembers[index + 1];
                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage(teamMember['image']!),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  teamMember['name']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  teamMember['designation']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 20),
            const Divider(height: 2),
            const Footer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const LoginScreen());
        },
        tooltip: 'Go to Login',
        child: const Icon(Icons.login),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Join us in making a difference!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Together, we can help those in need and build a better community.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Divider(height: 2),
          SizedBox(height: 10),
          Text(
            '© 2024 ONECONNECT. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

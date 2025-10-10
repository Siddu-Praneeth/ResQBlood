// ignore_for_file: depend_on_referenced_packages
import 'package:blood_donation_app/Request_page.dart';
import 'package:blood_donation_app/bloodcamp_page.dart';
import 'package:blood_donation_app/donate_page.dart';
import 'package:blood_donation_app/emergency.dart';
import 'package:blood_donation_app/hospital_names.dart';
import 'package:blood_donation_app/hospital_place.dart';
import 'package:blood_donation_app/profile_page.dart' as profile;
import 'package:blood_donation_app/nav_bar.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RequestData {
  static final RequestData _instance = RequestData._internal();
  factory RequestData() => _instance;
  RequestData._internal();

  List<Map<String, dynamic>> requests = [
    {
      "id": 1,
      "name": "Siddu",
      "bloodGroup": "O+",
      "units": 12.5,
      "location": "Apollo Hospital",
      "date": "28 Sep 2025",
      "status": "Urgent",
    },
    {
      "id": 2,
      "name": "Sasi",
      "bloodGroup": "O+",
      "units": 9,
      "location": "Yashoda Hospital",
      "date": "29 Sep 2025",
      "status": "Critical",
    },
    {
      "id": 3,
      "name": "Divya",
      "bloodGroup": "B+",
      "units": 9,
      "location": "Yash Hospital",
      "date": "26 Sep 2025",
      "status": "Critical",
    },
    {
      "id": 4,
      "name": "Rajita",
      "bloodGroup": "OB+",
      "units": 8,
      "location": "Siva Hospital",
      "date": "27 Sep 2025",
      "status": "Critical",
    },
    {
      "id": 5,
      "name": "Rajesh",
      "bloodGroup": "A+",
      "units": 7,
      "location": "Satya Hospital",
      "date": "28 Sep 2025",
      "status": "Urgent",
    },
    {
      "id": 6,
      "name": "Sai",
      "bloodGroup": "AB+",
      "units": 8,
      "location": "Manjeera Hospital",
      "date": "30 Sep 2025",
      "status": "Critical",
    },
  ];
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> requests = [];
  int activeIndex = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    requests = RequestData().requests;
  }

  int calculateDaysLeft() {
    DateTime lastDonation = DateTime(2025, 8, 28);
    DateTime nextDonation = lastDonation.add(const Duration(days: 90));
    return nextDonation.difference(DateTime.now()).inDays;
  }

  void _acceptRequest(Map<String, dynamic> req) {
    setState(() {
      RequestData().requests.removeWhere((r) => r["id"] == req["id"]);
      requests = RequestData().requests;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("✅ Accepted ${req["name"]}")));
  }

  void _declineRequest(Map<String, dynamic> req) {
    setState(() {
      RequestData().requests.removeWhere((r) => r["id"] == req["id"]);
      requests = RequestData().requests;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("❌ Declined ${req["name"]}")));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on Home screen, do nothing
        break;
      case 1:
        // Navigate to Donate page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BloodDonationCampsPage()),
        );
        break;
      // case 2:
      //   // Navigate to Request page
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => BloodRequestScreen()),
      //   );
      //   break;
      case 2:
        // Navigate to Donate page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => profile.ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    int daysLeft = calculateDaysLeft();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            floating: false,
            expandedHeight: 100,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ResQblood",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      daysLeft > 0
                          // ? "$daysLeft days left for next donation"
                          ? "17 days left for next donation"
                          : "Eligible for donation now 🎉",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    height: 90,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://www.shutterstock.com/image-vector/donor-typography-banner-template-volunteers-260nw-2135275545.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureCard(
                        imageUrl:
                            "https://static.vecteezy.com/system/resources/previews/019/152/949/non_2x/hand-holding-a-drop-of-blood-world-blood-donor-day-blood-donation-illustration-donor-symbol-blood-donation-symbol-free-png.png",
                        buttonText: "Request for blood",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BloodRequestScreen()),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildFeatureCard(
                        imageUrl:
                            "https://cdn-icons-png.flaticon.com/512/3047/3047768.png",
                        buttonText: "Donate blood",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BloodDonationScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CarouselSlider.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index, realIdx) {
                      final req = requests[index];
                      return Container(
                        width: 280,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    req["bloodGroup"],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    req["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  req["status"],
                                  style: TextStyle(
                                    color: req["status"] == "Normal"
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text("${req["units"]} Units (Blood)"),
                            Text(req["location"]),
                            Text(req["date"]),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ActionChip(
                                  backgroundColor: Colors.green,
                                  label: const Text(
                                    "Accept",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => _acceptRequest(req),
                                ),
                                const SizedBox(width: 6),
                                ActionChip(
                                  backgroundColor: Colors.red,
                                  label: const Text(
                                    "Decline",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () => _declineRequest(req),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 200,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() => activeIndex = index);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: requests.length,
                      effect: const ExpandingDotsEffect(
                        activeDotColor: Colors.red,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFeatureCard(
                        imageUrl:
                            "https://cdn-icons-png.flaticon.com/512/7686/7686512.png",
                        buttonText: "Hospitals",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HospitalPlace()),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      _buildFeatureCard(
                        imageUrl:
                            "https://cdn-icons-png.flaticon.com/512/9746/9746682.png",
                        buttonText: "Emergency",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EmergencyScreen())
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Replaced with the custom navigation bar
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildFeatureCard({
    required String imageUrl,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 175,
      width: 170,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 234, 233, 233),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Image.network(imageUrl, height: 65, width: 65),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(buttonText, style: const TextStyle(color: Colors.red)),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
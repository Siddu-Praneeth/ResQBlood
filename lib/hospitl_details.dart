import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

class HospitalDetails extends StatefulWidget {
  final Map<String, dynamic> hospitalData;

  const HospitalDetails({super.key, required this.hospitalData});

  @override
  State<HospitalDetails> createState() => _HospitalDetailsState();
}

class _HospitalDetailsState extends State<HospitalDetails>
    with TickerProviderStateMixin {
  bool showInfo = false;
  late TabController _tabController;
  double userRating = 0;
  int currentImageIndex = 0;

  // Sample data - you can replace this with dynamic data
  final List<String> hospitalImages = [
    'https://via.placeholder.com/400x200/FF6B6B/FFFFFF?text=Hospital+Front',
    'https://via.placeholder.com/400x200/4ECDC4/FFFFFF?text=Emergency+Ward',
    'https://via.placeholder.com/400x200/45B7D1/FFFFFF?text=Blood+Bank',
    'https://via.placeholder.com/400x200/96CEB4/FFFFFF?text=Reception',
  ];

  final List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  final Map<String, bool> bloodAvailability = {
    'A+': true,
    'A-': false,
    'B+': true,
    'B-': true,
    'AB+': false,
    'AB-': true,
    'O+': true,
    'O-': false,
  };

  final List<String> services = [
    'Emergency Services 24/7',
    'Blood Bank',
    'ICU',
    'Laboratory',
    'X-Ray',
    'Pharmacy',
    'Ambulance Service',
    'Blood Donation Camp',
  ];

  final Map<String, String> operatingHours = {
    'Emergency': '24/7',
    'Blood Bank': '6:00 AM - 10:00 PM',
    'General OPD': '9:00 AM - 5:00 PM',
    'Laboratory': '6:00 AM - 8:00 PM',
  };

  final List<Map<String, dynamic>> reviews = [
    {
      'name': 'Rajesh Kumar',
      'rating': 4.5,
      'comment': 'Excellent service and very helpful staff. Blood donation process was smooth.',
      'date': '2024-09-15'
    },
    {
      'name': 'Priya Sharma',
      'rating': 5.0,
      'comment': 'Clean facility and professional staff. Highly recommended for blood donation.',
      'date': '2024-09-10'
    },
    {
      'name': 'Mohammed Ali',
      'rating': 4.0,
      'comment': 'Good location and easy to find. Staff was courteous.',
      'date': '2024-09-05'
    },
  ];

  // Nearby hospitals sample data
  final List<Map<String, dynamic>> nearbyHospitals = [
    {
      'name': 'City Medical Center',
      'distance': '2.5 km',
      'contact': '9876543210',
      'rating': 4.2,
    },
    {
      'name': 'Apollo Hospital Branch',
      'distance': '3.1 km',
      'contact': '9765432109',
      'rating': 4.7,
    },
    {
      'name': 'Government General Hospital',
      'distance': '1.8 km',
      'contact': '9654321098',
      'rating': 3.9,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    // Auto-scroll images
    _startImageTimer();
  }

  void _startImageTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          currentImageIndex = (currentImageIndex + 1) % hospitalImages.length;
        });
        _startImageTimer();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showCallDialog(String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Call Hospital'),
          content: Text('Do you want to call $phoneNumber?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Copy phone number to clipboard
                Clipboard.setData(ClipboardData(text: phoneNumber));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Phone number $phoneNumber copied to clipboard!'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Copy Number'),
            ),
          ],
        );
      },
    );
  }

  // Updated method to open directions directly in maps
  Future<void> _openDirections() async {
    final double lat = double.tryParse(widget.hospitalData["lat"].toString()) ?? 0.0;
    final double lng = double.tryParse(widget.hospitalData["lng"].toString()) ?? 0.0;
    final String hospitalName = widget.hospitalData["name"] ?? "Hospital";
    
    // Try different map URLs in order of preference
    final List<String> mapUrls = [
      // Google Maps (most common)
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      // Alternative Google Maps URL
      'https://maps.google.com/?q=$lat,$lng',
      // Apple Maps (iOS)
      'https://maps.apple.com/?q=$lat,$lng',
      // Generic geo URL
      'geo:$lat,$lng?q=$lat,$lng($hospitalName)',
    ];

    bool launched = false;
    
    for (String url in mapUrls) {
      try {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication, // Opens in external app
          );
          launched = true;
          break;
        }
      } catch (e) {
        // Continue to next URL if this one fails
        continue;
      }
    }
    
    if (!launched) {
      // Fallback: Show dialog with copyable URL
      _showDirectionsDialog();
    }
  }

  void _showDirectionsDialog() {
    final double lat = double.tryParse(widget.hospitalData["lat"].toString()) ?? 0.0;
    final double lng = double.tryParse(widget.hospitalData["lng"].toString()) ?? 0.0;
    
    final String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Get Directions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Could not open maps app automatically. You can copy the URL below:'),
              const SizedBox(height: 8),
              SelectableText(
                googleUrl,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Clipboard.setData(ClipboardData(text: googleUrl));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Maps URL copied to clipboard!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Copy URL'),
            ),
          ],
        );
      },
    );
  }

  void _shareHospitalInfo() {
    final String hospitalInfo = '''${widget.hospitalData['name']}
Contact: ${widget.hospitalData['contact']}
Address: ${widget.hospitalData['address']}
Location: https://www.google.com/maps/search/?api=1&query=${widget.hospitalData['lat']},${widget.hospitalData['lng']}''';
    
    Clipboard.setData(ClipboardData(text: hospitalInfo));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hospital information copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildStarRating(double rating, {double size = 20}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.floor() 
            ? Icons.star 
            : index < rating 
              ? Icons.star_half 
              : Icons.star_border,
          color: Colors.amber,
          size: size,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double lat = double.tryParse(widget.hospitalData["lat"].toString()) ?? 0.0;
    final double lng = double.tryParse(widget.hospitalData["lng"].toString()) ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          widget.hospitalData["name"] ?? "Hospital Details",
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareHospitalInfo,
            tooltip: 'Copy hospital info',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(icon: Icon(Icons.info), text: 'Info'),
            Tab(icon: Icon(Icons.medical_services), text: 'Services'),
            Tab(icon: Icon(Icons.schedule), text: 'Hours'),
            Tab(icon: Icon(Icons.bloodtype), text: 'Blood'),
            Tab(icon: Icon(Icons.reviews), text: 'Reviews'),
            Tab(icon: Icon(Icons.nearby_error), text: 'Nearby'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Action Buttons
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.phone,
                  label: 'Call',
                  color: Colors.green,
                  onPressed: () => _showCallDialog(
                    widget.hospitalData['contact']?.toString() ?? '',
                  ),
                ),
                _buildActionButton(
                  icon: Icons.directions,
                  label: 'Directions',
                  color: Colors.blue,
                  onPressed: _openDirections, // Updated to use the new method
                ),
                _buildActionButton(
                  icon: Icons.favorite,
                  label: 'Favorite',
                  color: Colors.pink,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to favorites!')),
                    );
                  },
                ),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildInfoTab(lat, lng),
                _buildServicesTab(),
                _buildOperatingHoursTab(),
                _buildBloodAvailabilityTab(),
                _buildReviewsTab(),
                _buildNearbyHospitalsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildInfoTab(double lat, double lng) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo Gallery - Simple implementation without external packages
          const Text(
            "📸 Hospital Gallery",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: hospitalImages.length,
              onPageChanged: (index) {
                setState(() {
                  currentImageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_hospital,
                        size: 60,
                        color: Colors.red.shade300,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Hospital Image ${index + 1}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          // Image indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: hospitalImages.asMap().entries.map((entry) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentImageIndex == entry.key
                      ? Colors.red
                      : Colors.grey.shade400,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Map
          const Text(
            "🗺 Location",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(lat, lng),
                  minZoom: 16,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.dhanwantari.voluntarybloodbank/1.0',
                    maxNativeZoom: 19,
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(lat, lng),
                        width: 50,
                        height: 50,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showInfo = !showInfo;
                            });
                          },
                          child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Hospital Info Card
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.hospitalData['name'] ?? '',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.phone, color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      Text(widget.hospitalData['contact'] ?? 'Not available'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(widget.hospitalData['address'] ?? ''),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.gps_fixed, color: Colors.blue, size: 16),
                      const SizedBox(width: 8),
                      Text("Lat: ${widget.hospitalData['lat']}, Lng: ${widget.hospitalData['lng']}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.medical_services, color: Colors.red),
            title: Text(services[index]),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          ),
        );
      },
    );
  }

  Widget _buildOperatingHoursTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: operatingHours.length,
      itemBuilder: (context, index) {
        String department = operatingHours.keys.elementAt(index);
        String hours = operatingHours[department]!;
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.schedule, color: Colors.blue),
            title: Text(department),
            subtitle: Text(hours),
            trailing: hours == '24/7'
                ? const Icon(Icons.all_inclusive, color: Colors.green)
                : const Icon(Icons.access_time, color: Colors.orange),
          ),
        );
      },
    );
  }

  Widget _buildBloodAvailabilityTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Blood Type Availability",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: bloodTypes.length,
              itemBuilder: (context, index) {
                String bloodType = bloodTypes[index];
                bool isAvailable = bloodAvailability[bloodType] ?? false;
                return Container(
                  decoration: BoxDecoration(
                    color: isAvailable ? Colors.green.shade100 : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isAvailable ? Colors.green : Colors.red,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bloodtype,
                        color: isAvailable ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        bloodType,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isAvailable ? Colors.green.shade700 : Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isAvailable ? Icons.check_circle : Icons.cancel,
                        color: isAvailable ? Colors.green : Colors.red,
                        size: 16,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      children: [
        // Add Review Section
        Container(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rate this Hospital",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text("Your Rating: "),
                      ...List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              userRating = index + 1.0;
                            });
                          },
                          child: Icon(
                            index < userRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 30,
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: userRating > 0 ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Thank you for rating: ${userRating.toInt()} stars!'),
                        ),
                      );
                    } : null,
                    child: const Text("Submit Rating"),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Reviews List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              var review = reviews[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Text(review['name'][0]),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review['name'],
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    _buildStarRating(review['rating'].toDouble(), size: 16),
                                    const SizedBox(width: 8),
                                    Text(
                                      review['date'],
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(review['comment']),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyHospitalsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: nearbyHospitals.length,
      itemBuilder: (context, index) {
        var hospital = nearbyHospitals[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: const Icon(Icons.local_hospital, color: Colors.red),
            title: Text(hospital['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Distance: ${hospital['distance']}"),
                Row(
                  children: [
                    _buildStarRating(hospital['rating'].toDouble(), size: 14),
                    const SizedBox(width: 4),
                    Text(hospital['rating'].toString()),
                  ],
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.phone, color: Colors.green),
              onPressed: () => _showCallDialog(hospital['contact']),
            ),
          ),
        );
      },
    );
  }
}
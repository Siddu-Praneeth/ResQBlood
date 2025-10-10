import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:math';
class BloodDonationCampsPage extends StatefulWidget {
  const BloodDonationCampsPage({super.key});

  @override
  State<BloodDonationCampsPage> createState() => _BloodDonationCampsPageState();
}

class _BloodDonationCampsPageState extends State<BloodDonationCampsPage> {
  String? _selectedState;
  String? _selectedCity;
  final bool _dataLoaded = true;

  final Map<String, List<String>> _stateCities = {
    'Andhra Pradesh': ['Visakhapatnam', 'Vijayawada', 'Guntur', 'Nellore', 'Kurnool', 'Kakinada'],
    'Delhi': ['New Delhi', 'North Delhi', 'South Delhi', 'East Delhi', 'West Delhi'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik', 'Thane'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli', 'Mangalore', 'Belgaum'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai', 'Salem', 'Tiruchirappalli'],
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi', 'Agra', 'Prayagraj'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar'],
    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Bikaner'],
    'West Bengal': ['Kolkata', 'Howrah', 'Durgapur', 'Siliguri', 'Asansol'],
    'Kerala': ['Thiruvananthapuram', 'Kochi', 'Kozhikode', 'Thrissur', 'Malappuram'],
  };

  final List<BloodCamp> _bloodCamps = [
    BloodCamp(
      name: 'Red Cross Blood Drive Mumbai',
      image: 'assets/camp1.jpg',
      date: 'Dec 15, 2024',
      time: '9:00 AM - 5:00 PM',
      location: 'Community Center, Marine Lines, Mumbai',
      latitude: 19.0760,
      longitude: 72.8777,
    ),
    BloodCamp(
      name: 'Delhi Public Blood Donation Camp',
      image: 'assets/camp2.jpg',
      date: 'Dec 18, 2024',
      time: '10:00 AM - 6:00 PM',
      location: 'AIIMS Hospital, New Delhi',
      latitude: 28.5676,
      longitude: 77.2103,
    ),
    BloodCamp(
      name: 'Bangalore Emergency Blood Camp',
      image: 'assets/camp3.jpg',
      date: 'Dec 20, 2024',
      time: '8:00 AM - 4:00 PM',
      location: 'Victoria Hospital, Bangalore',
      latitude: 12.9716,
      longitude: 77.5946,
    ),
    BloodCamp(
      name: 'Chennai Mega Blood Donation Drive',
      image: 'assets/camp4.jpg',
      date: 'Dec 22, 2024',
      time: '9:30 AM - 5:30 PM',
      location: 'Government Hospital, Chennai',
      latitude: 13.0827,
      longitude: 80.2707,
    ),
    BloodCamp(
      name: 'Kolkata Blood Donation Camp',
      image: 'assets/camp5.jpg',
      date: 'Dec 25, 2024',
      time: '8:00 AM - 3:00 PM',
      location: 'Medical College, Kolkata',
      latitude: 22.5726,
      longitude: 88.3639,
    ),
    BloodCamp(
      name: 'Pune City Blood Drive',
      image: 'assets/camp6.jpg',
      date: 'Dec 28, 2024',
      time: '10:00 AM - 6:00 PM',
      location: 'Ruby Hall Clinic, Pune',
      latitude: 18.5204,
      longitude: 73.8567,
    ),
  ];

  final Map<String, LatLng> _cityCoordinates = {
    'Visakhapatnam': const LatLng(17.6868, 83.2185),
    'Vijayawada': const LatLng(16.5062, 80.6480),
    'Guntur': const LatLng(16.3142, 80.4350),
    'Nellore': const LatLng(14.4426, 79.9865),
    'Kurnool': const LatLng(15.8281, 78.0373),
    'Kakinada': const LatLng(16.9891, 82.2475),
    'New Delhi': const LatLng(28.6139, 77.2090),
    'North Delhi': const LatLng(28.7000, 77.2000),
    'South Delhi': const LatLng(28.5000, 77.2000),
    'East Delhi': const LatLng(28.6000, 77.3000),
    'West Delhi': const LatLng(28.6500, 77.1000),
    'Mumbai': const LatLng(19.0760, 72.8777),
    'Pune': const LatLng(18.5204, 73.8567),
    'Nagpur': const LatLng(21.1458, 79.0882),
    'Nashik': const LatLng(19.9975, 73.7898),
    'Thane': const LatLng(19.2183, 72.9781),
    'Bangalore': const LatLng(12.9716, 77.5946),
    'Mysore': const LatLng(12.2958, 76.6394),
    'Hubli': const LatLng(15.3473, 75.1304),
    'Mangalore': const LatLng(12.9141, 74.8560),
    'Belgaum': const LatLng(15.8496, 74.4970),
    'Chennai': const LatLng(13.0827, 80.2707),
    'Coimbatore': const LatLng(11.0168, 76.9558),
    'Madurai': const LatLng(9.9252, 78.1198),
    'Salem': const LatLng(11.6643, 78.1460),
    'Tiruchirappalli': const LatLng(10.7905, 78.7047),
    'Lucknow': const LatLng(26.8467, 80.9462),
    'Kanpur': const LatLng(26.4499, 80.3319),
    'Varanasi': const LatLng(25.3176, 82.9739),
    'Agra': const LatLng(27.1767, 78.0081),
    'Prayagraj': const LatLng(25.4358, 81.8463),
    'Ahmedabad': const LatLng(23.0225, 72.5714),
    'Surat': const LatLng(21.1702, 72.8311),
    'Vadodara': const LatLng(22.3072, 73.1812),
    'Rajkot': const LatLng(22.3039, 70.8022),
    'Bhavnagar': const LatLng(21.7645, 72.1519),
    'Jaipur': const LatLng(26.9124, 75.7873),
    'Jodhpur': const LatLng(26.2389, 73.0243),
    'Udaipur': const LatLng(24.5854, 73.7125),
    'Kota': const LatLng(25.2138, 75.8573),
    'Bikaner': const LatLng(28.0229, 73.3119),
    'Kolkata': const LatLng(22.5726, 88.3639),
    'Howrah': const LatLng(22.5958, 88.2636),
    'Durgapur': const LatLng(23.5203, 87.3156),
    'Siliguri': const LatLng(26.7271, 88.3953),
    'Asansol': const LatLng(23.6833, 86.9480),
    'Thiruvananthapuram': const LatLng(8.5241, 76.9366),
    'Kochi': const LatLng(9.9312, 76.2673),
    'Kozhikode': const LatLng(11.2588, 75.7804),
    'Thrissur': const LatLng(10.5276, 76.2144),
    'Malappuram': const LatLng(11.0533, 76.0711),
  };

  final String _imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQV6oPbDtV0lppr8hkkgDW85lZgN79iTmLrQQ&s';

  final List<IconData> _campIcons = [
    Icons.bloodtype,
    Icons.local_hospital,
    Icons.volunteer_activism,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Donation Camps'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  _buildImageContainer(),
                  _buildLocationDropdowns(),
                  if (_dataLoaded) _buildBloodCampsGrid(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      height: 240,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          _imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLocationDropdowns() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.red[700], size: 20),
              const SizedBox(width: 8),
              Text('Select Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  )),
            ],
          ),
          const SizedBox(height: 16),
          // State Dropdown
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButton<String>(
                value: _selectedState,
                hint: const Text('Select State'),
                isExpanded: true,
                underline: const SizedBox(),
                icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                items: _stateCities.keys.map((state) {
                  return DropdownMenuItem<String>(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedState = newValue;
                    _selectedCity = null;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          // City Dropdown
          if (_selectedState != null)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<String>(
                  value: _selectedCity,
                  hint: const Text('Select City'),
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                  items: _stateCities[_selectedState]!.map((city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCity = newValue;
                    });
                  },
                ),
              ),
            ),
          // Locate Button
          if (_selectedCity != null)
            ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loadCampsForCity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Locate',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
        ],
      ),
    );
  }

  void _loadCampsForCity() {
    if (_selectedCity == null || _selectedState == null) return;

    LatLng cityPos = _cityCoordinates[_selectedCity!] ?? const LatLng(20.5937, 78.9629);

    final random = Random(_selectedCity!.hashCode.abs());
    final int seed = random.nextInt(3);

    List<String> dateTemplates = ['Oct 15, 2025', 'Oct 22, 2025', 'Oct 29, 2025'];
    List<String> timeTemplates = ['9:00 AM - 5:00 PM', '10:00 AM - 6:00 PM', '8:00 AM - 4:00 PM'];
    List<String> locationTemplates = ['Community Center', 'City Hospital', 'Red Cross Society'];
    List<String> namePrefixes = ['Red Cross', 'Public', 'Emergency'];

    List<BloodCamp> camps = [];
    for (int i = 0; i < 3; i++) {
      int idx = (i + seed) % 3;
      String date = dateTemplates[idx];
      String time = timeTemplates[idx];
      String loc = '${locationTemplates[idx]}, $_selectedCity';
      String name = '${namePrefixes[idx]} Blood Donation Camp - $_selectedCity';
      double lat = cityPos.latitude + (random.nextDouble() - 0.5) * 0.01;
      double lon = cityPos.longitude + (random.nextDouble() - 0.5) * 0.01;

      camps.add(BloodCamp(
        name: name,
        image: 'assets/camp${(i % 6) + 1}.jpg',
        date: date,
        time: time,
        location: loc,
        latitude: lat,
        longitude: lon,
      ));
    }

    setState(() {
      _bloodCamps.clear();
      _bloodCamps.addAll(camps);
    });
  }

  Widget _buildBloodCampsGrid() {
    String title = _selectedCity != null ? 'Upcoming Blood Donation Camps' : 'Running Blood Donation Camps';
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.bloodtype, color: Colors.red[700], size: 24),
                const SizedBox(width: 8),
                Text(title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Responsive grid based on screen width
                final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                final childAspectRatio = constraints.maxWidth > 600 ? 0.8 : 0.75;
                
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: _bloodCamps.length,
                  itemBuilder: (context, index) {
                    return _buildCampCard(_bloodCamps[index], index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampCard(BloodCamp camp, int index) {
    IconData campIcon = _campIcons[index % _campIcons.length];
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showCampDetails(camp),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red[50]!, Colors.white],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.red[100],
                ),
                child: Center(
                  child: Icon(campIcon, size: 50, color: Colors.red[700]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        camp.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildInfoRow(Icons.calendar_today, camp.date),
                            _buildInfoRow(Icons.access_time, camp.time),
                            Flexible(
                              child: _buildInfoRow(Icons.location_pin, camp.location),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _showCampDetails(BloodCamp camp) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    camp.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailItem(Icons.calendar_today, 'Date', camp.date),
                  _buildDetailItem(Icons.access_time, 'Time', camp.time),
                  _buildDetailItem(Icons.location_pin, 'Location', camp.location),
                  const SizedBox(height: 16),
                  const Text(
                    'Donation Requirements:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Age: 18-65 years\n• Weight: >45 kg\n• Good health condition'),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registered for ${camp.name}'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Register'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.red[700], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(value),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);
}

class BloodCamp {
  final String name;
  final String image;
  final String date;
  final String time;
  final String location;
  final double latitude;
  final double longitude;

  BloodCamp({
    required this.name,
    required this.image,
    required this.date,
    required this.time,
    required this.location,
    required this.latitude,
    required this.longitude,
  });
}
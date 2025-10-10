import 'package:flutter/material.dart';
import 'hospital_names.dart';

class HospitalPlace extends StatefulWidget {
  const HospitalPlace({super.key});

  @override
  State<HospitalPlace> createState() => _HospitalPlaceState();
}

class _HospitalPlaceState extends State<HospitalPlace> {
  final List<String> _cities = [
    "rajamundry",
    "kakinada",
    "peddapuram",
    "rajanagaram",
    "pithapuram",
    "samarlakota"
  ];

  final Map<String, List<Map<String, String>>> hospitalData = {
    "rajamundry": [
      {
        "name": "Dhanwantari Voluntary Blood Bank",
        "contact": "98851 86533",
        "address": "Danavaipeta, Rajahmundry",
        "lat": "17.0078332",
        "lng": "81.7851124"
      },
      {
        "name": "Sree Nidhi Blood Centre",
        "contact": "9889900123",
        "address": "Ram Nagar, Rajahmundry",
        "lat": "17.4597845",
        "lng": "78.4977449"
      },
      {
        "name": "Satya Surya Voluntary Blood Bank",
        "contact": "8500960088",
        "address": "TTD Road, Gandhipuram, Rajahmundry",
        "lat": "17.0096806",
        "lng": "81.7791291"
      },
    ],
    "kakinada": [
      {
        "name": "Govt. General Hospital Blood Bank",
        "contact": "9390207027",
        "address": "Government Hospital, Kakinada",
        "lat": "16.9594374",
        "lng": "82.2202408"
      },
      {
        "name": "Red Cross Society Blood Bank",
        "contact": "0884-2364567",
        "address": "Red Cross Street, Gandhi Nagar, Kakinada",
        "lat": "16.970059",
        "lng": "82.2250813"
      },
        {
        "name": "Srirama Health Centre Blood Unit",
        "contact": "9955667788",
        "address": "Gandhipuram, Rajahmundry",
        "lat" : "17.008222",
        "lng" : "81.7220856"
      },
    ],
    "peddapuram": [
      {
        "name": "Ananda Voluntary Blood Bank",
        "contact": "9880765432",
        "address": "RTC Road, Peddapuram",
        "lat": "17.0657",
        "lng": "82.1054"
      },
       {
        "name": "Local Government Hospital Blood Bank",
        "contact": "Available at Hospital",
        "address": "Peddapuram",
        "lat" : "17.0818688",
        "lng" : "82.1085978"
      },
      {
        "name": "Rotary Blood Center",
        "address": "Lecturers Colony, Peddapuram",
        "lat" : "17.0757034",
        "lng" : "82.1360093"
      },
    ],
   
    "rajanagaram": [
      {
        "name": "GSL Medical College Blood Bank",
        "contact": "0883 2484999",
        "address": "Lakshmipuram, Rajanagaram",
        "lat" : "17.06773",
        "lng" : "81.8842462"
      },
      
    ],
    "pithapuram": [
      {
        "name": "Area Hospital Blood Bank",
        "contact": "Available at Hospital",
        "address": "Pithapuram",
        "lat" : "17.06774",
        "lng" : "81.7851123"
      },
      {
        "name": "Sri Sai Health Blood Bank",
        "contact": "9950678901",
        "address": "Dwarakamayee conplex,pithapuram road Divili",
        "lat" : "17.1457993",
        "lng" : "82.1598452"
      },
      {
        "name" : "Siddartha Voluntary Blood Bank",
        "contact" : "0884 234 6666",
        "address" : "Ground 1st Floor, Datla House, Datlavari Street, Gandhi Nagar",
        "lat" : "16.9688246",
        "lng" : "82.2228933"
      },
      {
        "name": "Sri Venkateswara Blood Centre",
        "contact": "9700456123",
        "address": "Main Street, Pithapuram",
        "lat" : "16.9688247",
        "lng" : "82.2228932"
      },
    ],
    "samarlakota": [
      {
        "name": "Annapoorna Blood Bank",
        "contact": "9880012345",
        "address": "Station Road, Samarlakota",
         "lat" : "17.0515079",
        "lng" : "82.1671981"
      },
      {
        "name": "Samarlakota Area Hospital Blood Storage",
        "contact": "Available at Hospital",
        "address": "Samarlakota",
         "lat" : "17.0515079",
        "lng" : "82.1671980"
      },

      {
        "name": "Srishti Voluntary Blood Bank",
        "contact": "9876541230",
        "address": "Main Market, Samarlakota",
         "lat" : "17.0515078",
        "lng" : "82.1671981"
      },
    ],
    // Add other cities similarly
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 196, 13, 1),// Firebrick

        centerTitle: true,
        title: const Text('Cities'),
      ),
      body: ListView.builder(
        itemCount: _cities.length,
        itemBuilder: (context, index) {
          final city = _cities[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            elevation: 6,
            child: ListTile(
              title: Text(city.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalNames(cityName: city, hospitals: hospitalData[city]!),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
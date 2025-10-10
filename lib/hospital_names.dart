import 'package:blood_donation_app/hospitl_details.dart';
import 'package:flutter/material.dart';

class HospitalNames extends StatelessWidget {
  final String cityName;
  final List<Map<String, dynamic>> hospitals; // Changed to dynamic to support enhanced data

  const HospitalNames({super.key, required this.cityName, required this.hospitals});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cityName.toUpperCase()),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospital = hospitals[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            child: ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.red),
              title: Text(
                hospital['name'] ?? '', 
                style: const TextStyle(fontWeight: FontWeight.bold)
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 14, color: Colors.green),
                      const SizedBox(width: 4),
                      Text("Contact: ${hospital['contact'] ?? 'Not available'}"),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.blue),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Address: ${hospital['address'] ?? ''}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  // Show rating if available
                  if (hospital['rating'] != null) ...[
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text("Rating: ${hospital['rating']} ⭐"),
                      ],
                    ),
                  ],
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalDetails(hospitalData: hospital)
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
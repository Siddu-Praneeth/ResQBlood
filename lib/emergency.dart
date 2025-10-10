// ignore_for_file: unused_local_variable, unused_field, library_private_types_in_public_api

import 'package:flutter/material.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedBloodGroup;
  String? _urgency = "Immediate";
  int _units = 1;
  bool _sosRaised = false;
  String _status = "Raised";
  DateTime? _sosRaisedTime;

  final List<String> bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-"
  ];

  final List<String> urgencyOptions = ["Immediate", "Within 24 hrs"];

  void _raiseSOS() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _sosRaised = true;
        _status = "Notified";
        _sosRaisedTime = DateTime.now();
      });

      // Return updated data to HomeScreen
      Navigator.pop(context, {
        "sosRaised": _sosRaised,
        "status": _status,
        "time": _sosRaisedTime,
      });
    }
  }

  void _cancelRequest() {
    setState(() {
      _sosRaised = false;
      _status = "Cancelled";
      _sosRaisedTime = null;
    });

    // Return updated data to HomeScreen
    Navigator.pop(context, {
      "sosRaised": _sosRaised,
      "status": _status,
      "time": _sosRaisedTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime = _sosRaisedTime != null
        ? "${_sosRaisedTime!.hour.toString().padLeft(2, '0')}:${_sosRaisedTime!.minute.toString().padLeft(2, '0')}:${_sosRaisedTime!.second.toString().padLeft(2, '0')}"
        : "-";

    return Scaffold(
      appBar: AppBar(
        title: const Text("🚨 Emergency SOS"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Emergency Banner Image
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.shade200,
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqMSPGA3JL_ZGhA42EoeHca5555sflMtqkaQ&s",
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Icon(Icons.error));
                  },
                ),
              ),
            ),

            // ✅ Optional: Inline "SOS Active" Message
            if (_sosRaised)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade400),
                ),
                child: const Text(
                  "🚨 SOS Active — Donors Notified!",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Blood Group",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                        ),
                        value: _selectedBloodGroup,
                        items: bloodGroups
                            .map((bg) =>
                                DropdownMenuItem(value: bg, child: Text(bg)))
                            .toList(),
                        onChanged: (val) {
                          setState(() => _selectedBloodGroup = val);
                        },
                        validator: (val) =>
                            val == null ? "Select a blood group" : null,
                      ),
                      const SizedBox(height: 16),
                      const Text("Units Required",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      TextFormField(
                        initialValue: "1",
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter units",
                        ),
                        onSaved: (val) => _units = int.tryParse(val!) ?? 1,
                        validator: (val) =>
                            val == null || val.isEmpty ? "Enter units" : null,
                      ),
                      const SizedBox(height: 16),
                      const Text("Urgency",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                        ),
                        value: _urgency,
                        items: urgencyOptions
                            .map((u) =>
                                DropdownMenuItem(value: u, child: Text(u)))
                            .toList(),
                        onChanged: (val) {
                          setState(() => _urgency = val);
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _raiseSOS,
                        icon: const Icon(Icons.sos, color: Colors.white),
                        label: const Text("Raise SOS",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (_sosRaised)
                        ElevatedButton.icon(
                          onPressed: _cancelRequest,
                          icon: const Icon(Icons.cancel, color: Colors.white),
                          label: const Text("Cancel Request",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade600,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                    ],
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

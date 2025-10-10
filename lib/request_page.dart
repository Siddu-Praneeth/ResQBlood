// request_page.dart

import 'package:flutter/material.dart';

// The main class used in the MaterialApp routes in main.dart

class BloodRequestScreen extends StatelessWidget {
  const BloodRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Blood', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Cartoon Illustration Placeholder
            SizedBox(
              height: 150,
              child: Image.network(
                'https://www.shutterstock.com/image-vector/donate-blood-save-lives-give-260nw-2672009383.jpg', 
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Request Blood to Save a Life',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill in details about your requirement, and we’ll connect you with donors in no time.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.bloodtype, color: Colors.white),
              label: const Text(
                'Start New Request',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Navigate to the form screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BloodRequestForm()),
                );
              },
            ),
            const SizedBox(height: 30),
            const Text(
              'How It Works:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const ListTile(
              leading: CircleAvatar(child: Text('1')),
              title: Text('Provide patient and hospital details.'),
            ),
            const ListTile(
              leading: CircleAvatar(child: Text('2')),
              title: Text('Submit the request.'),
            ),
            const ListTile(
              leading: CircleAvatar(child: Text('3')),
              title: Text('Donors are notified instantly.'),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------
// 2. The Form Screen (Renamed from BloodRequestPage to BloodRequestForm)
// ---------------------------------------------------------------------

class BloodRequestForm extends StatefulWidget {
  const BloodRequestForm({super.key});

  @override
  _BloodRequestFormState createState() => _BloodRequestFormState();
}

class _BloodRequestFormState extends State<BloodRequestForm> {
  final _formKey = GlobalKey<FormState>();

  // Field variables
  String? selectedAge;
  String? bloodType;
  DateTime? needBloodByDate;
  String hospitalAddress = ""; // State to hold selected address

  // Text Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController patientPhoneController = TextEditingController();
  final TextEditingController attendeeNameController = TextEditingController();
  final TextEditingController attendeePhoneController = TextEditingController();
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController donatedUnitsController = TextEditingController();

  List<String> ages = List.generate(100, (index) => (index + 1).toString());
  List<String> bloodGroups = [
    'A+ve', 'A-ve', 'B+ve', 'B-ve',
    'AB+ve', 'AB-ve', 'O+ve', 'O-ve',
  ];

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() {
        needBloodByDate = picked;
      });
    }
  }
  
  @override
  void dispose() {
    nameController.dispose();
    unitsController.dispose();
    purposeController.dispose();
    patientPhoneController.dispose();
    attendeeNameController.dispose();
    attendeePhoneController.dispose();
    hospitalNameController.dispose();
    donatedUnitsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            text: 'Request ',
            style: TextStyle(color: Colors.white),
            children: [
              TextSpan(
                text: 'for Blood',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.red[700],
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Please fill out the form below to request blood.\nYour information will help us connect you with the right donors quickly and efficiently.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Patient Name
            const Text('Patient Name *'),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter Patient Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter patient name' : null,
            ),
            const SizedBox(height: 16),

            // Age
            const Text('Age *'),
            DropdownButtonFormField<String>(
              value: selectedAge,
              hint: const Text('Select Age'),
              items: ages.map((age) {
                return DropdownMenuItem(
                  value: age,
                  child: Text(age),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedAge = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select age' : null,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),

            // Blood Type
            const Text('Blood Type *'),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: bloodGroups.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: bloodType == type,
                  onSelected: (_) {
                    setState(() {
                      bloodType = type;
                    });
                  },
                  selectedColor: Colors.red[100],
                  labelStyle: TextStyle(
                    color: bloodType == type ? Colors.red[900] : Colors.black87,
                  ),
                );
              }).toList(),
            ),
            if (bloodType == null)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Please select blood type',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),

            // Units
            const Text('Units Required From Donors *'),
            TextFormField(
              controller: unitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Units',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Please enter number of units' : null,
            ),
            const SizedBox(height: 16),

            // Purpose
            const Text('Purpose'),
            TextFormField(
              controller: purposeController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter Purpose',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Need Blood By (Date)
            const Text('Need Blood By *'),
            GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Select Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(
                    text: needBloodByDate != null
                        ? "${needBloodByDate!.day}/${needBloodByDate!.month}/${needBloodByDate!.year}"
                        : '',
                  ),
                  validator: (_) =>
                      needBloodByDate == null ? 'Please select a date' : null,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Patient Phone
            const Text('Patient Phone Number *'),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      Text('🇮🇳 +91'),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: patientPhoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      hintText: 'Enter Phone Number',
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.length != 10
                        ? 'Enter valid 10-digit number'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Attendee Name
            const Text('Patient Attendee Name *'),
            TextFormField(
              controller: attendeeNameController,
              decoration: const InputDecoration(
                hintText: 'Enter Attendee Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter attendee name' : null,
            ),
            const SizedBox(height: 16),

            // Attendee Phone
            const Text('Attendee Phone Number *'),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    children: [
                      Text('🇮🇳 +91'),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: attendeePhoneController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      hintText: 'Enter Phone Number',
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.length != 10
                        ? 'Enter valid 10-digit number'
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Hospital Name
            const Text('Hospital Name *'),
            TextFormField(
              controller: hospitalNameController,
              decoration: const InputDecoration(
                hintText: 'Enter Hospital Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Enter hospital name' : null,
            ),
            const SizedBox(height: 16),

            // Hospital Address
            const Text('Hospital Address *'),
            GestureDetector(
              onTap: () {
                // Dummy location picker implementation
                setState(() {
                  hospitalAddress = "Selected Address from Map (e.g., Apollo)";
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: hospitalAddress.isEmpty ? Colors.red : Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: hospitalAddress.isEmpty ? Colors.red : Colors.green),
                    const SizedBox(width: 6),
                    Text(
                      hospitalAddress.isEmpty ? 'Select Address' : hospitalAddress,
                      style: TextStyle(color: hospitalAddress.isEmpty ? Colors.red : Colors.green, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            if (hospitalAddress.isEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Please select hospital address',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),

            // Donated Units
            const Text('Units donated by family/friends'),
            TextFormField(
              controller: donatedUnitsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter Units Donated (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Submit Button
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      bloodType != null &&
                      needBloodByDate != null &&
                      hospitalAddress.isNotEmpty) {
                    // All validations passed, submit logic here
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        title: const Text(
                          'Request Submitted',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                            'Your blood request has been successfully submitted.\nWe will contact you shortly.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close dialog
                              Navigator.of(context).pop(); // Go back to the promotional screen
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all required fields and select a blood type/address.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Submit Request',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
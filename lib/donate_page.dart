import 'package:blood_donation_app/home_page.dart';
import 'package:flutter/material.dart';



class BloodDonationScreen extends StatefulWidget {
  const BloodDonationScreen({super.key});

  @override
  _BloodDonationScreenState createState() => _BloodDonationScreenState();
}

class _BloodDonationScreenState extends State<BloodDonationScreen> {
  String selectedType = 'A+';

  final Map<String, List<String>> canTakeFrom = {
    'A+': ['O+', 'O-', 'A+', 'A-'],
    'O+': ['O+', 'O-'],
    'B+': ['O+', 'O-', 'B+', 'B-'],
    'AB+': ['All'],
    'A-': ['O-', 'A-'],
    'O-': ['O-'],
    'B-': ['O-', 'B-'],
    'AB-': ['O-', 'A-', 'B-', 'AB-'],
  };

  final Map<String, List<String>> canGiveTo = {
    'A+': ['A+', 'AB+'],
    'O+': ['O+', 'A+', 'B+', 'AB+'],
    'B+': ['B+', 'AB+'],
    'AB+': ['AB+'],
    'A-': ['A+', 'A-', 'AB+', 'AB-'],
    'O-': ['All'],
    'B-': ['B+', 'B-', 'AB+', 'AB-'],
    'AB-': ['AB+', 'AB-'],
  };

  final List<String> bloodTypes = [
    'A+', 'O+', 'B+', 'AB+',
    'A-', 'O-', 'B-', 'AB-',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donate Blood'),centerTitle: true,
      automaticallyImplyLeading: true,
      backgroundColor: Colors.red[700],
       leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Blood type selection
            Center(
              child: const Text(
                'Select your Blood Type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: bloodTypes.map((type) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedType == type ? Colors.red : Colors.grey[300],
                      foregroundColor: selectedType == type ? Colors.white : Colors.black,
                    ),
                    onPressed: () => setState(() => selectedType = type),
                    child: Text(type),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Blood group compatibility info
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'You can take from',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: canTakeFrom[selectedType]!
                              .map((type) => Chip(label: Text(type)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'You can give to',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: canGiveTo[selectedType]!
                              .map((type) => Chip(label: Text(type)))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HealthScreeningScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.bloodtype, color: Colors.white),
                  label: const Text("Check Eligiblity", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DonorRegistrationScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  label: const Text("Register Now", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  
                ),
                
              ],
              
            ),
            SizedBox(height: 30),
            Text(
              'Immediate Precautions :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('1')),
              title: Text('Rest for at least 10–15 minutes after donation'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('2')),
              title: Text('Drink plenty of fluids (water, juice) to replenish lost volume'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('3')),
              title: Text('Avoid heavy lifting or strenuous exercise for the rest of the day'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('4')),
              title: Text('Keep the bandage on the needle site for at least a few hours to prevent bleeding'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('5')),
              title: Text('Do not smoke or consume alcohol immediately after donation'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('6')),
              title: Text('Eat a light meal soon after donating (avoid fatty foods)'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('7')),
              title: Text('Increase iron intake over the next few days (spinach, lentils, red meat, etc.) to prevent anemia'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('8')),
              title: Text('Continue drinking extra fluids for 24 hours to maintain hydration'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('9')),
              title: Text('Avoid standing for long periods immediately after donation to prevent dizziness'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('10')),
              title: Text('Avoid hot baths or saunas on the day of donation'),
            ),
            ListTile(
              leading: CircleAvatar(child: Text('11')),
              title: Text('Wait before donating again – usually 3 months for whole blood, 48 hours for plasma, and 2 weeks for platelets'),
            ),
            /*ListTile(
              leading: CircleAvatar(child: Text('9')),
              title: Text('Avoid standing for long periods immediately after donation to prevent dizziness'),
            ),*/


          
            
          ],
        ),
      ),
    );
  }
}

// =============== Health Screening Screen ===============
class HealthScreeningScreen extends StatefulWidget {
  const HealthScreeningScreen({super.key});

  @override
  _HealthScreeningScreenState createState() => _HealthScreeningScreenState();
}

class _HealthScreeningScreenState extends State<HealthScreeningScreen> {
  bool recentIllness = false;
  bool onMedication = false;
  bool recentTravel = false;
  double hemoglobin = 0.0;
  int systolicBP = 0;
  int diastolicBP = 0;

  String eligibilityMessage = '';

  void checkEligibility() {
    if (recentIllness || onMedication || recentTravel) {
      eligibilityMessage = 'You are currently not eligible to donate.';
    } else if (hemoglobin < 12.5 || systolicBP < 90 || systolicBP > 160 || diastolicBP < 60 || diastolicBP > 100) {
      eligibilityMessage = 'Health parameters are outside safe range.';
    } else {
      eligibilityMessage = 'You are eligible to donate blood!';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Screening')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pre-screening Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SwitchListTile(
              title: const Text('Have you had any recent illness?'),
              value: recentIllness,
              onChanged: (val) => setState(() => recentIllness = val),
            ),
            SwitchListTile(
              title: const Text('Are you currently on medication?'),
              value: onMedication,
              onChanged: (val) => setState(() => onMedication = val),
            ),
            SwitchListTile(
              title: const Text('Have you traveled internationally in the last 30 days?'),
              value: recentTravel,
              onChanged: (val) => setState(() => recentTravel = val),
            ),
            const SizedBox(height: 20),
            const Text('Vital Signs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              decoration: const InputDecoration(labelText: 'Hemoglobin (g/dL)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => hemoglobin = double.tryParse(val) ?? 0.0,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: 'Systolic BP (mmHg)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => systolicBP = int.tryParse(val) ?? 0,
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: 'Diastolic BP (mmHg)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              onChanged: (val) => diastolicBP = int.tryParse(val) ?? 0,
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: checkEligibility,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Check Eligibility'),
              ),
            ),
            const SizedBox(height: 20),
            if (eligibilityMessage.isNotEmpty)
              Center(
                child: Text(
                  eligibilityMessage,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: eligibilityMessage.contains('eligible') ? Colors.green : Colors.red,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// =============== Donor Registration Screen ===============
class DonorRegistrationScreen extends StatefulWidget {
  const DonorRegistrationScreen({super.key});

  @override
  _DonorRegistrationScreenState createState() => _DonorRegistrationScreenState();
}

class _DonorRegistrationScreenState extends State<DonorRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController chronicConditionController = TextEditingController();
  final TextEditingController surgeryController = TextEditingController();

  String? selectedAge;
  String? selectedGender;
  String? selectedBloodGroup;
  DateTime? lastDonationDate;
  bool willingToDonate = false;

  final List<String> bloodTypes = ['A+', 'O+', 'B+', 'AB+', 'A-', 'O-', 'B-', 'AB-'];
  final List<String> ages = List.generate(83, (index) => (index + 18).toString());
  final List<String> genders = ['Male', 'Female', 'Other'];

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => lastDonationDate = picked);
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Submission"),
        content: const Text("Are you sure all details are correct and want to submit?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context); // Close dialog
              _submitRegistration(); // Submit form
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  void _submitRegistration() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Registration submitted successfully!"),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    // Reset the form
    nameController.clear();
    contactController.clear();
    locationController.clear();
    emailController.clear();
    chronicConditionController.clear();
    surgeryController.clear();

    setState(() {
      selectedAge = null;
      selectedGender = null;
      selectedBloodGroup = null;
      lastDonationDate = null;
      willingToDonate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donor Registration")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Donor Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              // Name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Name is required" : null,
              ),
              const SizedBox(height: 12),

              // Age
              DropdownButtonFormField<String>(
                value: selectedAge,
                decoration: const InputDecoration(labelText: "Age", border: OutlineInputBorder()),
                items: ages.map((age) => DropdownMenuItem(value: age, child: Text(age))).toList(),
                onChanged: (val) => setState(() => selectedAge = val),
                validator: (value) => value == null ? "Age is required" : null,
              ),
              const SizedBox(height: 12),

              // Gender
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: const InputDecoration(labelText: "Gender", border: OutlineInputBorder()),
                items: genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (val) => setState(() => selectedGender = val),
                validator: (value) => value == null ? "Gender is required" : null,
              ),
              const SizedBox(height: 12),

              // Blood Group
              DropdownButtonFormField<String>(
                value: selectedBloodGroup,
                decoration: const InputDecoration(labelText: "Blood Group", border: OutlineInputBorder()),
                items: bloodTypes.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                onChanged: (val) => setState(() => selectedBloodGroup = val),
                validator: (value) => value == null ? "Blood Group is required" : null,
              ),
              const SizedBox(height: 12),

              // Contact
              TextFormField(
                controller: contactController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "Contact Number", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Contact number is required" : null,
              ),
              const SizedBox(height: 12),

              // Email
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Email is required";
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  return emailRegex.hasMatch(value) ? null : "Enter a valid email";
                },
              ),
              const SizedBox(height: 12),

              // Location
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: "Location", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Location is required" : null,
              ),
              const SizedBox(height: 12),

              // Last Donation Date
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Last Donation Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: lastDonationDate != null
                          ? "${lastDonationDate!.day}/${lastDonationDate!.month}/${lastDonationDate!.year}"
                          : '',
                    ),
                    validator: (_) => lastDonationDate == null ? 'Please select date' : null,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Willing to donate
              SwitchListTile(
                title: const Text("Willing to donate now?"),
                value: willingToDonate,
                onChanged: (val) => setState(() => willingToDonate = val),
              ),

              // Chronic conditions
              TextFormField(
                controller: chronicConditionController,
                decoration: const InputDecoration(labelText: "Chronic Conditions", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Please mention chronic conditions" : null,
              ),
              const SizedBox(height: 12),

              // Surgeries
              TextFormField(
                controller: surgeryController,
                decoration: const InputDecoration(labelText: "Past Surgeries", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Please mention past surgeries" : null,
              ),
              const SizedBox(height: 24),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showConfirmationDialog();
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Submit Registration", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

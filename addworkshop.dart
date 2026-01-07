import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'mywork2026.atwebpages.com';

class AddWorkshop extends StatefulWidget {
  const AddWorkshop({super.key});

  @override
  _AddWorkshopState createState() => _AddWorkshopState();
}

class _AddWorkshopState extends State<AddWorkshop> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _workerIdController = TextEditingController();
  final TextEditingController _workerNameController = TextEditingController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String _selectedType = 'Type A';
  String _responseMessage = '';

  Future<void> _saveWorkshop() async {
    final String address = _addressController.text;
    final String workerId = _workerIdController.text;
    final String workerName = _workerNameController.text;
    final String clientName = _clientNameController.text;
    final String date = _dateController.text;
    final String type = _selectedType;

    if (address.isEmpty || workerId.isEmpty || workerName.isEmpty ||clientName.isEmpty || date.isEmpty) {
      setState(() {
        _responseMessage = 'Please fill in all fields.';
      });
      return;
    }

    try {
      final url = Uri.http(_baseURL, '/addworkshop.php');
      final response = await http.post(url, body: {
        'address1': address,
        'worker_id': workerId,
        'worker_name': workerName,
        'client_name': clientName,
        'date1': date,
        'type1': type,
      }).timeout(const Duration(seconds: 5));

      setState(() {
        if (response.statusCode == 200) {
          final String responseBody = response.body.trim();
          if (responseBody == 'success') {
            _responseMessage = 'Workshop added successfully!';
            _addressController.clear();
            _workerIdController.clear();
            _workerNameController.clear();
            _clientNameController.clear();
            _dateController.clear();
            _selectedType = 'Type A';
          } else {
            _responseMessage = responseBody;
          }
        } else {
          _responseMessage =
          'Failed to add workshop: ${response.statusCode}, ${response.body}';
        }
      });
    } catch (e) {
      setState(() {
        _responseMessage = 'Error connecting to server: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Workshop'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              Image.network(
                'https://thumbs.dreamstime.com/b/house-repair-logo-25953124.jpg?w=768',
                height: 150,
              ),
              const SizedBox(height: 20),



              const Text(
                "Add a New Workshop",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),



              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),



              TextField(
                controller: _workerIdController,
                decoration: const InputDecoration(
                  labelText: 'Worker ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),





              TextField(
                controller: _workerNameController,
                decoration: const InputDecoration(
                  labelText: 'Worker Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),


              TextField(
                controller: _clientNameController,
                decoration: const InputDecoration(
                  labelText: 'Client Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),


              TextField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),


              const Text(
                'Workshop Type',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Type A',
                    groupValue: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  const Text('Floor Treatment'),
                  Radio(
                    value: 'Type B',
                    groupValue: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  const Text('Full House Cleaning '),
                  Radio(
                    value: 'Type C',
                    groupValue: _selectedType,
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                  const Text('Pest Control'),
                ],
              ),
              const SizedBox(height: 32),


              ElevatedButton(
                onPressed: _saveWorkshop,
                style: _buttonStyle(),
                child: const Text('Save Workshop'),
              ),
              const SizedBox(height: 16),

              if (_responseMessage.isNotEmpty)
                Text(
                  _responseMessage,
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }




  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      elevation: 5,
      textStyle: const TextStyle(fontSize: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
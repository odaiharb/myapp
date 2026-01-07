import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'mywork2026.atwebpages.com';

class AddWorker extends StatefulWidget {
  const AddWorker({super.key});

  @override
  _AddWorkerState createState() => _AddWorkerState();
}

class _AddWorkerState extends State<AddWorker> {
  final TextEditingController _workerIdController = TextEditingController();
  final TextEditingController _workerNameController = TextEditingController();
  final TextEditingController _usdPerDayController = TextEditingController();

  bool _isLoading = false;
  String _responseMessage = '';

  Future<void> _saveWorker() async {
    final String workerId = _workerIdController.text;
    final String workerName = _workerNameController.text;
    final String usdPerDay = _usdPerDayController.text;

    if (workerId.isEmpty || workerName.isEmpty || usdPerDay.isEmpty) {
      setState(() {
        _responseMessage = 'Please fill in all fields';
      });
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });

      final url = Uri.http(_baseURL, '/addworker222.php');
      final response = await http.post(url, body: {
        'worker_id': workerId,
        'worker_name': workerName,
        'usd_per_day': usdPerDay,
      }).timeout(const Duration(seconds: 5));

      setState(() {
        _isLoading = false;
        if (response.statusCode == 200) {
          final String responseBody = response.body.trim();
          if (responseBody == 'success') {
            _responseMessage = 'Worker added successfully';
            _workerIdController.clear();
            _workerNameController.clear();
            _usdPerDayController.clear();
          } else {
            _responseMessage = responseBody;
          }
        } else {
          _responseMessage = 'Failed to add worker: ${response.statusCode}';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _responseMessage = 'Error connecting to server: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Worker'),
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
                'https://thumbs.dreamstime.com/b/power-washing-pressure-water-blaster-worker-25683369.jpg?w=768',
                height: 150,
              ),
              const SizedBox(height: 20),

              const Text(
                "Add a New Worker",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              TextField(
                controller: _workerIdController,
                decoration: const InputDecoration(
                  labelText: 'Worker ID',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),








              //done till now
              TextField(
                controller: _workerNameController,
                decoration: const InputDecoration(
                  labelText: 'Worker Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),




              TextField(
                controller: _usdPerDayController,
                decoration: const InputDecoration(
                  labelText: 'USD per Day',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: _saveWorker,
                style: _buttonStyle(),
                child: const Text('Save Worker'),
              ),
              const SizedBox(height: 16),

              // Response Message
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
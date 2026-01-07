import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'mywork2026.atwebpages.com';

class WorkerSalary {
  final String workerName;
  final double usdPerDay;
  final int workshopsCount;
  final double totalSalary;

  WorkerSalary(this.workerName, this.usdPerDay, this.workshopsCount, this.totalSalary);

  @override
  String toString() {
    return 'Worker Name: $workerName\n'
        'USD per Day: $usdPerDay\n'
        'Workshops Count: $workshopsCount\n'
        'Total Salary: $totalSalary USD';
  }
}

void main() => runApp(const WorkerSalaryApp());

class WorkerSalaryApp extends StatelessWidget {
  const WorkerSalaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WorkerSalaryPage(),
    );
  }
}

class WorkerSalaryPage extends StatefulWidget {
  const WorkerSalaryPage({super.key});

  @override
  _WorkerSalaryPageState createState() => _WorkerSalaryPageState();
}

class _WorkerSalaryPageState extends State<WorkerSalaryPage> {
  final TextEditingController _workerIdController = TextEditingController();
  List<WorkerSalary> _salaries = [];
  String? _errorMessage;

  Future<void> _getWorkerSalary() async {
    final String workerId = _workerIdController.text;

    if (workerId.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a worker ID.";
      });
      return;
    }

    final Uri url = Uri.http(_baseURL, 'get_salary.php', {'worker_id': workerId});

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = convert.jsonDecode(response.body);

        if (data['status'] == 'success') {
          final salary = WorkerSalary(
            data['data']['worker_name'].toString(),
            double.parse(data['data']['usd_per_day'].toString()),
            int.parse(data['data']['workshops_count'].toString()),
            double.parse(data['data']['total_salary'].toString()),
          );

          setState(() {
            _salaries = [salary];
            _errorMessage = null;
          });
        } else {
          setState(() {
            _errorMessage = data['message'];
          });
        }
      } else {
        setState(() {
          _errorMessage = "Failed to connect to the server. Status: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "An error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Worker Salary"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Image.network(
              'https://thumbs.dreamstime.com/b/earn-money-vector-logo-icon-design-salary-symbol-design-hand-illustrations-earn-money-vector-logo-icon-design-salary-symbol-152893719.jpg?w=992', // Example logo image
              height: 150,
            ),
            const SizedBox(height: 20),

            const Text(
              "Get Worker Salary",
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
                labelText: "Enter Worker ID",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),




            ElevatedButton(
              onPressed: _getWorkerSalary,
              style: _buttonStyle(),
              child: const Text("Get Salary"),
            ),
            const SizedBox(height: 16),


            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 16),


            if (_salaries.isNotEmpty)
              Expanded(child: ShowWorkerSalaries(salaries: _salaries)),
          ],
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

class ShowWorkerSalaries extends StatelessWidget {
  final List<WorkerSalary> salaries;

  const ShowWorkerSalaries({super.key, required this.salaries});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ListView.builder(
      itemCount: salaries.length,
      itemBuilder: (context, index) => Column(
        children: [
          const SizedBox(height: 10),
          Container(
            color: index % 2 == 0 ? Colors.amber : Colors.cyan,
            padding: const EdgeInsets.all(5),
            width: width * 0.9,
            child: Row(
              children: [
                SizedBox(width: width * 0.15),
                Flexible(
                  child: Text(
                    salaries[index].toString(),
                    style: TextStyle(fontSize: width * 0.045),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
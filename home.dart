import 'package:flutter/material.dart';
import 'addworker.dart';
import 'addworkshop.dart';
import 'workersalary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kourany Enterprise"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  'https://www.kourany.com/img/footer-man.png',
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.person, size: 100, color: Colors.grey);
                  },
                ),
              ),
              const SizedBox(height: 20),


              const Text(
                "HELLO WELCOME TO KOURANY ENTERPRISE",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddWorker(),
                    ),
                  );
                },
                style: _buttonStyle(),
                child: const Text("Add Worker"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddWorkshop(),
                    ),
                  );
                },
                style: _buttonStyle(),
                child: const Text("Add Workshop"),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WorkerSalaryPage(),
                    ),
                  );
                },
                style: _buttonStyle(),
                child: const Text("Worker Salary"),
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

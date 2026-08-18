import 'package:flutter/material.dart';

import 'data/students_data.dart';
import 'models/student.dart';

void main() {
  runApp(MyApp(records: studentsSortedByName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.records = students});

  final List<Student> records;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1F2430),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF9940),
          onPrimary: Color(0xFF1F2430),
          surface: Color(0xFF1F2430),
          onSurface: Color(0xFFCBCCC6),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D3640),
          foregroundColor: Color(0xFFCBCCC6),
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFCBCCC6)),
          bodyMedium: TextStyle(color: Color(0xFFCBCCC6)),
        ),
      ),
      home: MyHomePage(records: records),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, this.records = students});

  final List<Student> records;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Students'),
      ),
      body: records.isEmpty
          ? const EmptyStudentsView()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: records.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: StudentCard(student: records[index]),
              ),
            ),
    );
  }
}

class EmptyStudentsView extends StatelessWidget {
  const EmptyStudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 96,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'No students available',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'New student records will appear here.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  const StudentCard({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                student.image,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              student.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${student.course} - ${student.yearLevel}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text('Age: ${student.age}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'Hobby: ${student.hobby}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Student ID: ${student.studentId}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${student.email}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Favorite Subject: ${student.favoriteSubject}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

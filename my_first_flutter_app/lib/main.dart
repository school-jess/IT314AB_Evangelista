import 'package:flutter/material.dart';

import 'data/students_data.dart';
import 'models/student.dart';

void main() {
  runApp(MyApp(records: studentsSortedByName));
}

class MyApp extends StatelessWidget {
  final List<Student> records;

  const MyApp({super.key, this.records = students});

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
      routes: {
        "/": (context) => MyHomePage(records: records),
        "/student-list": (context) => StudentListView(),
        "/add-student": (context) => AddStudentView(),
        "/student-details": (context) => const StudentView(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Student> records;

  const MyHomePage({super.key, this.records = students});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  final ValueNotifier<({bool isLoading, List<Student> records})> studentState =
      ValueNotifier((isLoading: true, records: <Student>[]));

  Future<List<Student>> getStudents() async {
    await Future.delayed(const Duration(seconds: 5));
    return widget.records;
  }

  @override
  void initState() {
    super.initState();
    getStudents().then((res) {
      studentState.value = (isLoading: false, records: [...res]);
    });
  }

  void _removeStudent(Student student) {
    final updatedList = studentState.value.records
        .where((s) => s.studentId != student.studentId)
        .toList();

    studentState.value = (
      isLoading: studentState.value.isLoading,
      records: updatedList,
    );
  }

  Future<void> _editStudent(Student student) async {
    showStudentEditSheet(context, student);

    final updatedList = studentState.value.records.map((s) {
      if (s.studentId == student.studentId) {
        return student;
      }
      return s;
    }).toList();

    studentState.value = (
      isLoading: studentState.value.isLoading,
      records: updatedList,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainScreen = Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/student-list",
                  arguments: {
                    "stateNotifier": studentState,
                    "onRemove": _removeStudent,
                    "onEdit": _editStudent,
                  },
                );
              },
              child: const Text("Students"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/add-student",
                );
              },
              child: const Text("Add Student"),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Students'),
      ),
      body: mainScreen,
    );
  }
}

class AddStudentView extends StatefulWidget {
  const AddStudentView({super.key});

  @override
  State<AddStudentView> createState() => _AddStudentViewState();
}

class _AddStudentViewState extends State<AddStudentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Student")),
      body: const Text("hello"),
    );
  }
}

class StudentListView extends StatelessWidget {
  const StudentListView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var stateNotifier = args["stateNotifier"] as ValueNotifier<({bool isLoading, List<Student> records})>;

    return ValueListenableBuilder(
      valueListenable: stateNotifier,
      builder: (context, state, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Student List")),
          body: state.isLoading
              ? const Center(child: Text("Fetching students..."))
              : state.records.isEmpty
              ? const EmptyStudentsView()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.records.length,
                  itemBuilder: (context, index) {
                    final currentStudent = state.records[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/student-details",
                            arguments: {"student": currentStudent},
                          );
                        },
                        child: ChoosableStudentCard(
                          key: ValueKey(currentStudent.studentId),
                          student: currentStudent,
                          onRemove: () => args["onRemove"](currentStudent),
                          onEdit: () => args["onEdit"](currentStudent),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text("Student: ${args["student"].name}")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(args["student"].image, height: 128),
            const SizedBox(height: 8),
            Text(
              "${args["student"].name} ${args["student"].course}-${args["student"].yearLevel}",
            ),
            const SizedBox(height: 8),
            Text("Student ID: ${args["student"].studentId}"),
            const SizedBox(height: 8),
            Text("Email: ${args["student"].email}"),
            const SizedBox(height: 8),
            Text("Favorite Subject: ${args["student"].favoriteSubject}"),
            const SizedBox(height: 8),
            Text("Hobby: ${args["student"].hobby}"),
            const SizedBox(height: 8),
          ],
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

class ChoosableStudentCard extends StatefulWidget {
  final Student student;
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  const ChoosableStudentCard({
    super.key,
    required this.student,
    required this.onRemove,
    required this.onEdit,
  });

  @override
  State<ChoosableStudentCard> createState() => _ChoosableStudentCardState();
}

class _ChoosableStudentCardState extends State<ChoosableStudentCard> {
  bool isFavorite = false;
  bool isActive = false;
  bool isShown = true;

  @override
  Widget build(BuildContext context) {
    return isShown
        ? Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      widget.student.image,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.student.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.student.course} - ${widget.student.yearLevel}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Age: ${widget.student.age}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hobby: ${widget.student.hobby}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Student ID: ${widget.student.studentId}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${widget.student.email}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Favorite Subject: ${widget.student.favoriteSubject}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Text(isFavorite ? "Unfavorite" : "Favorite"),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isActive = !isActive;
                          });
                        },
                        child: Text(isActive ? "Unactivate" : "Activate"),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isShown = !isShown;
                          });
                        },
                        child: Text("Hide"),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: widget.onRemove,
                        child: Text("Remove"),
                      ),
                      const SizedBox(width: 8),
                      TextButton(onPressed: widget.onEdit, child: Text("Edit")),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isFavorite
                        ? "You have favorited this student"
                        : "You have unfavorited this student",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isActive
                        ? "This student is active"
                        : "This student is not active",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          )
        : Card(
            clipBehavior: Clip.antiAlias,
            elevation: 2.0,
            child: TextButton(
              onPressed: () {
                setState(() {
                  isShown = !isShown;
                });
              },
              child: Text("Show"),
            ),
          );
  }
}

Future<Student?> showStudentEditSheet(BuildContext context, Student student) {
  return showModalBottomSheet<Student>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _StudentEditSheet(student: student),
  );
}

class _StudentEditSheet extends StatefulWidget {
  final Student student;

  const _StudentEditSheet({required this.student});

  @override
  State<_StudentEditSheet> createState() => _StudentEditSheetState();
}

class _StudentEditSheetState extends State<_StudentEditSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _courseController;
  late final TextEditingController _yearLevelController;
  late final TextEditingController _ageController;
  late final TextEditingController _hobbyController;
  late final TextEditingController _studentIdController;
  late final TextEditingController _emailController;
  late final TextEditingController _favoriteSubjectController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.name);
    _courseController = TextEditingController(text: widget.student.course);
    _yearLevelController = TextEditingController(
      text: widget.student.yearLevel,
    );
    _ageController = TextEditingController(text: '${widget.student.age}');
    _hobbyController = TextEditingController(text: widget.student.hobby);
    _studentIdController = TextEditingController(
      text: widget.student.studentId,
    );
    _emailController = TextEditingController(text: widget.student.email);
    _favoriteSubjectController = TextEditingController(
      text: widget.student.favoriteSubject,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _courseController.dispose();
    _yearLevelController.dispose();
    _ageController.dispose();
    _hobbyController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _favoriteSubjectController.dispose();
    super.dispose();
  }

  void _save() {
    Navigator.of(context).pop(
      Student(
        image: widget.student.image,
        name: _nameController.text.trim(),
        course: _courseController.text.trim(),
        yearLevel: _yearLevelController.text.trim(),
        age: int.tryParse(_ageController.text.trim()) ?? widget.student.age,
        hobby: _hobbyController.text.trim(),
        studentId: _studentIdController.text.trim(),
        email: _emailController.text.trim(),
        favoriteSubject: _favoriteSubjectController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Edit ${widget.student.name}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _courseController,
              decoration: const InputDecoration(labelText: 'Course'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _yearLevelController,
              decoration: const InputDecoration(labelText: 'Year Level'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _hobbyController,
              decoration: const InputDecoration(labelText: 'Hobby'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _studentIdController,
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _favoriteSubjectController,
              decoration: const InputDecoration(labelText: 'Favorite Subject'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(onPressed: _save, child: const Text('Save')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'models/student.dart';
import 'dart:io';
import 'dart:convert';

var isLoading = true;
var students = <Student>[];
var studentDataFile = File("studentData.json");

Future<List<Student>> getStudents() async {
  if (!await studentDataFile.exists()) {
    isLoading = false;
    return [];
  }
  var studentDataContents = await studentDataFile.readAsString();
  if (studentDataContents.trim().isEmpty) {
    isLoading = false;
    return [];
  }
  var decodedData = jsonDecode(studentDataContents) as List<dynamic>;

  var studentData = decodedData.map((json) => Student.fromJson(json)).toList();
  isLoading = false;
  return studentData;
}

void main() async {
  students = await getStudents();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        "/": (context) => MyHomePage(),
        "/student-list": (context) => StudentListView(),
        "/add-student": (context) => AddStudentView(),
        "/student-details": (context) => const StudentView(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                Navigator.pushNamed(context, "/student-list");
              },
              child: const Text("Students"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add-student");
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

class AddStudentForm extends StatefulWidget {
  const AddStudentForm({super.key});

  @override
  State<AddStudentForm> createState() => _AddStudentForm();
}

class _AddStudentForm extends State<AddStudentForm> {
  final studentIdController = TextEditingController();
  final fullNameController = TextEditingController();
  final courseController = TextEditingController();
  final yearLevelController = TextEditingController();
  final emailAddressController = TextEditingController();
  final ageController = TextEditingController();
  final hobbyController = TextEditingController();
  final favoriteSubjectController = TextEditingController();
  final _addStudentFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    studentIdController.dispose();
    fullNameController.dispose();
    courseController.dispose();
    yearLevelController.dispose();
    emailAddressController.dispose();
    ageController.dispose();
    hobbyController.dispose();
    favoriteSubjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addStudentFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: studentIdController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Student ID field is empty";
              }
              if (students
                  .map((student) => student.studentId == val)
                  .any((student) => student)) {
                return "Student ID field is taken";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Student ID",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: fullNameController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Full Name field is empty";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Full Name",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: courseController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Course field is empty";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Course",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: yearLevelController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Year field is empty";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Year Level",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: emailAddressController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Email Address field is empty";
              }
              var emailValidator = RegExp(
                r"[a-z0-9\.]+@[a-z0-9]+\.[a-z0-9]{3}",
              );
              if (!emailValidator.hasMatch(val)) {
                return "Email Address field is invalid";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Email Address",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: ageController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Age field is empty";
              }
              if (val.contains(RegExp((r"[a-zA-Z]")))) {
                return "inputed alphabet characters";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Age",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: hobbyController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Hobby field is empty";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Hobby",
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: favoriteSubjectController,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return "Favorite Subject field is empty";
              }
              return null;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Favorite Subject",
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              if (_addStudentFormKey.currentState!.validate()) {
                students.add(
                  Student(
                    image:
                        'assets/images/wp4162286-celeste-game-wallpapers.png',
                    name: fullNameController.text.trim(),
                    course: courseController.text.trim(),
                    age: int.parse(ageController.text.trim()),
                    hobby: hobbyController.text.trim(),
                    studentId: studentIdController.text.trim(),
                    email: emailAddressController.text.trim(),
                    favoriteSubject: favoriteSubjectController.text.trim(),
                    yearLevel: yearLevelController.text.trim(),
                  ),
                );
                await studentDataFile.writeAsString(jsonEncode(students));
              }
            },
            child: const Text("submit"),
          ),
        ],
      ),
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
      body: const AddStudentForm(),
    );
  }
}

class StudentListView extends StatefulWidget {
  const StudentListView({super.key});

  @override
  State<StudentListView> createState() => _StudentListView();
}

class _StudentListView extends State<StudentListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student List")),
      body: isLoading
          ? const Center(child: Text("Fetching students..."))
          : students.isEmpty
          ? const EmptyStudentsView()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/student-details",
                        arguments: {"studentI": index},
                      );
                    },
                    child: ChoosableStudentCard(studentI: index),
                  ),
                );
              },
            ),
    );
  }
}

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    var studentI = args["studentI"] as int;
    var curStudent = students[studentI];

    return Scaffold(
      appBar: AppBar(title: Text("Student: ${curStudent.name}")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(curStudent.image, height: 128),
            const SizedBox(height: 8),
            Text(
              "${curStudent.name} ${curStudent.course}-${curStudent.yearLevel}",
            ),
            const SizedBox(height: 8),
            Text("Student ID: ${curStudent.studentId}"),
            const SizedBox(height: 8),
            Text("Email: ${curStudent.email}"),
            const SizedBox(height: 8),
            Text("Favorite Subject: ${curStudent.favoriteSubject}"),
            const SizedBox(height: 8),
            Text("Hobby: ${curStudent.hobby}"),
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
  final int studentI;

  const ChoosableStudentCard({super.key, required this.studentI});

  @override
  State<ChoosableStudentCard> createState() => _ChoosableStudentCardState();
}

class _ChoosableStudentCardState extends State<ChoosableStudentCard> {
  bool isFavorite = false;
  bool isActive = false;
  bool isShown = true;

  void onRemove() async {
    students.remove(students[widget.studentI]);
    await studentDataFile.writeAsString(jsonEncode(students));
  }

  void onEdit() {
    showStudentEditSheet(context, widget.studentI);
  }

  @override
  Widget build(BuildContext context) {
    var curStudent = students[widget.studentI];
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
                      curStudent.image,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    curStudent.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${curStudent.course} - ${curStudent.yearLevel}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Age: ${curStudent.age}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Hobby: ${curStudent.hobby}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Student ID: ${curStudent.studentId}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${curStudent.email}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Favorite Subject: ${curStudent.favoriteSubject}',
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
                      TextButton(onPressed: onRemove, child: Text("Remove")),
                      const SizedBox(width: 8),
                      TextButton(onPressed: onEdit, child: Text("Edit")),
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

Future<Student?> showStudentEditSheet(BuildContext context, int studentI) {
  return showModalBottomSheet<Student>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _StudentEditSheet(studentI: studentI),
  );
}

class _StudentEditSheet extends StatefulWidget {
  final int studentI;

  const _StudentEditSheet({required this.studentI});

  @override
  State<_StudentEditSheet> createState() => _StudentEditSheetState();
}

class _StudentEditSheetState extends State<_StudentEditSheet> {
  // TODO should also do the same validation here as when creating a student
  late final TextEditingController _nameController = TextEditingController(
    text: students[widget.studentI].name,
  );
  late final TextEditingController _courseController = TextEditingController(
    text: students[widget.studentI].course,
  );
  late final TextEditingController _yearLevelController = TextEditingController(
    text: students[widget.studentI].yearLevel,
  );
  late final TextEditingController _ageController = TextEditingController(
    text: "${students[widget.studentI].age}",
  );
  late final TextEditingController _hobbyController = TextEditingController(
    text: students[widget.studentI].hobby,
  );
  late final TextEditingController _studentIdController = TextEditingController(
    text: students[widget.studentI].studentId,
  );
  late final TextEditingController _emailController = TextEditingController(
    text: students[widget.studentI].email,
  );
  late final TextEditingController _favoriteSubjectController =
      TextEditingController(text: students[widget.studentI].favoriteSubject);

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

  void _save() async {
    students[widget.studentI].name = _nameController.text.trim();
    students[widget.studentI].course = _courseController.text.trim();
    students[widget.studentI].yearLevel = _yearLevelController.text.trim();
    students[widget.studentI].age =
        int.tryParse(_ageController.text.trim()) ??
        students[widget.studentI].age;
    students[widget.studentI].hobby = _hobbyController.text.trim();
    students[widget.studentI].studentId = _studentIdController.text.trim();
    students[widget.studentI].email = _emailController.text.trim();
    students[widget.studentI].favoriteSubject = _favoriteSubjectController.text
        .trim();

    await studentDataFile.writeAsString(jsonEncode(students));

    Navigator.of(context).pop(
      Student(
        image: students[widget.studentI].image,
        name: _nameController.text.trim(),
        course: _courseController.text.trim(),
        yearLevel: _yearLevelController.text.trim(),
        age:
            int.tryParse(_ageController.text.trim()) ??
            students[widget.studentI].age,
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
              'Edit ${students[widget.studentI].name}',
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

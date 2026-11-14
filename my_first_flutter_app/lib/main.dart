import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import 'models/student.dart';

Connection? connection;

Future<void> connectDb() async {
  final endpoint = Endpoint(
    host: 'ep-ancient-butterfly-a1f3ggyk-pooler.ap-southeast-1.aws.neon.tech',
    port: 5432,
    database: 'neondb',
    username: 'neondb_owner',
    password: 'npg_AWrZFUj6dS9V',
  );
  connection = await Connection.open(
    endpoint,
    settings: ConnectionSettings(sslMode: SslMode.require),
  );
}

Future<List<Student>> _fetchStudents() async {
  final db = connection;
  if (db == null) {
    throw StateError('Database connection is not available');
  }

  final result = await db.execute(Sql.named('SELECT * FROM "Student"'));
  return result.map((row) => Student.fromJson(row.toColumnMap())).toList();
}

Future<Student?> _fetchStudentById(int studentId) async {
  final db = connection;
  if (db == null) {
    throw StateError('Database connection is not available');
  }

  final result = await db.execute(
    Sql.named('SELECT * FROM "Student" WHERE id = @studentId'),
    parameters: {'studentId': studentId},
  );
  if (result.isEmpty) return null;
  return Student.fromJson(result.first.toColumnMap());
}

void main() async {
  await connectDb();
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
  late final Future<List<Student>> _studentsFuture;
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _studentsFuture = _fetchStudents();
  }

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
              if (_students
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
              _students = await _studentsFuture;
              if (!mounted) return;
              if (_addStudentFormKey.currentState!.validate()) {
                await connection?.execute(
                  Sql.named(
                    'INSERT INTO "Student" (image, name, course, yearLevel, age, hobby, studentId, email, favoriteSubject) VALUES (@image, @name, @course, @yearLevel, @age, @hobby, @studentId, @email, @favoriteSubject)',
                  ),
                  parameters: {
                    "image": "images/wp4162286-celeste-game-wallpapers.png",
                    "name": fullNameController.text.trim(),
                    "course": courseController.text.trim(),
                    "yearLevel": yearLevelController.text,
                    "age": ageController.text,
                    "hobby": hobbyController.text.trim(),
                    "studentId": studentIdController.text.trim(),
                    "email": emailAddressController.text.trim(),
                    "favoriteSubject": favoriteSubjectController.text.trim()
                  },
                );
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
  late final Future<List<Student>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = _fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student List")),
      body: FutureBuilder<List<Student>>(
        future: _studentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Fetching students..."));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Could not load students: ${snapshot.error}"),
            );
          }

          final students = snapshot.data ?? [];
          if (students.isEmpty) return const EmptyStudentsView();

          return ListView.builder(
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
                      arguments: {"studentI": students[index].id},
                    );
                  },
                  child: ChoosableStudentCard(student: students[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  late Future<Student?> _studentFuture;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _studentFuture = _fetchStudentById(args["studentI"] as int);
    _started = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Details")),
      body: FutureBuilder<Student?>(
        future: _studentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Could not load student: ${snapshot.error}"),
            );
          }

          final student = snapshot.data;
          if (student == null) {
            return const Center(child: Text("Student not found"));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(student.image, height: 128),
                const SizedBox(height: 8),
                Text("${student.name} ${student.course}-${student.yearLevel}"),
                const SizedBox(height: 8),
                Text("Student ID: ${student.studentId}"),
                const SizedBox(height: 8),
                Text("Email: ${student.email}"),
                const SizedBox(height: 8),
                Text("Favorite Subject: ${student.favoriteSubject}"),
                const SizedBox(height: 8),
                Text("Hobby: ${student.hobby}"),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
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

  const ChoosableStudentCard({super.key, required this.student});

  @override
  State<ChoosableStudentCard> createState() => _ChoosableStudentCardState();
}

class _ChoosableStudentCardState extends State<ChoosableStudentCard> {
  bool isFavorite = false;
  bool isActive = false;
  bool isShown = true;

  Future<void> onRemove() async {
    await connection?.execute(
      Sql.named('DELETE FROM "Student" WHERE id = @studentI'),
      parameters: {'studentI': widget.student.id},
    );
  }

  void onEdit() {
    showStudentEditSheet(context, widget.student.id);
  }

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

Future<Student?> showStudentEditSheet(
  BuildContext context,
  int studentI,
) async {
  final curStudent = await _fetchStudentById(studentI);
  if (curStudent == null || !context.mounted) return null;
  return showModalBottomSheet<Student>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _StudentEditSheet(student: curStudent),
  );
}

class _StudentEditSheet extends StatefulWidget {
  final Student student;

  const _StudentEditSheet({required this.student});

  @override
  State<_StudentEditSheet> createState() => _StudentEditSheetState();
}

class _StudentEditSheetState extends State<_StudentEditSheet> {
  // TODO should also do the same validation here as when creating a student
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _yearLevelController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _favoriteSubjectController =
      TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.student.name;
    _courseController.text = widget.student.course;
    _yearLevelController.text = widget.student.yearLevel;
    _ageController.text = widget.student.age.toString();
    _hobbyController.text = widget.student.hobby;
    _studentIdController.text = widget.student.studentId;
    _emailController.text = widget.student.email;
    _favoriteSubjectController.text = widget.student.favoriteSubject;
  }

  Future<void> _save() async {
    await connection?.execute(
          Sql.named(
            'UPDATE "Student" SET image=@image, name=@name, course=@course, yearLevel=@yearLevel, age=@age, hobby=@hobby, studentId=@studentId, email=@email, favoriteSubject=@favoriteSubject where id = @id',
          ),
          parameters: {
            'id': widget.student.id,
            'image': widget.student.image,
            'name': _nameController.text.trim(),
            'course': _courseController.text.trim(),
            'yearLevel': _yearLevelController.text.trim(),
            'age':
                int.tryParse(_ageController.text.trim()) ?? widget.student.age,
            'hobby': _hobbyController.text.trim(),
            'studentId': _studentIdController.text.trim(),
            'email': _emailController.text.trim(),
            'favoriteSubject': _favoriteSubjectController.text.trim(),
          },
        );

    Navigator.of(context).pop(
      Student(
        id: widget.student.id,
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

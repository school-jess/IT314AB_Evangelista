import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_flutter_app/data/students_data.dart';
import 'package:my_first_flutter_app/main.dart';

void main() {
  testWidgets('Shows empty state when there are no students', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(records: []));

    expect(find.text('No students available'), findsOneWidget);
    expect(find.text('New student records will appear here.'), findsOneWidget);
    expect(find.byType(StudentCard), findsNothing);
  });

  test('Students are sorted alphabetically by name', () {
    final names = studentsSortedByName.map((s) => s.name).toList();
    final expected = [...names]..sort();
    expect(names, equals(expected));
  });

  testWidgets('Sorts students alphabetically in the UI', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(records: studentsSortedByName));

    expect(find.text('Andrea Reyes'), findsOneWidget);

    for (var student in studentsSortedByName.skip(1)) {
      await tester.scrollUntilVisible(
        find.text(student.name),
        200,
        scrollable: find.byType(Scrollable),
      );
      expect(find.text(student.name), findsOneWidget);
    }

    expect(find.text('Sofia Mendoza'), findsOneWidget);
  });

  testWidgets('Shows details for every student', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(records: studentsSortedByName));

    for (var student in studentsSortedByName) {
      await tester.scrollUntilVisible(
        find.text(student.name),
        200,
        scrollable: find.byType(Scrollable),
      );
      expect(find.textContaining(student.course), findsWidgets);
      expect(find.textContaining(student.yearLevel), findsWidgets);
      expect(find.textContaining('${student.age}'), findsWidgets);
      expect(find.textContaining(student.hobby), findsWidgets);
      expect(find.textContaining(student.studentId), findsWidgets);
      expect(find.textContaining(student.email), findsWidgets);
      expect(find.textContaining(student.favoriteSubject), findsWidgets);
    }
  });
}
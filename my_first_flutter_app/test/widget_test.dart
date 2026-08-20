import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:my_first_flutter_app/data/students_data.dart';
import 'package:my_first_flutter_app/main.dart';

void main() {
  testWidgets('Shows empty state when there are no students', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp(records: []));

    expect(find.text('No students available'), findsOneWidget);
    expect(find.text('New student records will appear here.'), findsOneWidget);
    expect(find.byType(ChoosableStudentCard), findsNothing);
  });

  testWidgets('Removes a student when Remove is tapped', (WidgetTester tester) async {
    final records = studentsSortedByName.take(2).toList();
    await tester.pumpWidget(MyApp(records: records));

    final firstCard = find.ancestor(
      of: find.text(records.first.name),
      matching: find.byType(ChoosableStudentCard),
    );
    await tester.tap(find.descendant(of: firstCard, matching: find.text('Remove')));
    await tester.pump();

    expect(find.text(records.first.name), findsNothing);
    expect(find.text(records.last.name), findsOneWidget);
  });

  testWidgets('Shows empty state after removing the last student', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(records: [studentsSortedByName.first]));

    await tester.tap(find.text('Remove'));
    await tester.pump();

    expect(find.text('Andrea Reyes'), findsNothing);
    expect(find.text('No students available'), findsOneWidget);
  });

  testWidgets('Launches edit sheet prefilled with student data', (WidgetTester tester) async {
    final student = studentsSortedByName.first;
    await tester.pumpWidget(MyApp(records: [student]));

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    expect(find.text('Edit ${student.name}'), findsOneWidget);
    expect(find.widgetWithText(TextField, student.name), findsOneWidget);
    expect(find.widgetWithText(TextField, student.email), findsOneWidget);
  });

  testWidgets('Saves edits from the sheet', (WidgetTester tester) async {
    final student = studentsSortedByName.first;
    await tester.pumpWidget(MyApp(records: [student]));

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, student.name),
      'Edited Name',
    );
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Edit Edited Name'), findsNothing);
    expect(find.text('Edited Name'), findsOneWidget);
    expect(find.textContaining(student.email), findsOneWidget);
  });

  testWidgets(
    'Favorite A, delete C, edit B - each student behaves independently',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 2400));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final a = studentsSortedByName[0];
      final b = studentsSortedByName[1];
      final c = studentsSortedByName[2];

      await tester.pumpWidget(MyApp(records: [a, b, c]));

      Finder cardOf(String name) => find.ancestor(
            of: find.text(name),
            matching: find.byType(ChoosableStudentCard),
          );
      Finder buttonIn(Finder card, String label) =>
          find.descendant(of: card, matching: find.text(label));

      // Favorite Student A.
      await tester.tap(buttonIn(cardOf(a.name), 'Favorite'));
      await tester.pump();
      expect(
        find.descendant(
          of: cardOf(a.name),
          matching: find.text('You have favorited this student'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardOf(b.name),
          matching: find.text('You have unfavorited this student'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardOf(c.name),
          matching: find.text('You have unfavorited this student'),
        ),
        findsOneWidget,
      );

      // Delete Student C. No space is left behind.
      await tester.tap(buttonIn(cardOf(c.name), 'Remove'));
      await tester.pump();
      expect(find.text(c.name), findsNothing);
      expect(find.byType(ChoosableStudentCard), findsNWidgets(2));
      expect(
        find.descendant(
          of: cardOf(a.name),
          matching: find.text('You have favorited this student'),
        ),
        findsOneWidget,
      );

      // Edit Student B.
      await tester.tap(buttonIn(cardOf(b.name), 'Edit'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextField, b.name),
        'Edited Name',
      );
      await tester.ensureVisible(find.text('Save'));
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // B updated; A and C unaffected.
      expect(find.text('Edited Name'), findsOneWidget);
      expect(find.textContaining('Email: ${b.email}'), findsOneWidget);
      expect(
        find.descendant(
          of: cardOf('Edited Name'),
          matching: find.text('You have unfavorited this student'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: cardOf(a.name),
          matching: find.text('You have favorited this student'),
        ),
        findsOneWidget,
      );
      expect(find.textContaining('Email: ${a.email}'), findsOneWidget);
      expect(find.byType(ChoosableStudentCard), findsNWidgets(2));
    },
  );

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
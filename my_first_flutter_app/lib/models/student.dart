class Student {
  final int id;
  final String image;
  String name;
  String course;
  String yearLevel;
  int age;
  String hobby;
  String studentId;
  String email;
  String favoriteSubject;

  Student({
    required this.id,
    required this.image,
    required this.name,
    required this.course,
    required this.yearLevel,
    required this.age,
    required this.hobby,
    required this.studentId,
    required this.email,
    required this.favoriteSubject,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'course': course,
      'age': age,
      'hobby': hobby,
      'studentId': studentId,
      'email': email,
      'favoriteSubject': favoriteSubject,
      'yearLevel': yearLevel,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      course: json['course'] ?? '',
      age: json['age'] ?? 0,
      hobby: json['hobby'] ?? '',
      studentId: json['studentId'] ?? json['studentid'] ?? '',
      email: json['email'] ?? '',
      favoriteSubject: json['favoriteSubject'] ?? json['favoritesubject'] ?? '',
      yearLevel: json['yearLevel'] ?? json['yearlevel'] ?? '',
    );
  }
}

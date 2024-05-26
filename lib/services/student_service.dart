import 'package:shared_preferences/shared_preferences.dart';

class StudentService {
  static const String _studentsKey = 'students_key';

  Future<void> addStudent(String name, String dob, String gender) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> students = prefs.getStringList(_studentsKey) ?? [];
    students.add('$name|$dob|$gender');
    prefs.setStringList(_studentsKey, students);
  }

  Future<List<Map<String, String>>> getStudents() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> students = prefs.getStringList(_studentsKey) ?? [];
    return students.map((student) {
      final parts = student.split('|');
      return {
        'name': parts[0],
        'dob': parts[1],
        'gender': parts[2],
      };
    }).toList();
  }
}

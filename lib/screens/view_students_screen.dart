import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/student_service.dart';

class ViewStudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final studentService = Provider.of<StudentService>(context, listen: false);

    return FutureBuilder<List<Map<String, String>>>(
      future: studentService.getStudents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No students found'));
        } else {
          final students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              return ListTile(
                title: Text(student['name']! ,style: TextStyle(color: Color(
                    0xff7ffaf0)),),
                subtitle: Text('DOB: ${student['dob']} | Gender: ${student['gender']}',style: TextStyle(color: Color(
                    0xff7ffaf0))),
              );
            },
          );
        }
      },
    );
  }
}

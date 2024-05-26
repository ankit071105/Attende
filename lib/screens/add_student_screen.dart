import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/student_service.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final studentService = Provider.of<StudentService>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) => value!.isEmpty ? 'Enter name' : null,
            ),
            TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'YYYY-MM-DD',
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dobController.text = pickedDate.toIso8601String().split('T')[0];
                  });
                }
              },
              validator: (value) => value!.isEmpty ? 'Enter date of birth' : null,
            ),
            DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(labelText: 'Gender'),
              items: ['Male', 'Female', 'Other'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              validator: (value) => value == null ? 'Select gender' : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Add Student'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await studentService.addStudent(
                    _nameController.text,
                    _dobController.text,
                    _selectedGender!,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Student added')),
                  );
                  _formKey.currentState!.reset();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapi/widgets/text_field_widget.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class AddUserPopup extends StatefulWidget {
  const AddUserPopup({super.key});

  @override
  State<AddUserPopup> createState() => _AddUserPopupState();
}

class _AddUserPopupState extends State<AddUserPopup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final users = userProvider.users;
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add User',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: _nameController,
            label: 'Enter your Name',
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            controller: _emailController,
            label: 'Enter your Email',
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            length: 10,
            controller: _mobileController,
            label: 'Enter your Phone number',
            inputType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Back'),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _mobileController.text.isNotEmpty) {
                      final data = UserModel(
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _mobileController.text);
                      users.add(data);
                      context.read<UserProvider>().saveData([...users]);
                      _nameController.clear();
                      _emailController.clear();
                      _mobileController.clear();
                      Navigator.of(context).pop();
                      setState(() {});
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

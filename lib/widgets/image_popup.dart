import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapi/models/user_album_model.dart';
import 'package:taskapi/widgets/text_field_widget.dart';
import 'package:uuid/uuid.dart';
import '../providers/album_provider.dart';

class AddAlbumPopup extends StatefulWidget {
  const AddAlbumPopup({super.key});

  @override
  State<AddAlbumPopup> createState() => _AddAlbumPopupState();
}

class _AddAlbumPopupState extends State<AddAlbumPopup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    final albumProvider = context.watch<AlbumProvider>();
    final albums = albumProvider.albums;

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
         InkWell(
           onTap: (){

           },
             child: Text('Select an image'))
        ],
      ),
    );
  }
}

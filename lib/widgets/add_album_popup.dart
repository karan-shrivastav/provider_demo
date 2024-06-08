import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapi/models/user_album_model.dart';
import 'package:taskapi/widgets/text_field_widget.dart';
import '../providers/album_provider.dart';

class AddAlbumPopup extends StatefulWidget {
  const AddAlbumPopup({super.key});

  @override
  State<AddAlbumPopup> createState() => _AddAlbumPopupState();
}

class _AddAlbumPopupState extends State<AddAlbumPopup> {
  final TextEditingController _titleController = TextEditingController();


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
            controller: _titleController,
            label: 'Enter Title',
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
                    if (_titleController.text.isNotEmpty ) {
                      final data = UserAlbumModel(
                        title: _titleController.text,
                        userId: 1,
                      );
                      albums.add(data);
                      context.read<AlbumProvider>().saveData([...albums]);
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

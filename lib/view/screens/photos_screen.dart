import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taskapi/models/photos_model.dart';
import 'package:taskapi/providers/photos_provider.dart';
import 'dart:io';

class PhotosScreen extends StatefulWidget {
  final String userId;
  const PhotosScreen({super.key, required this.userId});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  File? _imageFile;
  String? _imageName;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _imageName = _imageFile != null ? _imageFile!.path.split('/').last : '';
      });
    }
  }

  @override
  void initState() {
    context.read<PhotosProvider>().getAllPhotos(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final photosProvider = context.watch<PhotosProvider>();
    final photos = photosProvider.photos;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Add Image',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          _pickImage();
                          final data = PhotosModel(
                            image: _imageFile,
                          );
                          photos.add(data);
                          context.read<PhotosProvider>().saveData([...photos]);
                        },
                        child: const Text('Select an image'))
                  ],
                ),
              );
              ;
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Photos screen'),
        backgroundColor: Colors.blue,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return (photos[index].isImageMobile == true)
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: photos[index].thumbnailUrl ?? '',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 25,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<PhotosProvider>()
                              .deleteData(photos[index].id ?? 0);
                        },
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Image.file(
                    photos[index].image!,
                    fit: BoxFit.cover,
                  ),
                );
        },
      ),
    );
  }
}

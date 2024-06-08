import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapi/providers/album_provider.dart';
import 'package:taskapi/view/screens/photos_screen.dart';
import '../../widgets/add_album_popup.dart';

class AlbumScreen extends StatefulWidget {
  final String userId;
  const AlbumScreen({super.key, required this.userId});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void initState() {
    print('userId :${widget.userId}');
    context.read<AlbumProvider>().getAllAlbums(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final albumProvider = context.watch<AlbumProvider>();
    final albums = albumProvider.albums;
    print(albums);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddAlbumPopup();
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Album screen'),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: albums.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PhotosScreen(
                          userId: albums[index].userId.toString(),
                        )));
              },
              child: Card(
                child: ListTile(
                  title: Text('${albums[index].userId}'),
                  subtitle: Text(albums[index].title ?? ''),
                  trailing: SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        // InkWell(
                        //     onTap: () {
                        //       showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) {
                        //           return EditUserPopup(
                        //             name: users[index].name ?? '',
                        //             email: users[index].email ?? '',
                        //             phoneNumber: users[index].phone ?? '',
                        //           );
                        //         },
                        //       );
                        //     },
                        //     child: const Icon(Icons.edit)),
                        InkWell(
                            onTap: () {
                              context
                                  .read<AlbumProvider>()
                                  .deleteData(albums[index].id ?? 0);
                              setState(() {});
                            },
                            child: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapi/providers/create_user_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/add_user_popup.dart';
import 'album_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<UserProvider>().getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final users = userProvider.users;
    final createUserProvider = context.read<CreateUserProvider>();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AddUserPopup();
              },
            );
          },
          tooltip: 'Add Item',
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Users Screen'),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: users.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AlbumScreen(
                          userId: users[index].id.toString(),
                        )));
              },
              child: Card(
                child: ListTile(
                  title: Text(users[index].name ?? ''),
                  subtitle: Text(users[index].email ?? ''),
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
                                  .read<UserProvider>()
                                  .deleteData(users[index].id ?? 0);
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

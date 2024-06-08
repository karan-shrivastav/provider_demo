import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:taskapi/models/user_album_model.dart';


class AlbumProvider with ChangeNotifier {

  List<UserAlbumModel> _albums = [];
  List<UserAlbumModel> get albums => _albums;

  void saveData(List<UserAlbumModel> value) {
    _albums = value;
    notifyListeners();
  }

  void deleteData(int id) {
    _albums.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<List<UserAlbumModel>> getAllAlbums( userId) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/?userId=$userId'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      List<UserAlbumModel> albums = jsonData.map((user) => UserAlbumModel.fromJson(user)).toList();
      saveData(albums);
      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }
}

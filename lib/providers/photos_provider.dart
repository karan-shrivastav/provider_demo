import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/photos_model.dart';

class PhotosProvider with ChangeNotifier {

  List<PhotosModel> _photos = [];

  List<PhotosModel> get photos => _photos;

  void saveData(List<PhotosModel> value) {
    _photos = value;
    notifyListeners();
  }

  void deleteData(int id) {
    _photos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<List<PhotosModel>> getAllPhotos( id) async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$id/photos'));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<PhotosModel> albums = jsonData.map((user) => PhotosModel.fromJson(user)).toList();
      saveData(albums);
      for(int i = 0; i<albums.length; i++){
        print(albums[i].isImageMobile);
      }
      //print('albums :${albums}');
      return albums;
    } else {
      throw Exception('Failed to load photos');
    }
  }
}

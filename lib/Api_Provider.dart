import 'dart:convert';

import 'package:api_integration/Album.dart';
import 'package:api_integration/Post.dart';
import 'package:http/http.dart';

extension ApiProvider on Response {
  bool isSuccess() {
    return statusCode == 200;
  }

  bool isCreated() {
    return statusCode == 201;
  }
}

abstract class Api_Provider {
  String Base_Url = "https://jsonplaceholder.typicode.com";
  String get Api_Url;
  Uri url({String endPoint = ""}) => Uri.parse(Base_Url + Api_Url + endPoint);
  _fetch({String endPoint = ""}) async {
    Response response = await get(url(endPoint: endPoint));
    if (response.isSuccess()) {
      return jsonDecode(response.body);
    }
    return null;
  }

  _insert(Map<String, dynamic> map, {String endPoint = ""}) async {
    Response response = await post(url(), body: jsonEncode(map));

    return response.isCreated();
  }
}

class ApiAlbumProvider extends Api_Provider {
  @override
  String get Api_Url => "/albums";
  Future<List<Album>> getData() async {
    var listAlbums = await _fetch() as List;
    return listAlbums.map((album) => Album.fromMap(album)).toList();
  }

  Future<bool> insertData(Album album) async {
    return await _insert(album.toMap());
  }
}

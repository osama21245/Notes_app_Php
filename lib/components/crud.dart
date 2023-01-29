import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('osama:osama12345'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class Crud {
  postRequest(url, Map data) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  getRequest(url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  PostRequestwithfile(String Url, Map data, File file) async {
    var request = http.MultipartRequest("post", Uri.parse(Url));
    var lenth = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartfile = http.MultipartFile("file", stream, lenth,
        filename: basename(file.path));
    request.headers.addAll(myheaders);
    request.files.add(multipartfile);
    data.forEach((key, value) {
      request.fields[key] = value;
    });
    var myrequest = await request.send();

    var response = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("Error${myrequest.statusCode}");
    }
  }
}

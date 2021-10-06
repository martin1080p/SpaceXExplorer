import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class SpaceXRequest {
  Uri baseUrl = Uri.parse('https://api.spacexdata.com/v4/launches/query');

  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  var client = http.Client();

  basicRequest(int pageNum, int limit, String sortParameter, String sortDirection, bool isSearch, String searchQuery, int yearStart,
      int yearEnd) async {
    yearEnd += 1;

    var query = !isSearch
        ? {
            'upcoming': false,
            "date_utc": {"\$gte": yearStart.toString(), "\$lte": yearEnd.toString()}
          }
        : {
            'upcoming': false,
            '\$text': {'\$search': searchQuery},
            "date_utc": {"\$gte": yearStart.toString(), "\$lte": yearEnd.toString()}
          };

    Map<String, dynamic> requestBody = {
      'query': query,
      'options': {
        'sort': {sortParameter: sortDirection},
        'limit': limit,
        'page': pageNum
      }
    };

    try {
      var response = await client.post(baseUrl, headers: headers, body: jsonEncode(requestBody));
      if (response.statusCode != 200) throw HttpException('${response.statusCode}');
      return response;
    } on SocketException {
      print('No Internet connection');
    } on HttpException {
      print("Couldn't find the post");
    } on FormatException {
      print("Bad response format");
    }
  }
}

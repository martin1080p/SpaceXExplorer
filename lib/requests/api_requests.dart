import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SpaceXRequest {
  Uri baseUrl = Uri.parse('https://api.spacexdata.com/v4/launches/query');

  var headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  basicRequest(int pageNum, int limit, String sortParameter, String sortDirection, bool isSearch, String searchQuery) async {
    var query = !isSearch
        ? {'upcoming': false}
        : {
            'upcoming': false,
            '\$text': {'\$search': searchQuery}
          };

    Map<String, dynamic> requestBody = {
      'query': query,
      'options': {
        'sort': {sortParameter: sortDirection},
        'limit': limit,
        'page': pageNum
      }
    };

    var response = await http.post(baseUrl, headers: headers, body: jsonEncode(requestBody));

    return response;
  }
}

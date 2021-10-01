import 'dart:convert';

import 'package:http/http.dart' as http;

class SpaceXRequest{

  searchRequest(String query) async{
    Uri baseUrl = Uri.parse('https://api.spacexdata.com/v4/launches/query');

    var headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var requestBody = jsonEncode({
      'query' : {
        'upcoming' : false,
        "\$text": {
		      "\$search": query
		    }
      },
      'options' : {
        'sort' : {
          'flight_number' : 'asc'
        },
        'limit' : 3,
        'offset' : 0
      }
    });

    var response = await http.post(
      baseUrl,
      headers: headers,
      body : requestBody
    );

    var body = jsonDecode(response.body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${body.toString()}');
  }
}
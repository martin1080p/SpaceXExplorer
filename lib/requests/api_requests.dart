import 'dart:convert';
import 'package:http/http.dart' as http;

class SpaceXRequest{

  Uri baseUrl = Uri.parse('https://api.spacexdata.com/v4/launches/query');

  var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

  basicRequest(int pageNum, int limit, String sortParameter, String sortDirection, bool isSearch, String searchQuery) async{
    
    var requestBody = {
      'query' : {
        'upcoming' : false,
      },
      'options' : {
        'sort' : {
          sortParameter : sortDirection
        },
        'limit' : limit,
        'offset' : pageNum * limit
      }
    };
    
    
    if(isSearch)
      requestBody['query']?['\$text'] = {
        '\$search': searchQuery
      };

    

    var response = await http.post(
      baseUrl,
      headers: headers,
      body : jsonEncode(requestBody)
    );
    
    return jsonDecode(response.body).toString();
  }

  searchRequest(String query) async{

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
import 'dart:convert';

import 'package:http/http.dart' as http;

Future searchApiCall(String q) async {
  try {
    final queryParameters = {"q": q};
    final uri = Uri.https('genius.p.rapidapi.com', '/search', queryParameters);
    final res = await http.get(uri, headers: {
      'x-rapidapi-key': 'e5452a8f51mshf7160b00b12be80p122bb1jsnecc0964fedbd',
      'x-rapidapi-host': 'genius.p.rapidapi.com'
    });
    final data = json.decode(res.body);
    return data['response']['hits'];
  } catch (e) {
    print("Error while getting response");
    return false;
  }
}

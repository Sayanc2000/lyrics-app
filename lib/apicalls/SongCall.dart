import 'dart:convert';
import 'package:http/http.dart' as http;

Future songApiCall(int id) async {
  try {
    final uri = Uri.https('genius.p.rapidapi.com', '/songs/$id');
    final res = await http.get(uri, headers: {
      'x-rapidapi-key': 'e5452a8f51mshf7160b00b12be80p122bb1jsnecc0964fedbd',
      'x-rapidapi-host': 'genius.p.rapidapi.com'
    });
    final data = json.decode(res.body);
    print(data['response']['song']);
    return data['response']['song'];
  } catch (e) {
    print("Error while getting song");
    return false;
  }
}

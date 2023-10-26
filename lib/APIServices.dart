import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ModelIkan.dart';

class IkanService {
  final String baseUrl = "https://responsi1a.dalhaqq.xyz/ikan";

  Future<List<Ikan>> getIkanList() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body)['data'];
      return list.map((model) => Ikan.fromJson(model)).toList();
    } else {
      throw Exception('Gagal Ambil Data');
    }
  }

  Future<Ikan> getIkanById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Ikan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Gagal Ambil Data Iwak');
    }
  }

  Future<Ikan> addIkan(Ikan ikan) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(ikan.toJson()),
    );
    if (response.statusCode == 200) {
      return Ikan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Gagal Menambahkan Iwak');
    }
  }

  Future<Ikan> updateIkan(String id, Ikan ikan) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(ikan.toJson()),
    );
    if (response.statusCode == 200) {
      return Ikan.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Gagal Perbarui Iwak');
    }
  }

  Future<bool> deleteIkan(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Hapus Iwak');
    }
  }
}

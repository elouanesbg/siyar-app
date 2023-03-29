import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:siyar/models/celebrity.dart';

class DataService {
  Future<List<Celebrity>> readJson() async {
    final String response = await rootBundle.loadString('assets/siyar1.json');
    List data = await json.decode(response);
    return data.map((json) => Celebrity.fromJson(json)).toList();
  }
}

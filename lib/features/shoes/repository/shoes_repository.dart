import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_sneaker/data/shoes_json.dart';

import '../model/shoes.dart';

final shoesRepositoryProvider = Provider((ref) => ShoesRepository());

class ShoesRepository {
  List<Shoes> shoesStorage = shoesData.map((e) => Shoes.fromMap(e)).toList();
}
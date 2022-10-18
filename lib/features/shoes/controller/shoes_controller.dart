import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/shoes.dart';
import '../repository/shoes_repository.dart';

final shoesControllerProvider = Provider((ref) {
  final shoesRepository = ref.watch(shoesRepositoryProvider);
  return ShoesController(shoesRepository: shoesRepository, ref: ref);
});

class ShoesController {
  final ShoesRepository shoesRepository;
  final ProviderRef ref;

  const ShoesController({
    required this.shoesRepository,
    required this.ref,
  });

  List<Shoes> getShoesItems() => shoesRepository.shoesStorage;
}
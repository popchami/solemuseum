import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/brand.dart';
import '../repositories/brand_repository.dart';

final brandRepositoryProvider = Provider<BrandRepository>((ref) {
  return BrandRepository();
});

final brandsProvider = FutureProvider<List<Brand>>((ref) async {
  final repository = ref.watch(brandRepositoryProvider);
  return repository.getAllBrands();
});

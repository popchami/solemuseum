import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'search_index.dart';
import 'search_repository.dart';
import 'search_service.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return const SearchRepository();
});

final searchIndexProvider = FutureProvider<SearchIndex>((ref) async {
  final repository = ref.watch(searchRepositoryProvider);
  return repository.loadIndex();
});

final searchServiceProvider = FutureProvider<SearchService>((ref) async {
  final index = await ref.watch(searchIndexProvider.future);
  return SearchService(index);
});

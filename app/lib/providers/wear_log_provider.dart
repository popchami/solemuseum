import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/wear_log.dart';
import '../repositories/wear_log_repository.dart';

final wearLogRepositoryProvider = Provider<WearLogRepository>((ref) {
  return WearLogRepository();
});

final wearLogsByShoeIdProvider =
    FutureProvider.family<List<WearLog>, int>((ref, shoeId) async {
  final repository = ref.watch(wearLogRepositoryProvider);
  return repository.getWearLogsByShoeId(shoeId);
});

final recentWearLogsProvider = FutureProvider<List<WearLog>>((ref) async {
  final repository = ref.watch(wearLogRepositoryProvider);
  return repository.getRecentWearLogs();
});

final allWearLogsProvider = FutureProvider<List<WearLog>>((ref) async {
  final repository = ref.watch(wearLogRepositoryProvider);
  return repository.getAllWearLogs();
});

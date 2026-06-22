import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../models/shoe.dart';
import '../models/wear_log.dart';
import '../providers/backup_provider.dart';
import '../providers/brand_provider.dart';
import '../providers/shoe_provider.dart';
import '../providers/wear_log_provider.dart';
import '../screens/shoe_form_screen.dart';

class AppFab extends ConsumerWidget {
  const AppFab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          showDragHandle: true,
          builder: (sheetContext) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('靴を登録'),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ShoeFormScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.today_outlined),
                      title: const Text('今日履いた'),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle: true,
                          builder: (_) => const _TodayWornPicker(),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.ios_share_outlined),
                      title: const Text('コレクション共有'),
                      subtitle: const Text('JSONバックアップファイルを共有します'),
                      onTap: () async {
                        Navigator.of(sheetContext).pop();
                        await _shareCollection(context, ref);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Future<void> _shareCollection(BuildContext context, WidgetRef ref) async {
    try {
      final file = await ref.read(backupServiceProvider).createBackupFile();
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'SoleMuseum コレクション',
        text: 'SoleMuseumのコレクションデータです。',
      );
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('共有に失敗しました')),
        );
      }
    }
  }
}

class _TodayWornPicker extends ConsumerWidget {
  const _TodayWornPicker();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shoesAsync = ref.watch(shoesProvider);
    final brandsAsync = ref.watch(brandsProvider);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              '今日履いた靴を選んでください',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(height: 1),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: shoesAsync.when(
              data: (shoes) {
                if (shoes.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'スニーカーが登録されていません',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return brandsAsync.when(
                  data: (brands) {
                    final brandNames = {
                      for (final b in brands)
                        if (b.id != null) b.id!: b.name,
                    };
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: shoes.length,
                      itemBuilder: (_, index) {
                        final shoe = shoes[index];
                        return ListTile(
                          title: Text(shoe.modelName),
                          subtitle: Text(brandNames[shoe.brandId] ?? ''),
                          trailing: Text(
                            shoe.archiveNumber,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          onTap: () async {
                            await _recordWearForShoe(context, ref, shoe);
                          },
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (_, __) => const Padding(
                    padding: EdgeInsets.all(32),
                    child: Text('読み込みに失敗しました'),
                  ),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (_, __) => const Padding(
                padding: EdgeInsets.all(32),
                child: Text('読み込みに失敗しました'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _recordWearForShoe(
    BuildContext context,
    WidgetRef ref,
    Shoe shoe,
  ) async {
    final controller = TextEditingController();
    final memo = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('${shoe.modelName}\n今日の着用記録'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'メモ（任意）',
            hintText: '行き先や天気など',
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text.trim()),
            child: const Text('記録'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (memo == null || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();

    try {
      final inserted = await ref.read(wearLogRepositoryProvider).insertWearLog(
            WearLog.create(
              shoeId: shoe.id!,
              wornDate: DateTime.now(),
              memo: memo.isEmpty ? null : memo,
            ),
          );
      ref.invalidate(wearLogsByShoeIdProvider(shoe.id!));
      ref.invalidate(recentWearLogsProvider);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            inserted
                ? '${shoe.modelName}の着用を記録しました'
                : '今日はすでに記録済みです',
          ),
        ),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('着用記録の保存に失敗しました')),
      );
    }
  }
}

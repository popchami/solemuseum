import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/brand.dart';
import '../providers/brand_provider.dart';
import '../providers/shoe_provider.dart';

class BrandManagementScreen extends ConsumerWidget {
  const BrandManagementScreen({super.key});

  Future<void> _addBrand(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ブランドを追加'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'ブランド名',
            hintText: '例: Salehe Bembury',
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              Navigator.of(context).pop(value.trim());
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) Navigator.of(context).pop(text);
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
    controller.dispose();

    if (name == null || !context.mounted) return;

    final rowId = await ref.read(brandRepositoryProvider).insertBrand(name);
    ref.invalidate(brandsProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            rowId > 0 ? '$name を追加しました' : '$name はすでに登録されています',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brandsAsync = ref.watch(brandsProvider);
    final shoesAsync = ref.watch(shoesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ブランド管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'ブランドを追加',
            onPressed: () => _addBrand(context, ref),
          ),
        ],
      ),
      body: brandsAsync.when(
        data: (brands) {
          final shoeCounts = shoesAsync.maybeWhen(
            data: (shoes) {
              final counts = <int, int>{};
              for (final shoe in shoes) {
                counts.update(shoe.brandId, (c) => c + 1, ifAbsent: () => 1);
              }
              return counts;
            },
            orElse: () => <int, int>{},
          );

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  'スニーカーが登録されているブランドは削除できません',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: brands.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final brand = brands[index];
                    final count = shoeCounts[brand.id] ?? 0;
                    return _BrandTile(brand: brand, shoeCount: count);
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('読み込みに失敗しました')),
      ),
    );
  }
}

class _BrandTile extends ConsumerWidget {
  final Brand brand;
  final int shoeCount;

  const _BrandTile({required this.brand, required this.shoeCount});

  Future<void> _deleteBrand(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ブランドを削除しますか？'),
        content: Text('「${brand.name}」を削除します。\nこの操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final deleted = await ref.read(brandRepositoryProvider).deleteBrand(brand.id!);
    ref.invalidate(brandsProvider);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            deleted
                ? '${brand.name} を削除しました'
                : '${brand.name} にはスニーカーが登録されているため削除できません',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(brand.name),
      trailing: shoeCount > 0
          ? Text(
              '$shoeCount足',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            )
          : IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: '削除',
              onPressed: () => _deleteBrand(context, ref),
            ),
    );
  }
}

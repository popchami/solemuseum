import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shoe.dart';
import '../providers/brand_provider.dart';
import '../providers/photo_provider.dart';
import '../providers/shoe_provider.dart';

class TopFiveEditScreen extends ConsumerStatefulWidget {
  const TopFiveEditScreen({super.key});

  @override
  ConsumerState<TopFiveEditScreen> createState() => _TopFiveEditScreenState();
}

class _TopFiveEditScreenState extends ConsumerState<TopFiveEditScreen> {
  late List<Shoe> _items;
  bool _initialized = false;
  bool _saving = false;

  void _initItems(List<Shoe> shoes) {
    if (_initialized) return;
    _items = shoes.where((s) => s.topOrder != null).toList()
      ..sort((a, b) => a.topOrder!.compareTo(b.topOrder!));
    _initialized = true;
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    await ref
        .read(shoeRepositoryProvider)
        .reorderTopFive(_items.map((s) => s.id!).toList());
    ref.invalidate(shoesProvider);
    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final shoesAsync = ref.watch(shoesProvider);
    final brandsAsync = ref.watch(brandsProvider);

    return shoesAsync.when(
      data: (shoes) {
        _initItems(shoes);
        final brandNames = brandsAsync.maybeWhen(
          data: (brands) => {
            for (final b in brands) if (b.id != null) b.id!: b.name,
          },
          orElse: () => <int, String>{},
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('TOP 5 を並び替え'),
            actions: [
              _saving
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : TextButton(
                      onPressed: _save,
                      child: const Text('保存'),
                    ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Text(
                  'ドラッグして順番を変更できます。1位は「注目の展示」に表示されます。',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ),
              Expanded(
                child: ReorderableListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: _items.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) newIndex--;
                      final item = _items.removeAt(oldIndex);
                      _items.insert(newIndex, item);
                    });
                  },
                  itemBuilder: (context, index) {
                    final shoe = _items[index];
                    return _TopFiveEditTile(
                      key: ValueKey(shoe.id),
                      rank: index + 1,
                      shoe: shoe,
                      brandName: brandNames[shoe.brandId] ?? 'Unknown',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const Scaffold(
        body: Center(child: Text('読み込みに失敗しました')),
      ),
    );
  }
}

class _TopFiveEditTile extends ConsumerWidget {
  final int rank;
  final Shoe shoe;
  final String brandName;

  const _TopFiveEditTile({
    super.key,
    required this.rank,
    required this.shoe,
    required this.brandName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainPhotoAsync = ref.watch(mainPhotoProvider(shoe.id!));
    final imagePath = mainPhotoAsync.maybeWhen(
      data: (photo) => photo?.filePath,
      orElse: () => null,
    );

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: rank <= 3
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Text(
              '$rank',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: rank <= 3
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              width: 44,
              height: 44,
              child: imagePath != null
                  ? Image.file(File(imagePath), fit: BoxFit.cover)
                  : ColoredBox(
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.image_outlined, size: 20),
                    ),
            ),
          ),
        ],
      ),
      title: Text(shoe.modelName, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(brandName),
      trailing: const Icon(Icons.drag_handle),
    );
  }
}

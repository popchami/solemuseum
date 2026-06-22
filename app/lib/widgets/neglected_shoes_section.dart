import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shoe.dart';
import '../providers/wear_log_provider.dart';
import '../screens/shoe_detail_screen.dart';

class NeglectedShoesSection extends ConsumerWidget {
  final List<Shoe> shoes;
  final Map<int, String> brandNames;

  const NeglectedShoesSection({
    super.key,
    required this.shoes,
    required this.brandNames,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allLogsAsync = ref.watch(allWearLogsProvider);

    return allLogsAsync.maybeWhen(
      data: (logs) {
        final now = DateTime.now();

        final latestWear = <int, DateTime>{};
        for (final log in logs) {
          final current = latestWear[log.shoeId];
          if (current == null || log.wornDate.isAfter(current)) {
            latestWear[log.shoeId] = log.wornDate;
          }
        }

        final items = <_NeglectedItem>[];
        for (final shoe in shoes) {
          final id = shoe.id;
          if (id == null) continue;
          final last = latestWear[id];
          if (last == null) {
            final daysSince = now.difference(shoe.createdAt).inDays;
            if (daysSince >= 30) {
              items.add(_NeglectedItem(shoe: shoe, daysSince: daysSince, neverWorn: true));
            }
          } else {
            final daysSince = now.difference(last).inDays;
            if (daysSince >= 30) {
              items.add(_NeglectedItem(shoe: shoe, daysSince: daysSince, neverWorn: false));
            }
          }
        }

        if (items.isEmpty) return const SizedBox.shrink();

        items.sort((a, b) => b.daysSince.compareTo(a.daysSince));
        final displayItems = items.take(5).toList();
        final remaining = items.length > 5 ? items.length - 5 : 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text('そろそろ履きたい', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...displayItems.map((item) {
              final brandName = brandNames[item.shoe.brandId] ?? 'Unknown';
              final badge = item.neverWorn ? '未着用' : '${item.daysSince}日着用なし';
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.hourglass_bottom_outlined,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                title: Text(
                  item.shoe.modelName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  brandName,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: _BadgeChip(label: badge, neverWorn: item.neverWorn),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ShoeDetailScreen(shoeId: item.shoe.id!),
                  ),
                ),
              );
            }),
            if (remaining > 0)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'ほか $remaining足',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                ),
              ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final String label;
  final bool neverWorn;

  const _BadgeChip({required this.label, required this.neverWorn});

  @override
  Widget build(BuildContext context) {
    final bg = neverWorn
        ? Theme.of(context).colorScheme.surfaceContainerHighest
        : Theme.of(context).colorScheme.tertiaryContainer;
    final fg = neverWorn
        ? Theme.of(context).colorScheme.onSurfaceVariant
        : Theme.of(context).colorScheme.onTertiaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg),
      ),
    );
  }
}

class _NeglectedItem {
  final Shoe shoe;
  final int daysSince;
  final bool neverWorn;

  const _NeglectedItem({
    required this.shoe,
    required this.daysSince,
    required this.neverWorn,
  });
}

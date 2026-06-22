import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shoe.dart';
import '../models/wear_log.dart';
import '../providers/brand_provider.dart';
import '../providers/shoe_provider.dart';
import '../providers/wear_log_provider.dart';
import 'shoe_detail_screen.dart';

class WearStatsScreen extends ConsumerWidget {
  const WearStatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(allWearLogsProvider);
    final shoesAsync = ref.watch(shoesProvider);
    final brandsAsync = ref.watch(brandsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('着用統計')),
      body: logsAsync.when(
        data: (logs) => shoesAsync.when(
          data: (shoes) => brandsAsync.when(
            data: (brands) => _StatsContent(logs: logs, shoes: shoes, brands: {
              for (final b in brands) if (b.id != null) b.id!: b.name,
            }),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => _StatsContent(logs: logs, shoes: shoes, brands: {}),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const Center(child: Text('読み込みに失敗しました')),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('読み込みに失敗しました')),
      ),
    );
  }
}

class _StatsContent extends StatelessWidget {
  final List<WearLog> logs;
  final List<Shoe> shoes;
  final Map<int, String> brands;

  const _StatsContent({
    required this.logs,
    required this.shoes,
    required this.brands,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final thisMonthCount = logs
        .where((l) => l.wornDate.year == now.year && l.wornDate.month == now.month)
        .length;
    final thisYearCount = logs.where((l) => l.wornDate.year == now.year).length;

    final monthlyData = _buildMonthlyData(now);
    final ranking = _buildRanking();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _SummaryRow(
          total: logs.length,
          thisMonth: thisMonthCount,
          thisYear: thisYearCount,
        ),
        const SizedBox(height: 28),
        Text('着用カレンダー', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _WearCalendarSection(logs: logs, shoes: shoes, brands: brands),
        const SizedBox(height: 28),
        Text('月別着用回数', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        _MonthlyChart(data: monthlyData),
        const SizedBox(height: 28),
        Text('着用回数ランキング', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        if (ranking.isEmpty)
          const _EmptyHint(message: '着用履歴がありません')
        else
          _RankingList(ranking: ranking, brands: brands),
      ],
    );
  }

  List<_MonthData> _buildMonthlyData(DateTime now) {
    final result = <_MonthData>[];
    for (int i = 5; i >= 0; i--) {
      final date = DateTime(now.year, now.month - i, 1);
      final count = logs
          .where((l) => l.wornDate.year == date.year && l.wornDate.month == date.month)
          .length;
      result.add(_MonthData(year: date.year, month: date.month, count: count));
    }
    return result;
  }

  List<_ShoeRank> _buildRanking() {
    final counts = <int, int>{};
    for (final log in logs) {
      counts.update(log.shoeId, (c) => c + 1, ifAbsent: () => 1);
    }
    final ranked = counts.entries
        .map((e) {
          final shoe = shoes.where((s) => s.id == e.key).firstOrNull;
          if (shoe == null) return null;
          return _ShoeRank(shoe: shoe, count: e.value);
        })
        .whereType<_ShoeRank>()
        .toList()
      ..sort((a, b) => b.count.compareTo(a.count));
    return ranked.take(10).toList();
  }
}

class _SummaryRow extends StatelessWidget {
  final int total;
  final int thisMonth;
  final int thisYear;

  const _SummaryRow({
    required this.total,
    required this.thisMonth,
    required this.thisYear,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _SummaryCard(label: '総着用回数', value: total, unit: '回')),
        const SizedBox(width: 8),
        Expanded(child: _SummaryCard(label: '今月', value: thisMonth, unit: '回')),
        const SizedBox(width: 8),
        Expanded(child: _SummaryCard(label: '今年', value: thisYear, unit: '回')),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final int value;
  final String unit;

  const _SummaryCard({required this.label, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Text(
              '$value$unit',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthlyChart extends StatelessWidget {
  final List<_MonthData> data;

  const _MonthlyChart({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.every((d) => d.count == 0)) {
      return const _EmptyHint(message: '着用履歴がありません');
    }
    final maxCount = data.map((d) => d.count).reduce((a, b) => a > b ? a : b);

    return Column(
      children: data.map((item) {
        final ratio = maxCount == 0 ? 0.0 : item.count / maxCount;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  '${item.month}月',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: ratio,
                    minHeight: 22,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
              SizedBox(
                width: 36,
                child: Text(
                  '${item.count}',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _RankingList extends StatelessWidget {
  final List<_ShoeRank> ranking;
  final Map<int, String> brands;

  const _RankingList({required this.ranking, required this.brands});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(ranking.length, (index) {
        final item = ranking[index];
        final rank = index + 1;
        final isTopThree = rank <= 3;
        final brandName = brands[item.shoe.brandId] ?? 'Unknown';

        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundColor: isTopThree
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Text(
              '$rank',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isTopThree
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          title: Text(item.shoe.modelName, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text(brandName, style: Theme.of(context).textTheme.bodySmall),
          trailing: Text(
            '${item.count}回',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ShoeDetailScreen(shoeId: item.shoe.id!)),
          ),
        );
      }),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  final String message;

  const _EmptyHint({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
      ),
    );
  }
}

class _MonthData {
  final int year;
  final int month;
  final int count;

  const _MonthData({required this.year, required this.month, required this.count});
}

class _ShoeRank {
  final Shoe shoe;
  final int count;

  const _ShoeRank({required this.shoe, required this.count});
}

// ─── Calendar ────────────────────────────────────────────────────────────────

class _WearCalendarSection extends StatefulWidget {
  final List<WearLog> logs;
  final List<Shoe> shoes;
  final Map<int, String> brands;

  const _WearCalendarSection({
    required this.logs,
    required this.shoes,
    required this.brands,
  });

  @override
  State<_WearCalendarSection> createState() => _WearCalendarSectionState();
}

class _WearCalendarSectionState extends State<_WearCalendarSection> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month);
  }

  bool get _canGoNext {
    final now = DateTime.now();
    return _month.year < now.year ||
        (_month.year == now.year && _month.month < now.month);
  }

  Map<String, List<WearLog>> get _logsByDate {
    final map = <String, List<WearLog>>{};
    for (final log in widget.logs) {
      final key = _dateKey(log.wornDate);
      map.putIfAbsent(key, () => []).add(log);
    }
    return map;
  }

  static String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _showDayDetail(DateTime date, List<WearLog> logs) {
    final mm = date.month.toString().padLeft(2, '0');
    final dd = date.day.toString().padLeft(2, '0');
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Text(
                '${date.year}/$mm/$dd の着用',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            ...logs.map((log) {
              final shoe = widget.shoes.where((s) => s.id == log.shoeId).firstOrNull;
              final brandName = shoe == null ? '' : (widget.brands[shoe.brandId] ?? '');
              return ListTile(
                leading: const Icon(Icons.directions_walk_outlined),
                title: Text(shoe?.modelName ?? 'Unknown'),
                subtitle: Text(brandName),
                trailing: log.memo != null
                    ? const Icon(Icons.notes_outlined, size: 18)
                    : null,
                onTap: shoe == null
                    ? null
                    : () {
                        Navigator.of(ctx).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ShoeDetailScreen(shoeId: shoe.id!),
                          ),
                        );
                      },
              );
            }),
            if (logs.any((l) => l.memo != null))
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: logs
                      .where((l) => l.memo != null)
                      .map((l) => Text(
                            '📝 ${l.memo}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ))
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logsByDate = _logsByDate;
    final daysInMonth = DateTime(_month.year, _month.month + 1, 0).day;
    // weekday: 1=Mon … 7=Sun; grid starts Monday → leading blanks = weekday-1
    final leadingBlanks = DateTime(_month.year, _month.month, 1).weekday - 1;
    final now = DateTime.now();

    final headerStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.outline,
        );

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  visualDensity: VisualDensity.compact,
                  onPressed: () => setState(
                    () => _month = DateTime(_month.year, _month.month - 1),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${_month.year}年${_month.month}月',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  visualDensity: VisualDensity.compact,
                  onPressed: _canGoNext
                      ? () => setState(
                            () => _month = DateTime(_month.year, _month.month + 1),
                          )
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: ['月', '火', '水', '木', '金', '土', '日']
                  .map((d) => Expanded(
                        child: Text(d, textAlign: TextAlign.center, style: headerStyle),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 4),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: leadingBlanks + daysInMonth,
              itemBuilder: (context, index) {
                if (index < leadingBlanks) return const SizedBox();
                final day = index - leadingBlanks + 1;
                final date = DateTime(_month.year, _month.month, day);
                final key = _dateKey(date);
                final dayLogs = logsByDate[key] ?? [];
                final hasLog = dayLogs.isNotEmpty;
                final isToday = date.year == now.year &&
                    date.month == now.month &&
                    date.day == now.day;
                final isFuture = date.isAfter(now);

                return GestureDetector(
                  onTap: hasLog ? () => _showDayDetail(date, dayLogs) : null,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasLog
                          ? Theme.of(context).colorScheme.primary
                          : isToday
                              ? Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                              : null,
                      border: isToday && !hasLog
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 1.5,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: hasLog
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : isFuture
                                      ? Theme.of(context).colorScheme.outline
                                      : null,
                              fontWeight:
                                  isToday ? FontWeight.bold : null,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

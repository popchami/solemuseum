import 'package:flutter/material.dart';

import '../search.dart';

class SearchDemoScreen extends StatefulWidget {
  const SearchDemoScreen({super.key});

  @override
  State<SearchDemoScreen> createState() => _SearchDemoScreenState();
}

class _SearchDemoScreenState extends State<SearchDemoScreen> {
  SneakerMasterSelection? _selection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'ブランド・モデル検索',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Nike → A / 95 / P6000、Air Jordan → AJ1、New Balance → 990 などを確認できます。',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          SneakerMasterPicker(
            onChanged: (selection) {
              setState(() => _selection = selection);
            },
          ),
          const SizedBox(height: 24),
          _SelectionPreview(selection: _selection),
        ],
      ),
    );
  }
}

class _SelectionPreview extends StatelessWidget {
  const _SelectionPreview({required this.selection});

  final SneakerMasterSelection? selection;

  @override
  Widget build(BuildContext context) {
    final selection = this.selection;

    if (selection == null) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('まだ選択されていません。'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '選択結果',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _PreviewRow(label: 'brandId', value: selection.brandId ?? '自由入力'),
            _PreviewRow(label: 'brandName', value: selection.brandName),
            _PreviewRow(label: 'modelId', value: selection.modelId ?? '自由入力'),
            _PreviewRow(label: 'modelName', value: selection.modelName),
            _PreviewRow(label: 'isMasterModel', value: selection.isMasterModel.toString()),
          ],
        ),
      ),
    );
  }
}

class _PreviewRow extends StatelessWidget {
  const _PreviewRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

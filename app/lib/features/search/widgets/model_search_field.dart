import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search.dart';

class ModelSearchField extends ConsumerStatefulWidget {
  const ModelSearchField({
    super.key,
    required this.brandId,
    required this.onSelected,
    this.onTextChanged,
    this.initialText,
  });

  final String? brandId;
  final ValueChanged<ModelSuggestion> onSelected;
  final ValueChanged<String>? onTextChanged;
  final String? initialText;

  @override
  ConsumerState<ModelSearchField> createState() => _ModelSearchFieldState();
}

class _ModelSearchFieldState extends ConsumerState<ModelSearchField> {
  late final TextEditingController _controller;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText ?? '');
    _query = widget.initialText ?? '';
  }

  @override
  void didUpdateWidget(covariant ModelSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.brandId != widget.brandId) {
      _controller.clear();
      setState(() => _query = '');
      widget.onTextChanged?.call('');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brandId = widget.brandId;
    final serviceAsync = ref.watch(searchServiceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          enabled: brandId != null,
          decoration: const InputDecoration(
            labelText: 'モデル',
            hintText: 'A / AJ / 95 / 550 など',
            border: OutlineInputBorder(),
          ),
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            setState(() => _query = value);
            widget.onTextChanged?.call(value);
          },
        ),
        const SizedBox(height: 8),
        if (brandId == null)
          const _SearchHint(text: '先にブランドを選択してください。')
        else
          serviceAsync.when(
            data: (service) {
              final suggestions = service.suggestModels(
                brandId: brandId,
                query: _query,
              );
              if (suggestions.isEmpty) {
                return const _SearchHint(text: '候補がありません。自由入力できます。');
              }
              return _SuggestionList(
                children: suggestions.map((suggestion) {
                  return ListTile(
                    dense: true,
                    title: Text(suggestion.canonicalName),
                    subtitle: Text(_subtitleFor(suggestion)),
                    onTap: () {
                      _controller.text = suggestion.canonicalName;
                      setState(() => _query = suggestion.canonicalName);
                      widget.onTextChanged?.call(suggestion.canonicalName);
                      widget.onSelected(suggestion);
                      FocusScope.of(context).nextFocus();
                    },
                  );
                }).toList(),
              );
            },
            loading: () => const _SearchHint(text: 'モデル候補を読み込み中...'),
            error: (_, __) => const _SearchHint(text: 'モデル候補を読み込めませんでした'),
          ),
      ],
    );
  }

  String _subtitleFor(ModelSuggestion suggestion) {
    if (suggestion.matchedBy == 'alias') {
      return 'Alias: ${suggestion.matchedText}';
    }
    if (suggestion.matchedBy == 'searchKeyword') {
      return 'Keyword: ${suggestion.matchedText}';
    }
    return suggestion.model.category;
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(children: children),
    );
  }
}

class _SearchHint extends StatelessWidget {
  const _SearchHint({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

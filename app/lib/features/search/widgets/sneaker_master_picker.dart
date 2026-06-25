import 'package:flutter/material.dart';

import '../search.dart';
import 'brand_search_field.dart';
import 'model_search_field.dart';

class SneakerMasterSelection {
  const SneakerMasterSelection({
    required this.brandId,
    required this.brandName,
    required this.modelId,
    required this.modelName,
    required this.isMasterModel,
  });

  final String? brandId;
  final String brandName;
  final String? modelId;
  final String modelName;
  final bool isMasterModel;
}

class SneakerMasterPicker extends StatefulWidget {
  const SneakerMasterPicker({
    super.key,
    required this.onChanged,
    this.initialBrandName,
    this.initialModelName,
  });

  final ValueChanged<SneakerMasterSelection> onChanged;
  final String? initialBrandName;
  final String? initialModelName;

  @override
  State<SneakerMasterPicker> createState() => _SneakerMasterPickerState();
}

class _SneakerMasterPickerState extends State<SneakerMasterPicker> {
  BrandMaster? _selectedBrand;
  ModelSuggestion? _selectedModel;

  String get _brandName => _selectedBrand?.brandName ?? widget.initialBrandName ?? '';
  String get _modelName => _selectedModel?.canonicalName ?? widget.initialModelName ?? '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandSearchField(
          initialText: widget.initialBrandName,
          onSelected: (brand) {
            setState(() {
              _selectedBrand = brand;
              _selectedModel = null;
            });
            _emit();
          },
        ),
        const SizedBox(height: 16),
        ModelSearchField(
          key: ValueKey(_selectedBrand?.brandId),
          brandId: _selectedBrand?.brandId,
          initialText: widget.initialModelName,
          onSelected: (suggestion) {
            setState(() => _selectedModel = suggestion);
            _emit();
          },
        ),
      ],
    );
  }

  void _emit() {
    widget.onChanged(
      SneakerMasterSelection(
        brandId: _selectedBrand?.brandId,
        brandName: _brandName,
        modelId: _selectedModel?.model.id,
        modelName: _modelName,
        isMasterModel: _selectedModel != null,
      ),
    );
  }
}

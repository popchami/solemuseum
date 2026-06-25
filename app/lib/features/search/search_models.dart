class BrandMaster {
  const BrandMaster({
    required this.brandId,
    required this.brandName,
    required this.tier,
    required this.isEnabled,
  });

  final String brandId;
  final String brandName;
  final String tier;
  final bool isEnabled;

  factory BrandMaster.fromJson(Map<String, dynamic> json) {
    return BrandMaster(
      brandId: json['brandId'] as String,
      brandName: json['brandName'] as String,
      tier: json['tier'] as String,
      isEnabled: json['isEnabled'] as bool,
    );
  }
}

class SneakerModelMaster {
  const SneakerModelMaster({
    required this.id,
    required this.brandId,
    required this.modelName,
    required this.category,
    required this.source,
  });

  final String id;
  final String brandId;
  final String modelName;
  final String category;
  final String source;

  factory SneakerModelMaster.fromJson(Map<String, dynamic> json) {
    return SneakerModelMaster(
      id: json['id'] as String,
      brandId: json['brandId'] as String,
      modelName: json['modelName'] as String,
      category: json['category'] as String,
      source: json['source'] as String,
    );
  }
}

class ModelAliasMaster {
  const ModelAliasMaster({
    required this.modelId,
    required this.alias,
  });

  final String modelId;
  final String alias;

  factory ModelAliasMaster.fromJson(Map<String, dynamic> json) {
    return ModelAliasMaster(
      modelId: json['modelId'] as String,
      alias: json['alias'] as String,
    );
  }
}

class SearchKeywordMaster {
  const SearchKeywordMaster({
    required this.modelId,
    required this.keyword,
  });

  final String modelId;
  final String keyword;

  factory SearchKeywordMaster.fromJson(Map<String, dynamic> json) {
    return SearchKeywordMaster(
      modelId: json['modelId'] as String,
      keyword: json['keyword'] as String,
    );
  }
}

class ModelSuggestion {
  const ModelSuggestion({
    required this.model,
    required this.matchedBy,
    required this.matchedText,
  });

  final SneakerModelMaster model;
  final String matchedBy;
  final String matchedText;

  String get canonicalName => model.modelName;
}

class BrandSuggestion {
  const BrandSuggestion({
    required this.brand,
    required this.matchedText,
  });

  final BrandMaster brand;
  final String matchedText;
}

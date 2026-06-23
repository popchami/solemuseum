import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/brand.dart';
import '../models/shoe.dart';
import '../providers/brand_provider.dart';
import '../providers/collection_filter_provider.dart';
import '../providers/photo_provider.dart';
import '../providers/shoe_provider.dart';
import '../widgets/empty_state.dart';
import '../widgets/shoe_card.dart';
import 'shoe_detail_screen.dart';
import 'shoe_form_screen.dart';

class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({super.key});

  @override
  ConsumerState<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen> {
  final _searchController = TextEditingController();
  String _searchText = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shoesAsync = ref.watch(shoesProvider);
    final brandsAsync = ref.watch(brandsProvider);
    final collectionFilter = ref.watch(collectionFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('コレクション'),
      ),
      body: shoesAsync.when(
        data: (shoes) {
          if (shoes.isEmpty) {
            return EmptyState(
              icon: Icons.collections_outlined,
              title: 'あなたのミュージアムは空です',
              description: '最初の1足を登録しましょう',
              actionLabel: '最初のスニーカーを登録',
              onAction: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ShoeFormScreen(),
                  ),
                );
              },
            );
          }

          return brandsAsync.when(
            data: (brands) => _CollectionContent(
              shoes: shoes,
              brands: brands,
              selectedBrandId: collectionFilter.brandId,
              favoritesOnly: collectionFilter.favoritesOnly,
              searchText: _searchText,
              searchController: _searchController,
              onSearchChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              onBrandSelected: (brandId) {
                ref.read(collectionFilterProvider.notifier).state =
                    CollectionFilter(brandId: brandId);
              },
              onFavoritesSelected: (selected) {
                ref.read(collectionFilterProvider.notifier).state =
                    CollectionFilter(favoritesOnly: selected);
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (_, __) => _CollectionContent(
              shoes: shoes,
              brands: const [],
              selectedBrandId: collectionFilter.brandId,
              favoritesOnly: collectionFilter.favoritesOnly,
              searchText: _searchText,
              searchController: _searchController,
              onSearchChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              onBrandSelected: (brandId) {
                ref.read(collectionFilterProvider.notifier).state =
                    CollectionFilter(brandId: brandId);
              },
              onFavoritesSelected: (selected) {
                ref.read(collectionFilterProvider.notifier).state =
                    CollectionFilter(favoritesOnly: selected);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('読み込みに失敗しました')),
      ),
    );
  }
}

class _CollectionContent extends StatelessWidget {
  final List<Shoe> shoes;
  final List<Brand> brands;
  final int? selectedBrandId;
  final bool favoritesOnly;
  final String searchText;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<int?> onBrandSelected;
  final ValueChanged<bool> onFavoritesSelected;

  const _CollectionContent({
    required this.shoes,
    required this.brands,
    required this.selectedBrandId,
    required this.favoritesOnly,
    required this.searchText,
    required this.searchController,
    required this.onSearchChanged,
    required this.onBrandSelected,
    required this.onFavoritesSelected,
  });

  @override
  Widget build(BuildContext context) {
    final brandNames = {
      for (final brand in brands)
        if (brand.id != null) brand.id!: brand.name,
    };
    final filteredShoes = _filterShoes(brandNames);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'モデル名で検索',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchText.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        searchController.clear();
                        onSearchChanged('');
                      },
                    ),
            ),
            onChanged: onSearchChanged,
          ),
        ),
        if (brands.isNotEmpty)
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: const Text('すべて'),
                    selected: selectedBrandId == null && !favoritesOnly,
                    onSelected: (_) => onBrandSelected(null),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    avatar: const Icon(Icons.favorite, size: 18),
                    label: const Text('お気に入り'),
                    selected: favoritesOnly,
                    onSelected: onFavoritesSelected,
                  ),
                ),
                ...brands.map(
                  (brand) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(brand.name),
                      selected: !favoritesOnly && selectedBrandId == brand.id,
                      onSelected: (_) => onBrandSelected(brand.id),
                    ),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: filteredShoes.isEmpty
              ? const EmptyState(
                  icon: Icons.search_off_outlined,
                  title: '該当するスニーカーがありません',
                  description: '検索条件を変更してください',
                )
              : _ShoeGrid(shoes: filteredShoes, brandNames: brandNames),
        ),
      ],
    );
  }

  List<Shoe> _filterShoes(Map<int, String> brandNames) {
    final query = searchText.trim().toLowerCase();

    return shoes.where((shoe) {
      final matchesBrand =
          selectedBrandId == null || shoe.brandId == selectedBrandId;
      final matchesFavorite = !favoritesOnly || shoe.isFavorite;
      final brandName = brandNames[shoe.brandId] ?? '';
      final matchesSearch = query.isEmpty ||
          shoe.modelName.toLowerCase().contains(query) ||
          brandName.toLowerCase().contains(query);

      return matchesBrand && matchesFavorite && matchesSearch;
    }).toList();
  }
}

class _ShoeGrid extends ConsumerStatefulWidget {
  final List<Shoe> shoes;
  final Map<int, String> brandNames;

  const _ShoeGrid({required this.shoes, required this.brandNames});

  @override
  ConsumerState<_ShoeGrid> createState() => _ShoeGridState();
}

class _ShoeGridState extends ConsumerState<_ShoeGrid> {
  static const int _minColumns = 2;
  static const int _maxColumns = 5;

  int _columns = 2;

  void _zoomIn() {
    setState(() {
      _columns = (_columns - 1).clamp(_minColumns, _maxColumns);
    });
  }

  void _zoomOut() {
    setState(() {
      _columns = (_columns + 1).clamp(_minColumns, _maxColumns);
    });
  }

  double get _childAspectRatio {
    switch (_columns) {
      case 2:
        return 0.64;
      case 3:
        return 0.62;
      case 4:
        return 0.58;
      case 5:
        return 0.54;
      default:
        return 0.64;
    }
  }

  double get _gridSpacing {
    switch (_columns) {
      case 2:
        return 12;
      case 3:
        return 10;
      case 4:
        return 8;
      case 5:
        return 6;
      default:
        return 12;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: Row(
            children: [
              Text(
                '${widget.shoes.length}足',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              IconButton(
                tooltip: '大きく表示',
                onPressed: _columns == _minColumns ? null : _zoomIn,
                icon: const Icon(Icons.zoom_in),
              ),
              Text('$_columns列'),
              IconButton(
                tooltip: '一覧を広く表示',
                onPressed: _columns == _maxColumns ? null : _zoomOut,
                icon: const Icon(Icons.zoom_out),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _columns,
              childAspectRatio: _childAspectRatio,
              mainAxisSpacing: _gridSpacing,
              crossAxisSpacing: _gridSpacing,
            ),
            itemCount: widget.shoes.length,
            itemBuilder: (context, index) {
              final shoe = widget.shoes[index];
              final mainPhotoAsync = ref.watch(mainPhotoProvider(shoe.id!));
              final imagePath = mainPhotoAsync.maybeWhen(
                data: (photo) => photo?.filePath,
                orElse: () => null,
              );

              return ShoeCard(
                brandName: widget.brandNames[shoe.brandId] ?? 'Unknown',
                modelName: shoe.modelName,
                size: shoe.size ?? '-',
                color: shoe.color ?? '',
                imagePath: imagePath,
                isFavorite: shoe.isFavorite,
                archiveNumber: shoe.archiveNumber,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ShoeDetailScreen(shoeId: shoe.id!),
                    ),
                  );
                },
                onFavoriteTap: () async {
                  await ref.read(shoeRepositoryProvider).toggleFavorite(
                        shoe.id!,
                        !shoe.isFavorite,
                      );
                  ref.invalidate(shoesProvider);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:async';
import 'baitap6_detail_screen.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String thumbnail;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      stock: (json['stock'] ?? 0),
      thumbnail: json['thumbnail'] ?? '',
      description: json['description'] ?? '',
    );
  }

  double get originalPrice => price / (1 - (discountPercentage / 100));
}

class Baitap6Screen extends StatefulWidget {
  const Baitap6Screen({super.key});

  @override
  State<Baitap6Screen> createState() => _Baitap6ScreenState();
}

class _Baitap6ScreenState extends State<Baitap6Screen> {
  final Dio _dio = Dio();
  List<Product> _products = [];
  bool _isLoading = true;
  String? _error;
  Timer? _debounce;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchProducts({String query = ''}) async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      String url = 'https://dummyjson.com/products';
      if (query.isNotEmpty) {
        url = 'https://dummyjson.com/products/search?q=$query';
      }

      final response = await _dio.get(url, queryParameters: {'limit': 20});

      if (response.statusCode == 200) {
        final data = response.data;
        final productsJson = data['products'] as List;
        setState(() {
          _products = productsJson.map((e) => Product.fromJson(e)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchProducts(query: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      drawer: const AppDrawer(activeIndex: 6),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 60,
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const Text(
                          "Khám phá\nBST Thời Thượng",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                            color: Colors.black,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Search
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                            decoration: const InputDecoration(
                              hintText: 'Tìm kiếm bộ sưu tập...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: Icon(
                                Iconsax.search_normal,
                                color: Colors.black87,
                                size: 20,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Categories / Filter Chips (Mock)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: Row(
                            children: [
                              _buildCategoryChip("Tất cả", true),
                              _buildCategoryChip("Thời trang", false),
                              _buildCategoryChip("Giày dép", false),
                              _buildCategoryChip("Phụ kiện", false),
                              _buildCategoryChip("Công nghệ", false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ]),
                    ),
                  ),

                  // Staggered Masonry Layout
                  if (_isLoading)
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                    )
                  else if (_error != null)
                    SliverFillRemaining(
                      child: Center(child: Text('Lỗi: $_error')),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column
                            Expanded(
                              child: Column(
                                children: [
                                  for (int i = 0; i < _products.length; i++)
                                    if (i % 2 == 0)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        child: _buildStaggeredCard(
                                          _products[i],
                                          i,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            // Right Column (Offset)
                            Expanded(
                              child: Column(
                                children: [
                                  const SizedBox(height: 40), // Downward Offset
                                  for (int i = 0; i < _products.length; i++)
                                    if (i % 2 != 0)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 20,
                                        ),
                                        child: _buildStaggeredCard(
                                          _products[i],
                                          i,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
                ],
              ),

              MenuButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.5,
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildStaggeredCard(Product product, int index) {
    // Determine aspect ratio pattern to create visual rhythm
    // 0: Tall (3:4), 1: Square (1:1), 2: Square (1:1), 3: Tall (3:4)
    final bool isTall = index % 4 == 0 || index % 4 == 3;
    final double aspectRatio = isTall ? 3 / 4 : 1.0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Baitap6DetailScreen(product: product),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: aspectRatio,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200], // Placeholder
                      image: DecorationImage(
                        image: NetworkImage(product.thumbnail),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (product.discountPercentage > 0)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // This is fine for the tag
                      ),
                      child: Text(
                        '-${product.discountPercentage.round()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (product.stock < 50)
                        Text(
                          "Sắp hết",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

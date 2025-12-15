import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';

class PlaceItem {
  final String name;
  final String imagePath;

  PlaceItem({required this.name, required this.imagePath});
}

class Baitap2Screen extends StatefulWidget {
  const Baitap2Screen({super.key});

  @override
  State<Baitap2Screen> createState() => _Baitap2ScreenState();
}

class _Baitap2ScreenState extends State<Baitap2Screen> {
  final TextEditingController _searchController = TextEditingController();

  // Dữ liệu mẫu với tên và đường dẫn ảnh
  // Lưu ý: Đã thay thế ảnh noel bằng ảnh classroom vì ảnh noel chưa có trong assets
  final List<PlaceItem> _allPlaces = [
    PlaceItem(
      name: 'Bình minh trên núi',
      imagePath: 'assets/images/background1.png',
    ),
    PlaceItem(
      name: 'Hoàng hôn biển cả',
      imagePath: 'assets/images/background2.png',
    ),
    PlaceItem(
      name: 'Rừng thông yên tĩnh',
      imagePath: 'assets/images/background3.png',
    ),
    PlaceItem(
      name: 'Thành phố về đêm',
      imagePath: 'assets/images/background4.png',
    ),
    PlaceItem(
      name: 'Hồ nước trong xanh',
      imagePath: 'assets/images/background5.png',
    ),
    PlaceItem(
      name: 'Cánh đồng hoa',
      imagePath: 'assets/images/background6.png',
    ),
  ];

  List<PlaceItem> _filteredPlaces = [];

  @override
  void initState() {
    super.initState();
    _filteredPlaces = _allPlaces;
  }

  void _runFilter(String enteredKeyword) {
    List<PlaceItem> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allPlaces;
    } else {
      results = _allPlaces
          .where(
            (place) =>
                place.name.toLowerCase().contains(enteredKeyword.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _filteredPlaces = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const AppDrawer(activeIndex: 2),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 60,
                  left: 24.0,
                  right: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    const Text(
                      'Welcome,\nCharlie',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                        color: AppColors.text,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.textMuted.withOpacity(0.3),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => _runFilter(value),
                        decoration: const InputDecoration(
                          hintText: 'Tìm kiếm',
                          hintStyle: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 16,
                          ),
                          prefixIcon: Icon(
                            Iconsax.search_normal,
                            color: AppColors.textMuted,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'Saved Places',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 16), // Add spacing before grid
                    Expanded(
                      child: _filteredPlaces.isEmpty
                          ? const Center(
                              child: Text(
                                'Không tìm thấy',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.only(bottom: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 1.0,
                                  ),
                              itemCount: _filteredPlaces.length,
                              itemBuilder: (context, index) {
                                return _buildPlaceCard(
                                  context,
                                  place: _filteredPlaces[index],
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),

              // Menu Button
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

  Widget _buildPlaceCard(BuildContext context, {required PlaceItem place}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              backgroundColor: AppColors.black,
              appBar: AppBar(
                backgroundColor: AppColors.black,
                iconTheme: const IconThemeData(color: AppColors.white),
                title: Text(
                  place.name,
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
              body: Center(
                child: Hero(
                  tag: place.imagePath,
                  child: InteractiveViewer(child: Image.asset(place.imagePath)),
                ),
              ),
            ),
          ),
        );
      },
      child: Hero(
        tag: place.imagePath,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(place.imagePath),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

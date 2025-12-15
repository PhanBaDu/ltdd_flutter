import 'package:flutter/material.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';
import 'course_card.dart';

class Baitap1Screen extends StatefulWidget {
  const Baitap1Screen({super.key});

  @override
  State<Baitap1Screen> createState() => _Baitap1ScreenState();
}

class _Baitap1ScreenState extends State<Baitap1Screen> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  // Danh sách các lớp học
  static const List<Map<String, dynamic>> _courses = [
    {
      'title': 'Lập trình Di động với Flutter',
      'code': '2025-2026.1.TIN4403.001',
      'students': '58 học viên',
      'imageUrl': 'assets/images/classroom_1.png',
    },
    {
      'title': 'Phát triển Ứng dụng Web',
      'code': '2025-2026.1.TIN4403.002',
      'students': '55 học viên',
      'imageUrl': 'assets/images/classroom_2.png',
    },
    {
      'title': 'Trí tuệ Nhân tạo Cơ bản',
      'code': '2025-2026.1.TIN4503.001',
      'students': '62 học viên',
      'imageUrl': 'assets/images/classroom_1.png',
    },
    {
      'title': 'Cơ sở Dữ liệu Nâng cao',
      'code': '2025-2026.1.TIN4203.001',
      'students': '48 học viên',
      'imageUrl': 'assets/images/classroom_2.png',
    },
    {
      'title': 'Mạng Máy tính và Internet',
      'code': '2025-2026.1.TIN4303.001',
      'students': '53 học viên',
      'imageUrl': 'assets/images/classroom_1.png',
    },
    {
      'title': 'An toàn Thông tin',
      'code': '2025-2026.1.TIN4603.001',
      'students': '45 học viên',
      'imageUrl': 'assets/images/classroom_2.png',
    },
    {
      'title': 'Học Máy và Ứng dụng',
      'code': '2025-2026.1.TIN4503.002',
      'students': '50 học viên',
      'imageUrl': 'assets/images/classroom_1.png',
    },
    {
      'title': 'Kiến trúc Phần mềm',
      'code': '2025-2026.1.TIN4703.001',
      'students': '42 học viên',
      'imageUrl': 'assets/images/classroom_2.png',
    },
    {
      'title': 'Xử lý Ảnh Số',
      'code': '2025-2026.1.TIN4803.001',
      'students': '38 học viên',
      'imageUrl': 'assets/images/classroom_1.png',
    },
    {
      'title': 'Điện toán Đám mây',
      'code': '2025-2026.1.TIN4903.001',
      'students': '56 học viên',
      'imageUrl': 'assets/images/classroom_2.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Hiển thị nút khi scroll quá 1 chiều rộng màn hình
    final screenWidth = MediaQuery.of(context).size.width;
    final shouldShow = _scrollController.offset > screenWidth;

    if (shouldShow != _showScrollToTop) {
      setState(() {
        _showScrollToTop = shouldShow;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const AppDrawer(activeIndex: 1),
      floatingActionButton: _showScrollToTop
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: AppColors.white,
              elevation: 2,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_upward,
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
            )
          : null,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              // Danh sách lớp học
              ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 80,
                  left: 10,
                  right: 10,
                  bottom: 20,
                ),
                itemCount: _courses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final course = _courses[index];
                  return CourseCard(
                    title: course['title'] as String,
                    code: course['code'] as String,
                    studentCount: course['students'] as String,
                    imageUrl: course['imageUrl'] as String,
                  );
                },
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
}

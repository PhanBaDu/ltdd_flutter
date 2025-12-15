import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>
    with SingleTickerProviderStateMixin {
  int _count = 0;
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();
  }

  void _ensureAnimations() {
    if (_controller == null) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
      );
      _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 1.2,
      ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
    }
  }

  void _animateCount() {
    _ensureAnimations();
    _controller!.forward().then((_) => _controller!.reverse());
    HapticFeedback.lightImpact(); // Rung nhẹ kiểu iOS
  }

  void _increment() {
    setState(() => _count++);
    _animateCount();
  }

  void _decrement() {
    setState(() => _count--);
    _animateCount();
  }

  void _reset() {
    setState(() => _count = 0);
    HapticFeedback.mediumImpact();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _ensureAnimations();
    return Stack(
      children: [
        // 1. Hero Number ở giữa
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'COUNTER',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _scaleAnimation!,
                child: Text(
                  '$_count',
                  style: const TextStyle(
                    fontSize: 120,
                    fontWeight: FontWeight.w300, // Mỏng, tinh tế kiểu iOS
                    color: AppColors.primary,
                    height: 1,
                    letterSpacing: -2,
                    fontFamily: '.SF Pro Display', // Font hệ thống
                  ),
                ),
              ),
              const SizedBox(height: 100), // Dành chỗ cho control bar
            ],
          ),
        ),

        // 2. Floating Control Bar ở dưới
        Positioned(
          bottom: 40,
          left: 40,
          right: 40,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSquareBtn(
                  icon: Icons.remove,
                  color: AppColors.destructive,
                  onTap: _decrement,
                  isDestructive: true,
                ),
                _buildResetBtn(),
                _buildSquareBtn(
                  icon: Icons.add,
                  color: AppColors.primary,
                  onTap: _increment,
                  isPrimary: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetBtn() {
    return InkWell(
      onTap: _reset,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.textMuted.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "RESET",
          style: TextStyle(
            color: AppColors.textMuted,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildSquareBtn({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isPrimary = false,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: isPrimary ? color : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: isPrimary ? null : Border.all(color: color, width: 0.5),
          ),
          child: Icon(icon, color: isPrimary ? Colors.white : color, size: 28),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ltdd_flutter/constans/app_colors.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with TickerProviderStateMixin {
  int _seconds = 0;
  int _initialSeconds = 0;
  late AnimationController _animationController;
  final TextEditingController _inputController = TextEditingController();
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed && _isTimerRunning) {
        _isTimerRunning = false;
        _inputController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Đã hoàn thành!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.primary,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  void _startTimer() {
    FocusScope.of(context).unfocus();
    if (_seconds > 0) {
      _initialSeconds = _seconds;
      _animationController.duration = Duration(seconds: _seconds);
      _isTimerRunning = true;
      _animationController.reverse(from: 1.0);
      setState(() {});
    }
  }

  void _resetTimer() {
    _animationController.stop();
    _animationController.value = 1.0;
    setState(() {
      _isTimerRunning = false;
      _seconds = 0;
      _initialSeconds = 0;
      _inputController.clear();
    });
  }

  String _formatTime(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  'Nhập số giây cần đếm:',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _inputController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  hintText: 'Nhập số giây',
                ),
                onChanged: (value) {
                  setState(() {
                    _seconds = int.tryParse(value) ?? 0;
                    if (!_isTimerRunning) {
                      _initialSeconds = _seconds;
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 280,
              height: 280,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      // Removed background CircularProgressIndicator
                      CircularProgressIndicator(
                        value: _isTimerRunning
                            ? _animationController.value
                            : (_initialSeconds > 0 ? 1.0 : 0.0),
                        strokeWidth: 10,
                        color: AppColors.primary,
                        strokeCap: StrokeCap.round,
                      ),
                      Center(
                        child: Text(
                          _isTimerRunning
                              ? _formatTime(
                                  (_animationController.value * _initialSeconds)
                                      .ceil(),
                                )
                              : _formatTime(_seconds),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildButton(
                    label: 'Bắt đầu',
                    onTap: _startTimer,
                    isActive: !_isTimerRunning && _seconds > 0,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildButton(
                    label: 'Đặt lại',
                    onTap: _resetTimer,
                    isActive: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onTap,
    bool isActive = true,
  }) {
    return InkWell(
      onTap: isActive ? onTap : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.primary : Colors.grey[500],
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

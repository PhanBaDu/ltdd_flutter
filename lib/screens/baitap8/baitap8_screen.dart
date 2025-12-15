import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:iconsax/iconsax.dart';
import '../../constans/app_colors.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/menu_button.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? 'https://robohash.org/placeholder.png',
    );
  }

  String get fullName => '$firstName $lastName';
}

class Baitap8Screen extends StatefulWidget {
  const Baitap8Screen({super.key});

  @override
  State<Baitap8Screen> createState() => _Baitap8ScreenState();
}

class _Baitap8ScreenState extends State<Baitap8Screen> {
  final Dio _dio = Dio();
  bool _isLoading = false;
  User? _currentUser;
  String? _accessToken;
  String? _refreshToken;

  final TextEditingController _usernameController = TextEditingController(
    text: 'emilys',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'emilyspass',
  );
  bool _obscurePassword = true;
  bool _rememberMe = false;

  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/login',
        data: {
          'username': _usernameController.text,
          'password': _passwordController.text,
          'expiresInMins': 30,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _accessToken = data['accessToken'] ?? data['token'];
          _refreshToken = data['refreshToken'];
          _currentUser = User.fromJson(data);
        });
        _showSnackBar('Đăng nhập thành công!', Colors.green);
      }
    } catch (e) {
      _showSnackBar('Đăng nhập thất bại: ${e.toString()}', Colors.red);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _refreshTokenFunc() async {
    if (_refreshToken == null) return;
    setState(() => _isLoading = true);
    try {
      final response = await _dio.post(
        'https://dummyjson.com/auth/refresh',
        data: {'refreshToken': _refreshToken, 'expiresInMins': 30},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          _accessToken = data['accessToken'] ?? data['token'];
          _refreshToken = data['refreshToken'];
        });
        _showSnackBar('Đã làm mới Token!', Colors.green);
      }
    } catch (e) {
      _showSnackBar(
        'Làm mới thất bại: Phiên đăng nhập có thể đã hết hạn',
        Colors.red,
      );
      _logout();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _logout() {
    setState(() {
      _accessToken = null;
      _refreshToken = null;
      _currentUser = null;
      _usernameController.text = 'emilys';
      _passwordController.text = 'emilyspass';
    });
    _showSnackBar('Đã đăng xuất', Colors.black54);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLogged = _currentUser != null && _accessToken != null;

    if (isLogged) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        drawer: const AppDrawer(activeIndex: 8),
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                // Gradient Background
                Container(
                  height: size.height * 0.35,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.primary],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 20,
                  ),
                  child: _buildProfileView(),
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

    // Login View
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const AppDrawer(activeIndex: 8),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              // Background Layer
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: size.height * 0.42,
                child: Container(
                  decoration: const BoxDecoration(color: AppColors.primary),
                ),
              ),

              // Foreground Content
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // Header Area
                      Column(
                        children: [
                          const SizedBox(height: 50),
                          // Icon/Logo
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Iconsax.lock_1,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Đăng nhập",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Chào mừng trở lại, chúng tôi rất nhớ bạn",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // Central CardForm with Shadow
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: _buildLoginForm(),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
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

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Username
        const Text(
          "Tên người dùng",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _usernameController,
          decoration: _inputDecoration("Nhập tên người dùng"),
        ),
        const SizedBox(height: 20),

        // Password
        const Text(
          "Mật khẩu",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: _inputDecoration("Nhập mật khẩu").copyWith(
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Iconsax.eye_slash : Iconsax.eye,
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),

        const SizedBox(height: 20),
        Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: _rememberMe,
                activeColor: AppColors.primary,
                side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) => setState(() => _rememberMe = val!),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Ghi nhớ đăng nhập",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const Text(
                "Quên mật khẩu?",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              shadowColor: AppColors.primary.withOpacity(0.4),
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    "Đăng nhập",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Chưa có tài khoản? ",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                _showSnackBar(
                  "Chức năng đăng ký chưa được thực hiện",
                  Colors.black54,
                );
              },
              child: const Text(
                "Đăng ký",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 40),

          // Avatar Card with Gradient Border
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: NetworkImage(_currentUser!.image),
                    onBackgroundImageError: (_, __) {},
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _currentUser!.fullName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.text.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _currentUser!.email,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Action Buttons with improved styling
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _logout,
                    icon: const Icon(Iconsax.logout, size: 20),
                    label: const Text(
                      "Đăng xuất",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFF0F3),
                      foregroundColor: const Color(0xFFFF3B30),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _refreshTokenFunc,
                    icon: const Icon(Iconsax.refresh, size: 20),
                    label: const Text(
                      "Refresh",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      foregroundColor: Colors.black87,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Info Cards Grid
          _buildSingleInfoCard(
            "HỌ VÀ TÊN",
            _currentUser!.fullName,
            Iconsax.user,
          ),
          const SizedBox(height: 14),
          _buildSingleInfoCard("EMAIL", _currentUser!.email, Iconsax.sms),
          const SizedBox(height: 14),
          _buildSingleInfoCard(
            "GIỚI TÍNH",
            _currentUser!.gender,
            Iconsax.profile_2user,
          ),
          const SizedBox(height: 14),
          _buildSingleInfoCard(
            "TÊN ĐĂNG NHẬP",
            _currentUser!.username,
            Iconsax.tag,
          ),
          const SizedBox(height: 14),
          _buildSingleInfoCard(
            "MẬT KHẨU",
            _passwordController.text,
            Iconsax.lock,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSingleInfoCard(String title, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: AppColors.primary),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

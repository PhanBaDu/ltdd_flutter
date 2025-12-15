import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../constans/app_colors.dart';

class BmiWidget extends StatefulWidget {
  const BmiWidget({super.key});

  @override
  State<BmiWidget> createState() => _BmiWidgetState();
}

class _BmiWidgetState extends State<BmiWidget> {
  final _formKey = GlobalKey<FormState>();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  double? _bmi;
  String _message = '';

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      double height = double.parse(_heightController.text) / 100;
      double weight = double.parse(_weightController.text);

      setState(() {
        _bmi = weight / (height * height);

        if (_bmi! < 18.5) {
          _message = 'Underweight';
        } else if (_bmi! < 24.9) {
          _message = 'Normal';
        } else if (_bmi! < 29.9) {
          _message = 'Overweight';
        } else {
          _message = 'Obese';
        }
      });
    }
  }

  Color _getResultColor() {
    if (_bmi == null) return CupertinoColors.systemGrey;
    if (_bmi! < 18.5) return CupertinoColors.activeOrange;
    if (_bmi! < 24.9) return CupertinoColors.activeGreen;
    return CupertinoColors.destructiveRed;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "BMI Calculator",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                  color: Colors.black,
                  fontFamily: '.SF Pro Display', // San Francisco hint
                ),
              ),

              const SizedBox(height: 30),

              // iOS Styled Inputs
              _buildIOSInput(
                controller: _heightController,
                placeholder: "Height (cm)",
                icon: Iconsax.ruler,
              ),
              const SizedBox(height: 16),
              _buildIOSInput(
                controller: _weightController,
                placeholder: "Weight (kg)",
                icon: Iconsax.weight,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: AppColors.primary,
                  onPressed: _calculateBMI,
                  borderRadius: BorderRadius.circular(12),
                  child: const Text(
                    "Calculate",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              if (_bmi != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "BMI",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.secondaryLabel,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _bmi!.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: _getResultColor(),
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _message,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: _getResultColor(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIOSInput({
    required TextEditingController controller,
    required String placeholder,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(fontSize: 17),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: CupertinoColors.placeholderText),
        filled: true,
        fillColor: CupertinoColors.systemGrey6,
        prefixIcon: Icon(icon, color: CupertinoColors.systemGrey, size: 22),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Required';
        if (double.tryParse(value) == null) return 'Invalid';
        return null;
      },
    );
  }
}

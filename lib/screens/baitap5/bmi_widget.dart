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

  // For nice UI selection
  String _selectedGender = 'Male';
  int _age = 25;

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
          _message = 'Normal - Good job!';
        } else if (_bmi! < 29.9) {
          _message = 'Overweight';
        } else {
          _message = 'Obese';
        }
      });
    }
  }

  Color _getResultColor() {
    if (_bmi == null) return Colors.grey;
    if (_bmi! < 18.5) return Colors.orange;
    if (_bmi! < 24.9) return Colors.green;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(Iconsax.health5, size: 48, color: Colors.white),
                    const SizedBox(height: 16),
                    const Text(
                      "BMI Calculator",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Check your body mass index",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Gender Selector Row
              Row(
                children: [
                  Expanded(
                    child: _buildGenderCard(
                      "Male",
                      Iconsax.man,
                      _selectedGender == 'Male',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildGenderCard(
                      "Female",
                      Iconsax.woman,
                      _selectedGender == 'Female',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Inputs in a clean card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildModernInput(
                      controller: _heightController,
                      label: "Height",
                      suffix: "cm",
                      icon: Iconsax.ruler,
                    ),
                    const SizedBox(height: 20),
                    _buildModernInput(
                      controller: _weightController,
                      label: "Weight",
                      suffix: "kg",
                      icon: Iconsax.weight,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Calculate Button
              ElevatedButton(
                onPressed: _calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: AppColors.primary.withOpacity(0.4),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Iconsax.calculator),
                    SizedBox(width: 10),
                    Text(
                      "Calculate Now",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Result Section with Animation
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _bmi != null ? 1.0 : 0.0,
                child: _bmi != null
                    ? Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: _getResultColor().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: _getResultColor().withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Your BMI",
                              style: TextStyle(
                                fontSize: 14,
                                color: _getResultColor(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _bmi!.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                color: _getResultColor(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _getResultColor(),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderCard(String gender, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Colors.white : Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              gender,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernInput({
    required TextEditingController controller,
    required String label,
    required String suffix,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          suffixText: suffix,
          icon: Icon(icon, color: Colors.grey[400]),
          labelStyle: TextStyle(color: Colors.grey[500]),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          if (double.tryParse(value) == null) return 'Invalid';
          return null;
        },
      ),
    );
  }
}

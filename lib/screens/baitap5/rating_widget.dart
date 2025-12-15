import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../constans/app_colors.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({super.key});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 0;
  final _nameController = TextEditingController();
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _sendFeedback() {
    if (_formKey.currentState!.validate() && _rating > 0) {
      // iOS Style Dialog/Alert or SnackBar
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text("Thank You"),
          content: const Text("We appreciate your feedback!"),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
      );
    } else if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a star rating first.'),
          backgroundColor: CupertinoColors.destructiveRed,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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
                "Feedback",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                  color: Colors.black,
                  fontFamily: '.SF Pro Display',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "How was your experience?",
                style: TextStyle(
                  fontSize: 17,
                  color: CupertinoColors.secondaryLabel,
                ),
              ),
              const SizedBox(height: 30),

              // Stars (iOS minimalist)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => _rating = index + 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        index < _rating ? Iconsax.star1 : Iconsax.star,
                        color: index < _rating
                            ? CupertinoColors.activeOrange
                            : CupertinoColors.systemGrey4,
                        size: 34,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 30),

              const SizedBox(height: 30),

              // iOS Inputs
              _buildIOSInput(
                controller: _nameController,
                placeholder: "Your Name",
                icon: Iconsax.user,
              ),
              const SizedBox(height: 16),
              _buildIOSInput(
                controller: _feedbackController,
                placeholder: "Your Feedback",
                icon: Iconsax.edit,
                maxLines: 4,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: AppColors.primary,
                  onPressed: _sendFeedback,
                  borderRadius: BorderRadius.circular(12),
                  child: const Text(
                    "Send Feedback",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
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
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 17),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: CupertinoColors.placeholderText),
        filled: true,
        fillColor: CupertinoColors.systemGrey6,
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: maxLines > 1 ? 60 : 0),
          child: Icon(icon, color: CupertinoColors.systemGrey, size: 22),
        ),
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
        return null;
      },
    );
  }
}

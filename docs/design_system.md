# Design System & Style Guide

## Overview
The application follows a modern, clean design aesthetic using custom widgets and the Iconsax library.

## Core Components

### 1. Navigation Drawer (`AppDrawer`)
- **Structure**: Custom styled Drawer with a gradient header and list items.
- **Header**:
  - Gradient Background: `LinearGradient(colors: [Colors.blue.shade400, Colors.blue.shade800])`
  - Rounded Bottom Left Corner: `Radius.circular(30)`
  - Content: User Avatar (Icon: `Iconsax.user`) + Greeting Text.
- **Menu Items**:
  - Active State: `Colors.blue.withOpacity(0.1)` background, Blue text/icon.
  - Inactive State: Transparent background, Grey icon, Black87 text.
  - Icons: Using `iconsax` package.
  - Typography: 16px font size, w600 for active, w500 for inactive.

### 2. Menu Button (`MenuButton`)
- **Type**: Floating/Positioned button.
- **Position**: `top: 60`, `left: 20` (Safe area/Status bar consideration).
- **Style**:
  - Size: 50x50.
  - Color: White background with `BoxShadow`.
  - Border Radius: `15`.
  - Icon: `Iconsax.menu_1`.

### 3. Screen Layout Pattern
All screens (Home and Exercises) follow this layout structure:
```dart
Scaffold(
  drawer: const AppDrawer(),
  body: Builder(
    builder: (context) {
      return Stack(
        children: [
          // 1. Main Content Layer
          Container(
            color: Colors.white,
            child: ...
          ),
          
          // 2. Navigation Control Layer
          MenuButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ],
      );
    },
  ),
)
```

## Dependencies
- `iconsax`: Used for all system icons.
- `flutter/material.dart`: Core UI framework.

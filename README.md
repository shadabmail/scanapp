# ScanApp - Asset Management System

A Flutter-based mobile application for managing assets with QR code scanning capabilities.

## Features

- **User Authentication**: Secure login system
- **Dashboard**: Quick access to main features with centered card layout
- **QR Code Scanner**: Animated scanner with pulsing overlay and scanning line effects
- **Asset Management**:
  - Add new assets with QR ID, name, image, and summary
  - Asset type selection (Direct/InDirect)
  - QR code generation for assets
  - Image picker integration
  - View asset list
  - Detailed asset view
- **Responsive Design**: Adapts to different screen sizes with custom responsive utilities
- **Bottom Navigation**: Easy navigation between Dashboard, Scan, and Assets
- **Drawer Navigation**: Quick logout functionality

## Tech Stack

- **Framework**: Flutter
- **Dependencies**:
  - `qr_flutter: ^4.1.0` - QR code generation
  - `image_picker: ^1.0.7` - Image selection from gallery
  - `mobile_scanner` - QR code scanning

## Permissions

### Android
- Camera access for QR scanning
- Storage read/write for image selection

## Color Scheme

- Primary Accent: Cyan (#5ED6E5)
- Dark Backgrounds: #0B1F2B, #132F40, #163A4D
- Radial gradient backgrounds throughout the app

## Screens

1. **Login Screen**: User authentication with gradient background
2. **Home Screen**: Bottom navigation with Dashboard, Scan, and Assets tabs
3. **Dashboard**: Grid of action cards (Scan, Add Asset, Asset List)
4. **Scanner Screen**: Real-time QR scanning with animated overlay
5. **Add Asset Screen**: Form for creating new assets with validation
6. **Asset List Screen**: View all assets
7. **Asset Detail Screen**: Detailed view of individual assets

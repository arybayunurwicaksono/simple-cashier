# 🛒 Simple Cashier (SimpleCashierApp)

> **Modern, Offline-First, Multi-Store Point of Sale (POS) for General Goods & Services.**  
> Engineered with **Flutter Monorepo (Melos)**, **Drift (SQLite)**, and **MobX**.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Melos](https://img.shields.io/badge/Melos-Monorepo-892CA0?style=for-the-badge)](https://melos.invertase.dev/)
[![SQLite](https://img.shields.io/badge/SQLite-Drift-003B57?style=for-the-badge&logo=sqlite&logoColor=white)](https://drift.simonbinder.eu/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Desktop-lightgrey?style=for-the-badge)](#)
[![License](https://img.shields.io/badge/License-Proprietary-blue?style=for-the-badge)](#)

---

## 📖 Table of Contents

1. [About the Project](#-about-the-project)
2. [Key Features](#-key-features)
3. [Monorepo Architecture](#-monorepo-architecture)
4. [Tech Stack & Dependencies](#-tech-stack--dependencies)
5. [Prerequisites](#-prerequisites)
6. [Getting Started & Installation](#-getting-started--installation)
7. [Available Melos Scripts](#-available-melos-scripts)
8. [Security & Data Privacy](#-security--data-privacy)
9. [Development & Git Workflow Policy](#-development--git-workflow-policy)
10. [License & Credits](#-license--credits)

---

## 💡 About the Project

**Simple Cashier** is a next-generation Point of Sale (POS) and inventory management system designed specifically for Micro, Small, and Medium Enterprises (MSMEs / UMKM) operating in retail (grocery, electronics, apparel) and service industries (barbershops, auto repair, workshops, laundromats, equipment rentals, tech services).

### Core Pillars:
- **Offline-First (100% Autonomous)**: Fully functional without an active internet connection. All data resides securely in a local high-performance SQLite database on the device.
- **Hybrid Catalog (Goods & Services)**: First-class support for both physical products (requiring stock tracking, COGS, and restock logs) and service offerings (hourly/fixed rates, non-inventory items).
- **Multi-Store & Multi-Branch**: Seamlessly manage multiple business outlets or independent shops from a single device, secured by store-level PIN credentials.
- **High-Performance & Reactive UI**: Driven by MobX reactive state management, providing instantaneous checkout interactions with zero stutter.

---

## ✨ Key Features

### 1. 🛍️ High-Speed POS Checkout & Cart
- Responsive cashier interface featuring instant catalog search, category filters, and grid/list view toggles.
- Dynamic cart supporting item-level adjustments, transaction-level discounts, tax/service fees, and automatic subtotal recalculations.
- Versatile payment support: **Cash** (with automated change computation) and **Digital Payments** (QRIS, Debit/Credit, Bank Transfer).
- **Bluetooth Thermal Printer Integration (58mm & 80mm ESC/POS)** for instant physical receipts.
- **Digital Receipt Export to PDF** ready to be shared directly via WhatsApp, email, or messaging apps.
- Full transaction return and item refund handling.

### 2. 🏪 Multi-Store Management & PIN Security
- Create and switch between multiple independent stores and branch locations effortlessly.
- **Interactive Store Setup Wizard**: Guided onboarding for business details, address, contact numbers, brand logos, and recovery security questions.
- **6-Digit PIN Protection** safeguarding each store against unauthorized access or cashier tampering.
- Quick store switcher accessible directly from the application drawer.

### 3. 📦 Dual Catalog & Stock Management
- **Physical Goods Management**: Track barcodes/SKUs, names, cost prices (COGS), selling prices, automated margin calculations, current stock levels, and low-stock alerts.
- **Restock History**: Dedicated restocking workflow recording purchased quantities, total acquisition cost, supplier notes, and operator identity.
- **Service Catalog**: Manage non-inventory service offerings with flat-rate or dynamic hourly pricing models.

### 4. 👥 Employee Management & Role-Based Access Control (RBAC)
- Strict authorization separation:
  - **Owner**: Unrestricted access to gross/net profit reports, monthly bookkeeping, store settings, employee management, and database operations.
  - **Cashier**: Access scoped strictly to POS sales, daily cash in/out entries, and personal transaction logs.
- **Audit Trails**: Granular activity logs tracking who performed each checkout, restock operation, or cash adjustment.
- Credential management: Owner-controlled staff password resets and profile updates.

### 5. 💵 Cash Flow & Register Management
- Log operational **Cash In** (e.g., initial float, owner capital) and **Cash Out** (e.g., supplies, utilities, wages).
- Live balance tracking split cleanly between **Physical Cash in Drawer** and **Digital/Bank Balance**.
- Categorized ledger entries for clear expense categorization.

### 6. 📑 Monthly Accounting & Financial Closing
- Formal end-of-month book closing (*Tutup Buku*): freezes monthly gross revenue, operational expenses, inventory valuation, and net earnings.
- Permanent historical ledger records to ensure compliance and reliable business trajectory reviews.

### 7. 📊 Business Analytics & Data Visualization
- **Sales & Profit Trend Graphs**: Visualized using interactive *Spline Area Charts*.
- **Revenue Mix**: Proportional breakdown between physical merchandise vs service revenue via *Circular Donut Charts*.
- **Top-Performing Categories**: Comparative sales volume breakdown using *Capsule Bar Charts*.
- Flexible date range filters: Today, Last 7 Days, This Month, This Year, or Custom Date Ranges.

### 8. 🖨️ Hardware Thermal Printing & PDF Generation
- Native Bluetooth ESC/POS thermal printing engine compatible with 58mm and 80mm paper widths.
- Configurable receipt header and footer branding messages.
- Clean vector PDF generator for professional monthly accounting summaries, transaction receipts, and audit sheets.

### 9. 💾 Local Backup & Disaster Recovery
- One-tap export of the entire application database into a portable backup file stored on the device.
- Instant database restoration for safe data migration between devices or recovery after hardware upgrades.

### 10. 🎨 Modern Material 3 UI & Localization
- Modern Material Design 3 design system with polished typography (Google Fonts) and crisp Lucide icons.
- Complete support for **Dark Mode** and **Light Mode**.
- Multilingual support: **Indonesian (`id_ID`)** and **English (`en_US`)**.

---

## 🏗️ Monorepo Architecture

This repository is organized as a modular **Monorepo** managed via [Melos](https://melos.invertase.dev/):

```text
simple-cashier/
├── apps/
│   └── app_local_simple_cashier/       # Main Flutter client app (UI, Screens, Stores, DI)
├── packages/
│   ├── core/                           # Core utilities, security, formatters, PDF & file services
│   ├── database/                       # Drift SQLite ORM, schema tables, DAOs, background isolate
│   ├── ui/                             # Atomic Design System (Atoms, Molecules, Organisms, Theme)
│   └── thermal_printer/                # Bluetooth thermal printer service & ESC/POS byte generator
├── melos.yaml                          # Monorepo configuration & script automation
└── pubspec.yaml                        # Monorepo workspace configuration
```

### Module Breakdown:

| Package | Purpose & Responsibilities |
| :--- | :--- |
| **`apps/app_local_simple_cashier`** | The main application package. Contains screens, navigation routing, MobX presentation stores, and dependency injection wiring via GetIt. |
| **`packages/core`** | Platform-agnostic utilities: currency & date formatters (`CurrencyFormatter`, `DateFormatter`), password hashing (`PasswordHasher`), secure storage (`SecureStorageService`), and PDF reporting (`PdfReportService`). |
| **`packages/database`** | Data persistence engine powered by [Drift](https://drift.simonbinder.eu/) (SQLite) running on a background isolate. Houses 12+ relational tables and 10+ DAOs. |
| **`packages/ui`** | Shared Atomic Design System. Provides reusable atomic widgets (`AppButton`, `AppTextField`), molecules (`ProductCard`, `SplineAreaChart`), organisms (`ModernStatGradientCard`, `CustomBottomNavBar`), and complete Light/Dark theme builders. |
| **`packages/thermal_printer`** | Hardware abstraction layer for Bluetooth device discovery, connection lifecycle, and ESC/POS command generation (`esc_pos_utils_plus` & `print_bluetooth_thermal`). |

---

## 💻 Tech Stack & Dependencies

- **Framework**: [Flutter](https://flutter.dev/) (SDK `>= 3.24.0 < 4.0.0`)
- **Language**: [Dart](https://dart.dev/) (SDK `>= 3.5.0 < 4.0.0`)
- **Monorepo Tooling**: [Melos](https://pub.dev/packages/melos) `^8.2.2`
- **Database / ORM**: [Drift](https://drift.simonbinder.eu/) `^2.18.0` + `sqlite3_flutter_libs`
- **State Management**: [MobX](https://pub.dev/packages/mobx) `^2.3.3` + [flutter_mobx](https://pub.dev/packages/flutter_mobx)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) `^7.7.0`
- **Security & Cryptography**: `crypto` (PBKDF2/SHA-256) + `flutter_secure_storage`
- **Hardware & Printing**: `print_bluetooth_thermal`, `esc_pos_utils_plus`, `pdf`, `printing`
- **UI & Aesthetics**: `google_fonts`, `lucide_icons`, `flutter_animate`

---

## ⚙️ Prerequisites

Before building or contributing to this project, ensure your workstation has:

1. **Flutter SDK**: Version `3.24.0` or higher.
   ```bash
   flutter --version
   ```
2. **Dart SDK**: Version `3.5.0` or higher.
3. **Melos CLI**: The Dart monorepo management CLI.
   ```bash
   dart pub global activate melos
   ```
4. **Android SDK / Toolchain**: Android Studio / VS Code with an emulator or a physical device (a physical Android device is strongly recommended for testing Bluetooth Thermal Printer hardware).

---

## 🚀 Getting Started & Installation

Follow these steps to set up the project locally:

### 1. Clone the Repository
```bash
git clone https://github.com/dgc16/simple-cashier-app.git
cd simple-cashier
```

### 2. Bootstrap the Workspace (Melos)
Run the bootstrap command from the root directory to link internal packages and resolve all dependencies:
```bash
melos bootstrap
```
*(Alternatively, execute `flutter pub get` in the root workspace if using native Dart/Flutter workspace resolution).*

### 3. Generate Code (Drift Database & MobX)
This project uses code generators for SQLite DAOs and MobX reactive stores. Generate them by running:
```bash
melos run codegen
```
For continuous code generation during development:
```bash
melos run codegen:watch
```

### 4. Run the Application
Navigate to the application package or launch directly with Flutter:
```bash
cd apps/app_local_simple_cashier
flutter run
```

---

## 🛠️ Available Melos Scripts

Convenient script shortcuts configured in `melos.yaml`:

| Command | Action |
| :--- | :--- |
| `melos run analyze` | Runs static analysis (`flutter analyze .`) across all apps and packages |
| `melos run test` | Executes unit and integration test suites in all packages containing a `test` directory |
| `melos run codegen` | Executes `build_runner` to generate `*.g.dart` files (Drift schemas & MobX stores) |
| `melos run codegen:watch` | Starts `build_runner watch` mode for live code generation |
| `melos run clean` | Cleans Flutter build caches and temporary artifacts across the monorepo |

---

## 🔒 Security & Data Privacy

1. **Local-First Privacy**: Transaction logs, stock values, customer details, and profit calculations remain strictly on the local device without outbound transmission to third-party cloud servers.
2. **Robust Credential Cryptography**:
   - Store PINs and user passwords are encrypted using **PBKDF2** with high-entropy cryptographic random salts.
   - Plaintext credentials are never saved to disk or database tables.
3. **Multi-Tenant Store Scoping**: All relational queries (products, services, orders, cash entries) are explicitly scoped by `store_id`, guaranteeing total separation between multiple shops.
4. **Privileged Operation Gates**: Sensitive operations (staff creation, accounting freeze, store credential resets) require explicit Owner role verification and store PIN authorization.

---

## 📜 Development & Git Workflow Policy

To maintain repository stability, this project strictly adheres to the following workflow:
- **Verification Protocol**:
  - UI / Layout modifications: Run `melos run analyze`.
  - Logic, database schema, or store modifications: Run `melos run analyze` followed by `melos run test`.
- **Manual Commit Protocol**: Automated commit and push actions are strictly prohibited. Developers inspect, test, and manually commit all changes using standard git commands.

---

## 📄 License & Credits

Developed by **Ary Bayu Nurwicaksono** ([@arybayunurwicaksono](https://github.com/arybayunurwicaksono))  
Copyright &copy; 2026. All rights reserved.
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:database/database.dart';
import 'package:core/core.dart';
import 'package:ui/ui.dart';
import '../../di/injection.dart';
import '../../stores/auth_store.dart';
import '../../stores/employee_store.dart';
import 'employee_form_dialog.dart';
import 'employee_reset_password_dialog.dart';
import 'employee_detail_screen.dart';

class EmployeeManagementScreen extends StatefulWidget {
  const EmployeeManagementScreen({super.key});

  @override
  State<EmployeeManagementScreen> createState() => _EmployeeManagementScreenState();
}

class _EmployeeManagementScreenState extends State<EmployeeManagementScreen> {
  final _employeeStore = getIt<EmployeeStore>();
  final _authStore = getIt<AuthStore>();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _employeeStore.loadEmployees();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleDeleteEmployee(UserData emp) async {
    final currentUserId = _authStore.currentUser?.id ?? -1;

    if (emp.id == currentUserId) {
      AppNotification.showWarning(
        context,
        'Anda tidak dapat menghapus akun Anda sendiri yang sedang aktif digunakan.',
      );
      return;
    }

    ConfirmationDialog.show(
      context,
      title: 'Hapus Akun Karyawan?',
      message: 'Apakah Anda yakin ingin menghapus akun ${emp.fullname} (@${emp.username})? Data akun akan dihapus permanen.',
      isDanger: true,
      onConfirm: () async {
        final success = await _employeeStore.deleteEmployee(
          userId: emp.id,
          currentUserId: currentUserId,
        );

        if (!mounted) return;

        if (success) {
          AppNotification.showSuccess(
            context,
            'Akun ${emp.fullname} berhasil dihapus',
          );
        } else {
          AppNotification.showError(
            context,
            _employeeStore.errorMessage ?? 'Gagal menghapus karyawan',
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manajemen Karyawan', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'Tambah Karyawan',
            icon: const Icon(Icons.person_add_rounded),
            onPressed: () => EmployeeFormDialog.show(context),
          ),
          IconButton(
            tooltip: 'Muat Ulang',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => _employeeStore.loadEmployees(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => EmployeeFormDialog.show(context),
        backgroundColor: isDark ? const Color(0xFF0284C7) : AppColors.primary,
        icon: const Icon(Icons.person_add_rounded, color: Colors.white),
        label: const Text('Tambah Karyawan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Observer(
        builder: (_) {
          if (_employeeStore.isLoading && _employeeStore.employeeList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final allEmployees = _employeeStore.employeeList;
          final employees = _employeeStore.filteredEmployees;
          final totalCount = allEmployees.length;
          final cashierCount = allEmployees.where((u) => u.role == 'cashier').length;
          final ownerCount = allEmployees.where((u) => u.role == 'owner').length;

          return Column(
            children: [
              // Top KPI Summary Cards
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        title: 'Total Akun',
                        value: '$totalCount',
                        icon: Icons.people_alt_rounded,
                        color: const Color(0xFF6366F1),
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildSummaryCard(
                        title: 'Kasir & Staf',
                        value: '$cashierCount',
                        icon: Icons.point_of_sale_rounded,
                        color: const Color(0xFF0284C7),
                        isDark: isDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildSummaryCard(
                        title: 'Pemilik (Owner)',
                        value: '$ownerCount',
                        icon: Icons.shield_rounded,
                        color: const Color(0xFF059669),
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: AppSearchBar(
                  hint: 'Cari nama, username, atau email karyawan...',
                  controller: _searchController,
                  onChanged: (val) => _employeeStore.setSearchQuery(val),
                  onClear: () {
                    _searchController.clear();
                    _employeeStore.setSearchQuery('');
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Instruction Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0C4A6E).withValues(alpha: 0.3) : const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isDark ? const Color(0xFF0369A1).withValues(alpha: 0.4) : const Color(0xFFBFDBFE),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Ketuk pada karyawan untuk memantau log transaksi, restock, kasir, & retur.',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark ? const Color(0xFF7DD3FC) : const Color(0xFF1E40AF),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Employee List
              Expanded(
                child: employees.isEmpty
                    ? const EmptyStateView(
                        title: 'Karyawan Tidak Ditemukan',
                        message: 'Tidak ada karyawan yang sesuai dengan kata kunci pencarian.',
                        icon: Icons.person_search_rounded,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(14, 2, 14, 80),
                        itemCount: employees.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (ctx, i) {
                          final emp = employees[i];
                          return _buildEmployeeCard(context, emp, isDark);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: color, size: 14),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeCard(BuildContext context, UserData emp, bool isDark) {
    final isOwner = emp.role == 'owner';
    final isCurrent = emp.id == _authStore.currentUser?.id;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EmployeeDetailScreen(employee: emp),
          ),
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isCurrent
                ? (isDark ? const Color(0xFF0284C7) : AppColors.primary)
                : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0)),
            width: isCurrent ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: isOwner
                      ? const Color(0xFF059669).withValues(alpha: 0.18)
                      : const Color(0xFF0284C7).withValues(alpha: 0.18),
                  child: Text(
                    emp.fullname.isNotEmpty ? emp.fullname[0].toUpperCase() : 'U',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isOwner ? const Color(0xFF10B981) : const Color(0xFF0284C7),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              emp.fullname,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.5,
                                color: isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isCurrent) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'ANDA',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF818CF8),
                                ),
                              ),
                            ),
                          ],
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isOwner
                                  ? const Color(0xFF059669).withValues(alpha: 0.2)
                                  : const Color(0xFF0284C7).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: isOwner
                                    ? const Color(0xFF10B981).withValues(alpha: 0.4)
                                    : const Color(0xFF38BDF8).withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              isOwner ? 'OWNER' : 'KASIR',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                                color: isOwner ? const Color(0xFF10B981) : const Color(0xFF0284C7),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@${emp.username} • ${emp.email}',
                        style: TextStyle(
                          fontSize: 11,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    size: 20,
                  ),
                  onSelected: (val) {
                    if (val == 'edit') {
                      EmployeeFormDialog.show(context, employee: emp);
                    } else if (val == 'reset_password') {
                      EmployeeResetPasswordDialog.show(context, employee: emp);
                    } else if (val == 'delete') {
                      _handleDeleteEmployee(emp);
                    }
                  },
                  itemBuilder: (ctx) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_rounded, size: 18),
                          SizedBox(width: 8),
                          Text('Edit Akun', style: TextStyle(fontSize: 12.5)),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'reset_password',
                      child: Row(
                        children: [
                          Icon(Icons.lock_reset_rounded, size: 18),
                          SizedBox(width: 8),
                          Text('Reset Kata Sandi', style: TextStyle(fontSize: 12.5)),
                        ],
                      ),
                    ),
                    if (!isCurrent)
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline_rounded, size: 18, color: Color(0xFFDC2626)),
                            SizedBox(width: 8),
                            Text('Hapus Akun', style: TextStyle(fontSize: 12.5, color: Color(0xFFDC2626))),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Terdaftar: ${DateFormatter.formatShort(emp.createdAt)}',
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lihat Log Aktivitas',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 10,
                      color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

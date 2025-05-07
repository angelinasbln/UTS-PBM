import 'package:flutter/material.dart';

class AkunPage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Map<String, String> userData;
  final void Function(String, String, String) onUserDataChanged;

  const AkunPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.userData,
    required this.onUserDataChanged,
  });

  void _showEditDialog(BuildContext context) {
    final namaController = TextEditingController(text: userData['nama']);
    final nimController = TextEditingController(text: userData['nim']);
    final emailController = TextEditingController(text: userData['email']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Data Mahasiswa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: nimController,
              decoration: const InputDecoration(labelText: 'NIM'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Simpan'),
            onPressed: () {
              onUserDataChanged(
                namaController.text,
                nimController.text,
                emailController.text,
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    final isEmpty = value.trim().isEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Text(
              isEmpty ? '(empty)' : value,
              style: TextStyle(
                fontSize: 18,
                color: isEmpty ? Colors.grey : null,
                fontStyle: isEmpty ? FontStyle.italic : FontStyle.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Nama', userData['nama'] ?? ''),
        _buildInfoRow('NIM', userData['nim'] ?? ''),
        _buildInfoRow('Email', userData['email'] ?? ''),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Mode Gelap', style: TextStyle(fontSize: 18)),
            Switch(
              value: isDarkMode,
              onChanged: onThemeChanged,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: ElevatedButton.icon(
            onPressed: () => _showEditDialog(context),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Data'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}

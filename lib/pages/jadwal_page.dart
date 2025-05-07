import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  final List<Map<String, String>> jadwal;

  const JadwalPage({super.key, required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DataTable(
            columnSpacing: 16,
            headingRowColor: WidgetStateProperty.all(
              Colors.indigo.withAlpha(25),
            ),
            border: TableBorder.all(color: Colors.grey.shade300),
            columns: const [
              DataColumn(
                label: Text(
                  'Mata Kuliah',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Hari',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Waktu',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: jadwal.map((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item['matkul'] ?? '')),
                  DataCell(Text(item['hari'] ?? '')),
                  DataCell(Text(item['waktu'] ?? '')),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../models/kegiatan.dart';

class HomePage extends StatelessWidget {
  final List<Kegiatan> kegiatan;
  final Function(int, bool?) onCheckboxChanged;

  const HomePage({super.key, required this.kegiatan, required this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kegiatan.length,
      itemBuilder: (context, index) {
        final item = kegiatan[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(item.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tanggal: ${item.tanggal}'),
                if (item.selesai)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Selesai',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            trailing: Checkbox(
              value: item.selesai,
              onChanged: (value) {
                onCheckboxChanged(index, value);
              },
            ),
          ),
        );
      },
    );
  }
}

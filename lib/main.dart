import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

import 'models/kegiatan.dart';
import 'pages/home_page.dart';
import 'pages/jadwal_page.dart';
import 'pages/akun_page.dart';

void main() {
  runApp(const PbmAngelApp());
}

class PbmAngelApp extends StatefulWidget {
  const PbmAngelApp({super.key});

  @override
  PbmAngelAppState createState() => PbmAngelAppState();
}

class PbmAngelAppState extends State<PbmAngelApp> {
  bool isDarkMode = false;

  Map<String, String> userData = {
    'nama': '',
    'nim': '',
    'email': '',
  };

  void updateUserData(String nama, String nim, String email) {
    setState(() {
      userData = {
        'nama': nama,
        'nim': nim,
        'email': email,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIAK Mahasiswa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: MainScreen(
        isDarkMode: isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
        userData: userData,
        onUserDataChanged: updateUserData,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final Map<String, String> userData;
  final void Function(String, String, String) onUserDataChanged;

  const MainScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.userData,
    required this.onUserDataChanged,
  });

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late List<Kegiatan> kegiatan;
  late List<Map<String, String>> jadwal;

  @override
  void initState() {
    super.initState();
    kegiatan = [
      Kegiatan(nama: 'Praktikum Pemrograman Berbasis Mobile', tanggal: '2025-05-06'),
      Kegiatan(nama: 'Praktikum Geoinformatika', tanggal: '2025-05-07', selesai: true),
      Kegiatan(nama: 'UTS Enterprise Software Engineering', tanggal: '2025-05-08'),
    ];

    jadwal = [
      {'hari': 'Senin', 'matkul': 'E-Bussines', 'waktu': '08:00 - 10:00'},
      {'hari': 'Selasa', 'matkul': 'Enterprise Software Engineering', 'waktu': '10:00 - 12:00'},
      {'hari': 'Rabu', 'matkul': 'Geoinformatika', 'waktu': '13:00 - 15:00'},
      {'hari': 'Kamis', 'matkul': 'Manajemen Proyek', 'waktu': '08:00 - 10:00'},
      {'hari': 'Jumat', 'matkul': 'Metodologi Penelitian', 'waktu': '10:00 - 12:00'},
      {'hari': 'Sabtu', 'matkul': 'Pemrograman Berbasis Mobile', 'waktu': '13:00 - 15:00'},
    ];
  }

  void _onCheckboxChanged(int index, bool? value) {
    setState(() {
      kegiatan[index].selesai = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(kegiatan: kegiatan, onCheckboxChanged: _onCheckboxChanged),
      JadwalPage(jadwal: jadwal),
      AkunPage(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
        userData: widget.userData,
        onUserDataChanged: widget.onUserDataChanged,
      ),
    ];

    return AdaptiveScaffold(
      selectedIndex: _selectedIndex,
      onSelectedIndexChange: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: const [
        NavigationDestination(label: 'Home', icon: Icon(Icons.home_outlined)),
        NavigationDestination(label: 'Jadwal', icon: Icon(Icons.schedule_outlined)),
        NavigationDestination(label: 'Akun', icon: Icon(Icons.person_outline)),
      ],
      body: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: pages[_selectedIndex],
          ),
        ),
      ),
    );
  }
}

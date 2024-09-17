import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tampilan Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Beranda(),
    );
  }
}

class Beranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beranda"),
        backgroundColor: Colors.grey,
        actions: [
          // Ikon Search
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          // Ikon Notifications
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tidak ada notifikasi baru'),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Mahasiswa
            Text("Nama: Aprianda Alif Budiman"),
            Text("Nim: 220112005"),
            Text("Jenis Kelamin: Laki-laki"),
            Text("Program Studi: Sistem Informasi"),
            SizedBox(height: 20),

            // ElevatedButton
            ElevatedButton(
              onPressed: () {
                // Aksi yang akan dijalankan ketika tombol ditekan
              },
              child: Text('Klik Saya'),
            ),
            SizedBox(height: 20),

            // TextField untuk Username
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Masukkan username Anda',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                // Aksi yang dijalankan ketika teks berubah
              },
            ),
            SizedBox(height: 20),

            // TextField untuk Email
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Masukkan email Anda',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                // Aksi yang dijalankan ketika teks berubah
              },
            ),
            SizedBox(height: 20),

            // TextField untuk Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Masukkan password Anda',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                // Aksi yang dijalankan ketika teks berubah
              },
            ),
            SizedBox(height: 20),

            // TextField untuk Confirm Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Konfirmasi password Anda',
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                // Aksi yang dijalankan ketika teks berubah
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final mahasiswa = [
    "Aprianda Alif Budiman",
    "Adam Faturohman",
    "Pradestya Bima",
    "Akmal Raka",
  ];

  final recentSearches = [
    "Adam Faturohman",
    "Pradestya Bima",
    "Akmal Raka",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSearches
        : mahasiswa.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          query = suggestionList[index];
          showResults(context);
        },
        leading: Icon(Icons.person),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile2/Menu/daftaranggota.dart';
import 'package:mobile2/Menu/favorit.dart';
import 'package:mobile2/Menu/rekomendasi.dart';
import 'package:mobile2/Menu/stopwatch.dart';
import 'package:mobile2/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0077B6), Color(0xFF000000)],
            ),
          ),
          child: AppBar(
            title: const Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent, // Make AppBar transparent
            elevation: 0, // Remove shadow
          ),
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0077B6), Color(0xFF000000)],
          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: 'Bantuan',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor:
              Colors.transparent, // Make BottomNavigationBar transparent
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0077B6), Color(0xFF000000)],
        ),
      ),
      child: _selectedIndex == 0 ? _buildHomeContent() : _buildHelpContent(),
    );
  }

  Widget _buildHomeContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: <Widget>[
                _menuCard(Icons.person, 'Daftar Anggota', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DaftarAnggota()),
                  );
                }),
                _menuCard(Icons.access_time, 'Aplikasi Stopwatch', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Stopwatch()),
                  );
                }),
                _menuCard(Icons.web, 'Daftar Rekomendasi', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DaftarRekomendasi()),
                  );
                }),
                _menuCard(Icons.favorite, 'Favorite', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Favorit()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpContent() {
    return Center(
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16.0), // Add padding for better aesthetics
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align content to the left
          children: [
            // Center the title
            const Center(
              child: Text(
                'Penggunaan Aplikasi',
                style: TextStyle(
                  fontSize: 24, // Increase font size for the title
                  fontWeight: FontWeight.bold, // Make the title bold
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '1. Login dan Registrasi\n'
              'Sebelum mengakses halaman utama, pengguna perlu melakukan login terlebih dahulu. '
              'Jika pengguna belum memiliki akun, mereka dapat melakukan registrasi dengan memasukkan alamat email dan password. '
              'Setelah berhasil registrasi, pengguna dapat melanjutkan untuk login dan mengakses halaman utama.\n\n'
              '2. Halaman Utama\n'
              'Di halaman utama, pengguna akan melihat beberapa menu utama, yaitu:\n'
              '- Daftar Anggota: Menampilkan daftar anggota kelompok.\n'
              '- Stopwatch: Mengakses fitur stopwatch untuk memulai, menghentikan, dan mereset waktu.\n'
              '- Daftar Rekomendasi: Menampilkan situs-situs web yang direkomendasikan, dilengkapi dengan gambar, nama, link yang dapat diakses, serta checkbox untuk menambahkan rekomendasi ke dalam favorit.\n'
              '- Favorit: Menampilkan daftar situs web favorit yang telah dipilih dari menu daftar rekomendasi.\n'
              '- Navigation Bar: Memudahkan navigasi antara menu, serta akses ke halaman Bantuan.\n\n'
              '3. Menu Rekomendasi\n'
              'Jika pengguna memilih menu Daftar Rekomendasi, mereka dapat melihat berbagai situs web yang direkomendasikan. '
              'Setiap rekomendasi dilengkapi dengan gambar, nama, dan link yang dapat diklik, serta checkbox untuk menandai situs sebagai favorit.\n\n'
              '4. Menu Favorit\n'
              'Pada menu Favorit, pengguna dapat melihat daftar situs web yang telah ditandai dari menu daftar rekomendasi. '
              'Ini memungkinkan pengguna untuk dengan mudah mengakses situs favorit mereka.\n\n'
              '5. Fitur Stopwatch\n'
              'Dengan memilih menu Stopwatch, pengguna dapat memanfaatkan stopwatch untuk menghitung waktu. '
              'Pengguna dapat memulai waktu, menghentikan, atau mereset stopwatch sesuai kebutuhan.\n\n'
              '6. Bantuan dan Logout\n'
              'Jika pengguna memilih Navigation Bar Bantuan, mereka dapat membaca panduan penggunaan aplikasi. '
              'Pengguna juga dapat melakukan logout dari aplikasi jika diperlukan.\n\n'
              '7. Otomatis Login\n'
              'Apabila pengguna sudah pernah melakukan login sebelumnya dan menutup aplikasi, '
              'saat membuka aplikasi kembali, pengguna tidak perlu login lagi. Mereka akan langsung diarahkan ke halaman utama.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5, // Increase line height for better readability
              ),
              textAlign: TextAlign.left, // Align text to the left
            ),
            const SizedBox(height: 20),
            // Center the Logout button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 185, 16, 16)
                      .withOpacity(0.8), // Set button color
                  foregroundColor: Colors.white, // Set text color
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(IconData icon, String title, VoidCallback onPressed) {
    return Card(
      color: Colors.black
          .withOpacity(0.5), // Make card background semi-transparent
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 50, color: Colors.white), // Set icon color to white
            const SizedBox(height: 10),
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white)), // Set text color to white
          ],
        ),
      ),
    );
  }
}

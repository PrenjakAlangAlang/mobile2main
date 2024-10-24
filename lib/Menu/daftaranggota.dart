import 'package:flutter/material.dart';

class DaftarAnggota extends StatefulWidget {
  const DaftarAnggota({super.key});

  @override
  State<DaftarAnggota> createState() => _DaftarAnggotaState();
}

class _DaftarAnggotaState extends State<DaftarAnggota> {
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
              colors: [
                Color(0xFF0077B6),
                Color(0xFF000000)
              ], // Gradient background
            ),
          ),
          child: AppBar(
            title: const Text(
              'Daftar Anggota',
              style: TextStyle(
                color: Colors.white, // Set the text color to white
                fontSize: 20, // Set font size
                fontWeight: FontWeight.bold, // Make the text bold
              ),
            ),
            backgroundColor:
                Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Remove shadow
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0077B6),
              Color(0xFF000000)
            ], // Same gradient as AppBar
          ),
        ),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.all(20.0), // Add padding around the content
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center the column vertically
              children: [
                const Text(
                  'Anggota Kami',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28, // Increased font size for the title
                    fontWeight: FontWeight.bold, // Bold title
                    letterSpacing: 2.0, // Add some space between letters
                  ),
                ),
                const SizedBox(height: 20), // Space between title and list
                Expanded(
                  child: Card(
                    color: Colors.black
                        .withOpacity(0.5), // Semi-transparent card background
                    child: ListView(
                      children: [
                        _buildListTile('Ahmad Faiq Syahputra', '124220013',
                            'images/faiq.png'), // Replace with your image URL
                        _buildListTile('Luthfi Nurafiq Asshiddiqi', '124220021',
                            'images/lutpi.png'), // Replace with your image URL
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String name, String id, String imageUrl) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30, // Adjust the radius for the desired size
        backgroundImage: NetworkImage(imageUrl), // Load image from URL
        backgroundColor:
            Colors.grey, // Placeholder color if image fails to load
      ),
      title: Text(
        name,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18, // Adjust the font size for the name
          fontWeight: FontWeight.w600, // Use semi-bold weight
          letterSpacing: 1.2, // Add some letter spacing
        ),
      ),
      subtitle: Text(
        id,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 16, // Font size for the ID
          fontStyle: FontStyle.italic, // Italicize the ID text
          letterSpacing: 1.0, // Add some letter spacing
        ),
      ),
    );
  }
}

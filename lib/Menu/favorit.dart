import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Favorit extends StatefulWidget {
  const Favorit({super.key});

  @override
  _FavoritState createState() => _FavoritState();
}

class _FavoritState extends State<Favorit> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _favoritList = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorit();
  }

  Future<void> _fetchFavorit() async {
    final user = _auth.currentUser;
    if (user == null) return;

    QuerySnapshot snapshot = await _firestore
        .collection('rekomendasi')
        .where('favorit', arrayContains: user.uid)
        .get();
    setState(() {
      _favoritList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
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
              colors: [
                Color(0xFF0077B6),
                Color(0xFF000000),
              ],
            ),
          ),
          child: AppBar(
            title: const Text(
              'Favorit',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent, // Keep AppBar transparent
            elevation: 0, // No shadow
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
              Color(0xFF000000),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: _favoritList.length,
          itemBuilder: (context, index) {
            var favorit = _favoritList[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: Colors.black.withOpacity(0.0), // Semi-transparent card
              child: ListTile(
                leading: ClipOval(
                  child: Image.network(
                    favorit['image'],
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey,
                        child: const Center(child: Text('No Image')),
                      );
                    },
                  ),
                ),
                title: Text(
                  favorit['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Improved visibility
                  ),
                ),
                subtitle: InkWell(
                  onTap: () => _launchURL(favorit['url']),
                  child: Text(
                    favorit['url'],
                    style: const TextStyle(
                      color: Colors.lightBlueAccent, // More visible link color
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

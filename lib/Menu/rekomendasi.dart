import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class DaftarRekomendasi extends StatefulWidget {
  const DaftarRekomendasi({super.key});

  @override
  _DaftarRekomendasiState createState() => _DaftarRekomendasiState();
}

class _DaftarRekomendasiState extends State<DaftarRekomendasi> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _rekomendasiList = [];

  @override
  void initState() {
    super.initState();
    _fetchRekomendasi();
  }

  Future<void> _fetchRekomendasi() async {
    QuerySnapshot snapshot = await _firestore.collection('rekomendasi').get();
    setState(() {
      _rekomendasiList = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }

  Future<void> _updateFavorit(String id, bool isFavorit) async {
    final user = _auth.currentUser;
    if (user == null) return;

    DocumentSnapshot doc =
        await _firestore.collection('rekomendasi').doc(id).get();
    List<dynamic> favorit = doc['favorit'] ?? [];

    if (isFavorit) {
      if (!favorit.contains(user.uid)) {
        favorit.add(user.uid);
      }
    } else {
      favorit.remove(user.uid);
    }

    await _firestore.collection('rekomendasi').doc(id).update({
      'favorit': favorit,
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
              'Daftar Rekomendasi',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
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
          itemCount: _rekomendasiList.length,
          itemBuilder: (context, index) {
            var rekomendasi = _rekomendasiList[index];
            bool isFavorit =
                rekomendasi['favorit']?.contains(_auth.currentUser?.uid) ??
                    false;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              color: Colors.black.withOpacity(0.0),
              child: ListTile(
                leading: ClipOval(
                  child: Image.network(
                    rekomendasi['image'],
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
                  rekomendasi['title'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: InkWell(
                  onTap: () => launchUrll(rekomendasi['url']),
                  child: Text(
                    rekomendasi['url'],
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    isFavorit ? Icons.favorite : Icons.favorite_border,
                    color: isFavorit ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorit = !isFavorit; // Toggle the value
                      // Update the value in _rekomendasiList
                      if (isFavorit) {
                        _rekomendasiList[index]['favorit'] =
                            _rekomendasiList[index]['favorit'] ?? [];
                        _rekomendasiList[index]['favorit']
                            .add(_auth.currentUser!.uid);
                      } else {
                        _rekomendasiList[index]['favorit']
                            .remove(_auth.currentUser!.uid);
                      }
                    });
                    _updateFavorit(rekomendasi['id'], isFavorit);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void launchUrll(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}

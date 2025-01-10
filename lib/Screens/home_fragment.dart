import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/512/2899/2899119.png',
            width: 200, // Sesuaikan ukuran gambar
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20), // Jarak antara gambar dan teks
          Text(
            'MY Playlist',
            style: TextStyle(fontSize: 30), // Sesuaikan ukuran font
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

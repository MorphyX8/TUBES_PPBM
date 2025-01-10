import 'package:flutter/material.dart';

class AboutFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Nama: Alfikri Suhaimi\nNIM: 7708220118',
            style: TextStyle(
              fontFamily: 'Courier', // Typewriter-style font
              fontSize: 20,
              fontWeight: FontWeight.bold, // Bold text
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Nama: Fardeo Noor Mathin\nNIM: 7708220043',
            style: TextStyle(
              fontFamily: 'Courier', // Typewriter-style font
              fontSize: 20,
              fontWeight: FontWeight.bold, // Bold text
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            'Nama: Aditya Mahendra Putra\nNIM: 7708223029',
            style: TextStyle(
              fontFamily: 'Courier', // Typewriter-style font
              fontSize: 20,
              fontWeight: FontWeight.bold, // Bold text
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

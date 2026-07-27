import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String active = "Paris";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.purpleDark, AppColors.purpleLight],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text("Location", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Choose your desired location", style: TextStyle(fontSize: 18)),

            const SizedBox(height: 40),

            _locationTile("Warsaw, Poland", "25ms"),
            const SizedBox(height: 16),
            _locationTile("Hamburg, Germany", "12ms"),
            const SizedBox(height: 16),
            _locationTile("Paris, France", "24ms"),

            const Spacer(),

            GestureDetector(
              onTap: () => Navigator.pushNamed(context, "/home"),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text("Connect", style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text("Active: $active", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _locationTile(String city, String ping) {
    bool selected = active == city.split(",")[0];

    return GestureDetector(
      onTap: () {
        setState(() {
          active = city.split(",")[0];
        });
      },
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                city,
                style: TextStyle(
                  fontSize: 18,
                  color: selected ? Colors.black : Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                ping,
                style: TextStyle(
                  fontSize: 18,
                  color: selected ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
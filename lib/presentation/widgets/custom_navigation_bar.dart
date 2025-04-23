import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        color: Colors.white,
        elevation: 0,
        child: Container(
          height: 80, // Ideal height for bottom nav bar
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                label: 'ప్రార్థనలు',
                assetPath: 'assets/images/prayer.jpg',
              ),
              _buildNavItem(
                index: 1,
                label: 'పఠనములు',
                assetPath: 'assets/images/liturgy.jpg',
              ),
              _buildNavItem(
                index: 2,
                label: 'దివ్యబలిపూజ',
                assetPath: 'assets/images/massToday.jpg',
              ),
              _buildNavItem(
                index: 3,
                label: 'బైబిల్',
                assetPath: 'assets/images/bible.jpg',
              ),
              _buildNavItem(
                index: 4,
                label: 'పాటలు',
                assetPath: 'assets/images/songs.jpg',
              ),
              _buildNavItem(
                index: 5,
                label: 'యూట్యూబ్',
                assetPath: 'assets/images/imvsAppImages.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String assetPath,
  }) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(assetPath),
              backgroundColor: Colors.transparent,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.deepPurple : Colors.grey,
                fontWeight: FontWeight.w800,
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
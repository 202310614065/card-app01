import 'package:flutter/material.dart';

class AnimatedBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  // DÜZELTİLDİ: Modern 'super parameters' kullanımı.
  const AnimatedBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<IconData> _icons = const [
    Icons.home_filled,
    Icons.map_outlined,
    Icons.history,
    Icons.person_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            // DÜZELTİLDİ: withOpacity yerine withAlpha kullanımı. 0.4 opacity ~ 102 alpha'ya denk gelir.
            color: Colors.black.withAlpha(102), 
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            left: (selectedIndex * (MediaQuery.of(context).size.width - 40) / _icons.length),
            top: 0,
            bottom: 0,
            width: (MediaQuery.of(context).size.width - 40) / _icons.length,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_icons.length, (index) {
              return IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  _icons[index],
                  color: selectedIndex == index ? Colors.white : Colors.grey[600],
                  size: 28,
                ),
                onPressed: () => onItemTapped(index),
              );
            }),
          ),
        ],
      ),
    );
  }
}
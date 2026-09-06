import 'package:flutter/material.dart';

class SmartCameraTopModes extends StatefulWidget {
  const SmartCameraTopModes({super.key});

  @override
  State<SmartCameraTopModes> createState() => _SmartCameraTopModesState();
}

class _SmartCameraTopModesState extends State<SmartCameraTopModes> {
  int selectedIndex = 0;

  final List<String> modes = [
    "Document",
    "ID",
    "Book",
    "Whiteboard",
    "OCR",
    "Translate",
    "QR",
    "ID Photo",
    "Time",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: modes.length,
        separatorBuilder: (_, _) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          final bool selected = index == selectedIndex;

          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  modes[index],
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFFD4AF37)
                        : Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: selected ? 42 : 0,
                  height: 3,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
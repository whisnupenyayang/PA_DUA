import 'package:flutter/material.dart';

class IklanBanner extends StatelessWidget {
  const IklanBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> iklanList = [
  {
    'image': 'assets/images/iklan1.png',
    'title': 'Pupuk organik terbaik untuk tanaman kopi',
  },
  {
    'image': 'assets/images/iklan2.jpg',
    'title': 'Pupuk alami ramah lingkungan',
  },
  {
    'image': 'assets/images/iklan2.jpg',
    'title': 'Pupuk alami ramah lingkungan2',
  },
];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilihan Pupuk Terbaik!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: iklanList.length,
            itemBuilder: (context, index) {
              final iklan = iklanList[index];
              return Container(
                width: 300,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        iklan['image']!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                            iklan['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


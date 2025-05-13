import 'package:flutter/material.dart';
import 'package:markopi/service/iklan_service.dart';
import 'package:markopi/models/iklan.dart';

class IklanBanner extends StatefulWidget {
  const IklanBanner({super.key});

  @override
  State<IklanBanner> createState() => _IklanBannerState();
}

class _IklanBannerState extends State<IklanBanner> {
  late Future<List<Iklan>> _iklanList;

  @override
  void initState() {
    super.initState();
    _iklanList = IklanService.getAllIklan();
  }

  @override
  Widget build(BuildContext context) {
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
          child: FutureBuilder<List<Iklan>>(
            future: _iklanList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Tidak ada data iklan.'));
              } else {
                final iklanList = snapshot.data!;
                return ListView.builder(
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
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            iklan.gambar != null && iklan.gambar.isNotEmpty
                                ? Image.network(
                                    iklan.gambar,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image, size: 50),
                                  )
                                : const Icon(Icons.store, size: 50),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                color: Colors.black.withOpacity(0.5),
                                child: Text(
                                  iklan.judulIklan,
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
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

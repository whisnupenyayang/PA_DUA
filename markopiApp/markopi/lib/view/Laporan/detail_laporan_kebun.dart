import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:markopi/service/laporan_service.dart';
import 'package:markopi/models/laporan_kebun.dart';

class LaporanDetailPage extends StatefulWidget {
  final int idKebun;
  final String title;

  const LaporanDetailPage(
      {Key? key, required this.idKebun, required this.title})
      : super(key: key);

  @override
  State<LaporanDetailPage> createState() => _LaporanDetailPageState();
}

class _LaporanDetailPageState extends State<LaporanDetailPage> {
  late Future<LaporanDetailKebunModel> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = LaporanService.getLaporanById(widget.idKebun);
  }

  String formatCurrency(num value) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(value);
  }

  String convertBulanToYearMonth(String bulan) {
    try {
      DateTime date = DateFormat("MMMM yyyy", "en_US").parse(bulan);
      
      return DateFormat("yyyy-MM").format(date);
    } catch (e) {
      return bulan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: FutureBuilder<LaporanDetailKebunModel>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.laporanDetail.isEmpty) {
            return const Center(child: Text('Tidak ada data detail laporan.'));
          }

          final detailData = snapshot.data!;
          final laporanList = detailData.laporanDetail;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailData.namaKebun,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...laporanList.map((laporan) {
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(top: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            convertBulanToYearMonth(laporan.bulan),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Hasil Produktivitas'),
                              Text(
                                formatCurrency(laporan.hasilProduktivitas),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total pendapatan'),
                              Text(formatCurrency(laporan.pendapatan)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total pengeluaran'),
                              Text(formatCurrency(laporan.pengeluaran)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

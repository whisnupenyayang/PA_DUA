import 'package:flutter/material.dart';

class LaporanPageView extends StatefulWidget {
  const LaporanPageView({super.key});

  @override
  State<LaporanPageView> createState() => _LaporanPageViewState();
}

class _LaporanPageViewState extends State<LaporanPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("laporan"),
        ),
        body: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    // Garis atas
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 15), // jarak ke kontainer tengah
                    Container(
                      width: MediaQuery.of(context).size.width * 2 / 3,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Color(0xffD4ECFF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Pendapatan',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '2.000.000',
                              style: TextStyle(
                                fontSize: 23,
                                color: Color(0xFF0CC712),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // jarak ke garis bawah
                    // Garis bawah
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(4, 4),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kebun Robusta',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                        'Sibuea, Laguboti, Toba, Sumatera Utara'),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Detail',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Hasil Produktivitas',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Rp. 1.000.000',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Hasil Produktivitas',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Rp. 1.000.000',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Hasil Produktivitas',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Rp. 1.000.000',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

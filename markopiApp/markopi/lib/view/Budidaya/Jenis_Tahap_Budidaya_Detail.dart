import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/controllers/Budidaya_Controller.dart';
import 'package:markopi/models/JenisTahapBudidaya_Model.dart';

class JenisTahapBudidayDetailView extends StatefulWidget {
  const JenisTahapBudidayDetailView({super.key});

  @override
  State<JenisTahapBudidayDetailView> createState() =>
      _JenisTahapBudidayDetailViewState();
}

class _JenisTahapBudidayDetailViewState
    extends State<JenisTahapBudidayDetailView> {
  final BudidayaController budidayaC = Get.put(BudidayaController());

  int? id;

  @override
  void initState() {
    super.initState();
    try {
      print('owkw');
      id = int.tryParse(Get.parameters['id'] ?? '');
    } catch (e) {
      print('owkw');
      id = null;
    }

    if (id != null) {
      budidayaC.jenisTahapBudidayaDetail.value =
          budidayaC.jenisTahapBudidayaDetail.value = JenisTahapBudidaya.empty();
      budidayaC.fetchJenisTahapBudidayaDetail(id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("ID tidak valid")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Jenis Tahap Budidaya"),
      ),
      body: Obx(() {
        final item = budidayaC.jenisTahapBudidayaDetail.value;

        // loading state
        if (item.id == 0) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  item.judul,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 21),
                Container(
                  height: 181,
                  color: Colors.grey,
                ),
                SizedBox(height: 14),
                Text(
                  item.deskripsi ?? '-',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 14),
                Container(
                  height: 186,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

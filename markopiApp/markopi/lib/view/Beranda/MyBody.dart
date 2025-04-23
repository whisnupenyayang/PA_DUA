import 'package:flutter/material.dart';
import 'package:markopi/controllers/Artikel_Controller.dart';
import './MainMenu.dart';
import 'package:markopi/models/Artikel_Model.dart';
import 'package:get/get.dart';
import 'weather_service.dart';
import 'package:geolocator/geolocator.dart';

class BerandaBody extends StatefulWidget {
  const BerandaBody({super.key});

  @override
  State<BerandaBody> createState() => _BerandaBodyState();
}

class _BerandaBodyState extends State<BerandaBody> {
  final ArtikelController artikelC = Get.put(ArtikelController());
  final WeatherService weatherService = WeatherService();
  Map<String, dynamic> weatherData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Layanan lokasi tidak aktif');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        print('Izin lokasi ditolak');
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _fetchWeatherData(position.latitude, position.longitude);
  }

  void _fetchWeatherData(double latitude, double longitude) async {
    try {
      var data = await weatherService.getWeatherDataByCoordinates(latitude, longitude);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            isLoading ? Center(child: CircularProgressIndicator()) : buildWeatherCard(weatherData),
            SizedBox(height: 30),
            MainMenu(),
            SizedBox(height: 30),
            buildHorizontalListView(),
          ],
        ),
      ),
    );
  }

  Widget buildWeatherCard(Map<String, dynamic> weatherData) {
    var mainWeather = weatherData['main'];
    var weatherDesc = weatherData['weather'][0]['description'];
    var temperature = mainWeather['temp'];
    var cityName = weatherData['name'];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flash_on, size: 64, color: Colors.orange),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$temperature°C', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(weatherDesc, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Cuaca di $cityName', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ],
              )
            ],
          ),
          SizedBox(height: 20),
          Divider(),
        ],
      ),
    );
  }

  Widget buildHorizontalListView() {
    return Obx(() {
      if (artikelC.artikel.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      List<Artikel> firstFourArtikels = artikelC.artikel.take(4).toList();
      return Container(
        height: 257,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(firstFourArtikels.length, (index) {
              Artikel artikel = firstFourArtikels[index];
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 257,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 148,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          image: artikel.imageUrls.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(artikel.imageUrls.first),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 46,
                        width: 268,
                        margin: EdgeInsets.all(13),
                        child: Text(
                          artikel.judulArtikel,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    });
  }
}

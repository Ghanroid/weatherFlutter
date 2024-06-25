import 'dart:convert';
import 'dart:ui';
import 'package:weather/secrets.dart';

import 'forecast_card.dart';
import 'package:flutter/material.dart';
import 'weatheradditional_info.dart';
import 'package:http/http.dart' as http;

class WeatherStateful extends StatefulWidget {
  const WeatherStateful({super.key});

  @override
  State<WeatherStateful> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherStateful> {
  @override
  void initState() {
    super.initState();
    getApiData();
  }

  Future<Map<String, dynamic>> getApiData() async {
    String loco = 'London';
    try {
      final res = await http.get(Uri.parse(
          "http://api.openweathermap.org/data/2.5/forecast?q=$loco&APPID=$myapi"));
      final data = jsonDecode(res.body);
      //print(res.body);
      if (data['cod'] != '200') {
        throw '200 bad request hehehehehe';
      }
      //final maintemp = data['list'][0]['main']['temp'];
      //print(maintemp);
      return data;
    } catch (e) {
      throw e
          .toString(); //acc to me this will be caught at hasError of connectionState--(FutureBulider)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                print("pressed");
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder(
        future: getApiData(),
        builder: (context, snapshot) {
          // print(snapshot);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          //here there is no to rebuild the function Future Builder() it automatically do this GREAT FEATURE OF FLUTTER
          final tem = snapshot.data!['list'][0]['main']['temp'].toString();

          final sky =
              snapshot.data!['list'][0]['weather'][0]['main'].toString();

          print(sky);

          //final tem1 = tem.toString();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            //with this we get the blur effect but not a proper border so we have another wiget called clipRRect that gives us BorderRaduis
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      '$tem K',
                                      style: TextStyle(
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Icon(
                                      sky == "Clouds"
                                          ? Icons.cloud
                                          : Icons.sunny,
                                      size: 80,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("$sky",
                                        style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Weather Forecast",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ForecastCards(
                            ic: Icons.cloud, time: '09:00 ', contities: '200'),
                        ForecastCards(
                            ic: Icons.cloud, time: '10:00 ', contities: '300'),
                        ForecastCards(
                            ic: Icons.cloud, time: '12:00 ', contities: '400'),
                        ForecastCards(
                            ic: Icons.cloud, time: '01:00 ', contities: '300'),
                        ForecastCards(
                            ic: Icons.cloud, time: '2:00 ', contities: '200'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Additional Information",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: Padding(
                      //     padding: EdgeInsets.all(16.0),
                      //     child: Column(
                      //       children: [
                      //         Icon(
                      //           Icons.water_drop,
                      //           size: 32,
                      //         ),
                      //         Text('Humidity'),
                      //         Text(
                      //           '94',
                      //           style: TextStyle(
                      //               fontWeight: FontWeight.bold, fontSize: 22),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      /*above is also ok using expanded there is a easy trick inside row use the mainaxisalignment to spacearound */

                      AddyInfo(
                        ic: Icons.water_drop,
                        name: 'humidity',
                        tem: '43',
                      ),

                      AddyInfo(
                        ic: Icons.air,
                        name: 'Wind Speed',
                        tem: '20',
                      ),

                      AddyInfo(
                        ic: Icons.water_drop,
                        name: 'Pressure',
                        tem: '50',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

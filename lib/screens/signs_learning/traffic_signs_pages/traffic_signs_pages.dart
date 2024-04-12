import 'package:flutter/material.dart';
import 'package:gplx/services/asset_services.dart';

import '../../../data/helper/database_helper.dart';
import '../../../data/models/traffic_signs.dart';

class TrafficSignsPage extends StatelessWidget{
  int trafficSignsCategoryID;
  TrafficSignsPage({super.key, required this.trafficSignsCategoryID });


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<TrafficSigns>>(
        future: DatabaseHelper().getListTrafficSignsByType(trafficSignsCategoryID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<TrafficSigns>? trafficSignsList = snapshot.data;
            if (trafficSignsList == null || trafficSignsList.isEmpty) {
              return const Center(
                child: Text('No traffic signs available.'),
              );
            } else {
              return ListView.builder(
                itemCount: trafficSignsList.length,
                itemBuilder: (context, index) {
                  TrafficSigns trafficSign = trafficSignsList[index];
                  return ListTile(
                    title: Text(trafficSign.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text(trafficSign.description),
                    leading: Image.asset(
                      AssetServices.assetTrafficSignsImagesPath+trafficSign.images,
                      width: 90,
                      height: 90,
                      fit: BoxFit.contain,
                    ),
                    onTap: () {
                      // Handle tap on traffic sign tile
                    },
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
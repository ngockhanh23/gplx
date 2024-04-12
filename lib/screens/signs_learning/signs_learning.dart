import 'package:flutter/material.dart';
import 'package:gplx/screens/signs_learning/traffic_signs_pages/traffic_signs_pages.dart';
import 'package:gplx/services/color_services.dart';

class SignsLearning extends StatelessWidget{
  final List<Widget> _tabs = [
    Tab(text: 'Biển báo cấm'),
    Tab(text: 'Biển báo hiệu lệnh'),
    Tab(text: 'Biển báo chỉ dẫn'),
    Tab(text: 'Biển báo nguy hiểm & cảnh báo'),
    Tab(text: 'Biển báo phụ'),
  ];


  final List<Widget> _tabViews = [
    TrafficSignsPage(trafficSignsCategoryID: 1),
    TrafficSignsPage(trafficSignsCategoryID: 2),
    TrafficSignsPage(trafficSignsCategoryID: 3),
    TrafficSignsPage(trafficSignsCategoryID: 4),
    TrafficSignsPage(trafficSignsCategoryID: 5),

  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length, // Số lượng tab
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Biển báo'),
          bottom: TabBar(
            isScrollable: true,
            dividerColor: ColorServices.primaryColor,
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _tabViews,
        ),
      ),
    );
  }
}
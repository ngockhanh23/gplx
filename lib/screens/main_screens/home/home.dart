import 'package:flutter/material.dart';
import 'package:gplx/services/asset_services.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("GPLX"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.count(

          crossAxisCount: 2,
          children: [
            GridItemWidget(
                context,
                AssetServices.assetIconPngPath + 'ly_thuyet.png',
                "Lý thuyết",
                '/learning-theogry'),
            GridItemWidget(
                context,
                AssetServices.assetIconPngPath + 'thi_sat_hach.png',
                "Thi sát hạch",
                '/test'),
            GridItemWidget(context,
                AssetServices.assetIconPngPath + 'meo_thi.png',
                "Mẹo thi",
                '/test-tips'),
            GridItemWidget(context,
                AssetServices.assetIconPngPath + 'bien_bao.png',
                "Biển báo",
                '/signs-learning'),
            GridItemWidget(
                context,
                AssetServices.assetIconPngPath + 'tra_cuu_luat.png',
                "Tra cứu luật",
                '/laws'),
            GridItemWidget(
                context,
                AssetServices.assetIconPngPath + 'cau_sai.png',
                "Các câu sai",
                '/wrong-questions'),
          ],
        ),
      ),
    );
  }

  Widget GridItemWidget(
      BuildContext context, String imgIcon, String title, String routeString) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, routeString);
      },
      child: Card(
        // color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgIcon,
              width: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 20,),
            ),
          ],
        ),
      ),
    );
  }
}

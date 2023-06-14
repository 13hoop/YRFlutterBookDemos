import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EmptyPage extends StatelessWidget {
  final Function onTap;

  const EmptyPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.web_asset_off_sharp,
              size: 180,
              color: Colors.black12,
            ),
            Text('没有数据'),
            SizedBox(
              height: 130,
            ),
            OutlinedButton.icon(
                // style: ButtonStyle(),
                onPressed: () {
                  onTap;
                },
                icon: Icon(Icons.sync),
                label: Text('重试')),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'views/screen/home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => HomePage(),
    },
  ));
}

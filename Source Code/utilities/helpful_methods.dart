import 'package:url_launcher/url_launcher.dart';

void launchURLWithoutCheck(String url) async {
  print(url);
  await launch(url);
}
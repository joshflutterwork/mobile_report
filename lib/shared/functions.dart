part of 'shareds.dart';

Future<String?> networkImageToBase64(String imageUrl) async {
  Response response = await get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  return base64Encode(bytes);
}

// downloadHandler(String url) async {
//   showBotToastText('$url');
//   final status = await Permission.storage.request();
//   if (status.isGranted) {
//     final externalDir = await getExternalStorageDirectory();
//     await FlutterDownloader.enqueue(
//       url: url,
//       savedDir: externalDir!.path,
//       fileName: "Bintoro",
//       showNotification: true,
//       openFileFromNotification: true,
//     );
//   }
// }

bool decideWhichDayToEnable(DateTime day) {
  if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
      day.isBefore(DateTime.now().add(Duration(days: 90))))) {
    return true;
  }
  return false;
}

String generateUniqueFileName({String prefix = '_photo'}) {
  DateTime now = DateTime.now();
  String timestamp = now.millisecondsSinceEpoch.toString();
  return '$prefix$timestamp.png';
}

import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-8466260290776430/8670466045';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-8466260290776430/9018978075';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

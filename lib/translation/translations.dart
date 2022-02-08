import 'package:get/get.dart';
import 'package:kick74/translation/ar.dart';
import 'package:kick74/translation/en.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'ar': ar
  };
}
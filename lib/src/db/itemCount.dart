import 'package:coding_challenge_from_kriya/src/db/dbProvider.dart';
import 'package:coding_challenge_from_kriya/src/models/sampleModels.dart';

class CartCount {
  static int count = 0;

  static totalCount(String title) async {
    if (title != null) {
      List<Sample> list = await DBProvider.db.getListCart(title);
      count = list.length;
    }
  }
}

import 'package:shopping/constant/constant.dart';
import 'package:shopping/modal/itemmodal.dart';

void addToFavorites(Producktmodal item) {
  int index = favoriteItems.indexWhere((element) => element.id == item.id);

  if (index == -1) {
    favoriteItems.add(item);
    favoriteItemscounts.add(1);
  } else {
    favoriteItemscounts[index]++;
  }
}

void removeFromFavorites(Producktmodal item) {
  int index = favoriteItems.indexWhere((element) => element.id == item.id);

  if (index != -1) {
    favoriteItems.removeAt(index);
    favoriteItemscounts.removeAt(index);
  }
}

void increaseItemCount(Producktmodal item) {
  int index = favoriteItems.indexWhere((element) => element.id == item.id);
  if (index != -1) {
    favoriteItemscounts[index]++;
  }
}

// تقليل عدد منتج
void decreaseItemCount(Producktmodal item) {
  int index = favoriteItems.indexWhere((element) => element.id == item.id);
  if (index != -1 && favoriteItemscounts[index] > 1) {
    favoriteItemscounts[index]--;
  } else if (index != -1) {
    removeFromFavorites(item); // إذا أصبح العدد 0، احذف المنتج
  }
}



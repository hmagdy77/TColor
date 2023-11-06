extension PowerString on String {
  String maxLength(int lenth) {
    if (length > lenth) {
      return '${substring(0, lenth)}..';
    } else {
      return this;
    }
  }

  String maxLengthWithOutDots(int lenth) {
    if (length > lenth) {
      return substring(0, lenth);
    } else {
      return this;
    }
  }

  String firstThreeWords() {
    int? startIndex = 0, indexOfSpace;

    for (int i = 0; i < 3; i++) {
      indexOfSpace = indexOf(' ', startIndex!);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return this;
      }
      startIndex = indexOfSpace + 1;
    }

    return '${substring(0, indexOfSpace!)}...';
  }

  String firstWord() {
    int? startIndex = 0, indexOfSpace;

    for (int i = 0; i < 2; i++) {
      indexOfSpace = indexOf(' ', startIndex!);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return this;
      }
      startIndex = indexOfSpace + 1;
    }

    return '${substring(0, indexOfSpace!)}...';
  }
}

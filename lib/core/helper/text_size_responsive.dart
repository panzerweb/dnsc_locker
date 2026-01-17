/*
  A helper function for a responsive text base on text length
  
  Useful for managing font sizes between different lengths

  Sample usage:
    // Data (safe for long text)
    Expanded(
      child: Text(
        data,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: TextSizeResponsive.fontSizeForData(data),
          color: Palette.lightShadePrimary,
          fontWeight: FontWeight.bold,
          height: 1.2,
        ),
      ),
    ),
*/

class TextSizeResponsive {
  static double fontSizeForData(String text) {
    final length = text.length;

    if (length <= 6) {
      return 32;
    } else if (length <= 12) {
      return 26;
    } else {
      return 20;
    }
  }
}

class GetInitials {
  static String getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}

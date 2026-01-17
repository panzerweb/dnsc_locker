class DnscEmailValidator {
  static String? dnscEmailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }

    final email = value.trim();

    final dnscEmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@dnsc\.edu\.ph$');

    if (!dnscEmailRegex.hasMatch(email)) {
      return 'Please use your DNSC email (@dnsc.edu.ph)';
    }

    return null;
  }
}

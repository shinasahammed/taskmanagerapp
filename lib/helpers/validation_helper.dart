class ValidatorHelper {
  static String? validateTaskTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Title is required';
    }
    return null;
  }
}

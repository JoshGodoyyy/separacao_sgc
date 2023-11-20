class CapitalizeText {
  static String capitalizeFirstLetter(String input) {
    input.toLowerCase();
    return input[0].toUpperCase() + input.substring(1);
  }
}

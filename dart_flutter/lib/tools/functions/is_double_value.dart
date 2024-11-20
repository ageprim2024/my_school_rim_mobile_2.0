
bool isDoubleValue(String value) {
    // Utiliser double.tryParse pour vérifier si la chaîne est un double
    double? parsedValue = double.tryParse(value);
    return parsedValue != null;
  }
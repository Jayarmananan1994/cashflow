String formatCurrency(int value) {
  String formattedValue = value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );

  return '\$$formattedValue';
}

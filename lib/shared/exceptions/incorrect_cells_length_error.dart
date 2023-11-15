class IncorrectCellsLengthError extends Error {
  IncorrectCellsLengthError();

  @override
  String toString() {
    return 'Incorrect cells length: The cells list length differs from the column names list';
  }
}

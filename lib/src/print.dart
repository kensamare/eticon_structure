///Print to console red
void printRed(String text) {
  print('\x1B[31m$text\x1B[0m');
}

///Print to console green
void printGreen(String text) {
  print('\x1B[92m$text\x1B[0m');
}

///Print to console Yellow
void printYellow(String text) {
  print('\x1b[33m$text\x1B[0m');
}

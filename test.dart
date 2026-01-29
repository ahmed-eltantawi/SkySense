class Leap {
  // Put your code here
  bool leapYear(int year) {
    if (year % 400 == 0) {
      return true;
    } else if (year % 100 == 0) {
      return false;
    }
    return year % 4 == 0;
  }
}

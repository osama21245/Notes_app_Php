validunput(String val, int min, int max) {
  if (val.length > max) {
    return "Thats field can't be larger than $max letter";
  }

  if (val.isEmpty) {
    return "Thats field can't be Empty";
  }
  if (val.length < min) {
    return "Thats field can't be smaller than $min letter";
  }
}

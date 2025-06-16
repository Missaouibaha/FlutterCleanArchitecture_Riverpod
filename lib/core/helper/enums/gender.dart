enum Gender {
  male(0, "Male"),
  female(1, "Female");

  final int gederValue;
  final String genderName;
  const Gender(this.gederValue, this.genderName);
}

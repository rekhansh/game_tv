class User{
  String name;
  String imgURL;
  int eloPoints;
  int tournamentsPlayed;
  int tournamentsWon;

  User(String name, String imgURL, int eloPoints, int tournamentsPlayed,
      int tournamentsWon){
    this.name = name;
    this.imgURL = imgURL;
    this.eloPoints = eloPoints;
    this.tournamentsPlayed = tournamentsPlayed;
    this.tournamentsWon = tournamentsWon;
  }

  int getPercentage()
  {
    return ((tournamentsWon/tournamentsPlayed)*100).toInt();
  }
}
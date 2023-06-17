class VideoCategory {
  late String title;
  late int category;

  VideoCategory({required this.title, required this.category});

  VideoCategory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    category = json['category'];
  }
}

class PlayerModels {
  PlayerProfile? playerProfile;
  TeamProfile? teamProfile;
  // StatAverage? statAverage;
  StatTotal? statTotal;
  String? rank;

  PlayerModels(
      {this.playerProfile,
      this.teamProfile,
      // this.statAverage,
      this.statTotal,
      this.rank});

  PlayerModels.fromJson(Map<String, dynamic> json) {
    playerProfile = json['playerProfile'] != null
        ? new PlayerProfile.fromJson(json['playerProfile'])
        : null;
    teamProfile = json['teamProfile'] != null
        ? new TeamProfile.fromJson(json['teamProfile'])
        : null;
    // statAverage = json['statAverage'] != null
    //     ? new StatAverage.fromJson(json['statAverage'])
    //     : null;
    // statTotal = json['statTotal'] != null
    //     ? new StatTotal.fromJson(json['statTotal'])
    //     : null;
    rank = json['rank'];
  }
}

class PlayerProfile {
  String? code;
  String? country;
  String? countryEn;
  String? displayAffiliation;
  String? displayName;
  String? displayNameEn;
  String? dob;
  String? draftYear;
  String? experience;
  String? firstInitial;
  String? firstName;
  String? firstNameEn;
  String? height;
  String? jerseyNo;
  String? lastName;
  String? lastNameEn;
  String? leagueId;
  String? playerId;
  String? position;
  String? schoolType;
  String? weight;

  PlayerProfile(
      {this.code,
      this.country,
      this.countryEn,
      this.displayAffiliation,
      this.displayName,
      this.displayNameEn,
      this.dob,
      this.draftYear,
      this.experience,
      this.firstInitial,
      this.firstName,
      this.firstNameEn,
      this.height,
      this.jerseyNo,
      this.lastName,
      this.lastNameEn,
      this.leagueId,
      this.playerId,
      this.position,
      this.schoolType,
      this.weight});

  PlayerProfile.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    country = json['country'];
    countryEn = json['countryEn'];
    displayAffiliation = json['displayAffiliation'];
    displayName = json['displayName'];
    displayNameEn = json['displayNameEn'];
    dob = json['dob'];
    draftYear = json['draftYear'];
    experience = json['experience'];
    firstInitial = json['firstInitial'];
    firstName = json['firstName'];
    firstNameEn = json['firstNameEn'];
    height = json['height'];
    jerseyNo = json['jerseyNo'];
    lastName = json['lastName'];
    lastNameEn = json['lastNameEn'];
    leagueId = json['leagueId'];
    playerId = json['playerId'];
    position = json['position'];
    schoolType = json['schoolType'];
    weight = json['weight'];
  }
}

class TeamProfile {
  String? abbr;
  String? city;
  String? cityEn;
  String? code;
  String? conference;
  String? displayAbbr;
  String? displayConference;
  String? division;
  String? id;
  bool? isAllStarTeam;
  bool? isLeagueTeam;
  String? leagueId;
  String? name;
  String? nameEn;

  TeamProfile(
      {this.abbr,
      this.city,
      this.cityEn,
      this.code,
      this.conference,
      this.displayAbbr,
      this.displayConference,
      this.division,
      this.id,
      this.isAllStarTeam,
      this.isLeagueTeam,
      this.leagueId,
      this.name,
      this.nameEn});

  TeamProfile.fromJson(Map<String, dynamic> json) {
    abbr = json['abbr'];
    city = json['city'];
    cityEn = json['cityEn'];
    code = json['code'];
    conference = json['conference'];
    displayAbbr = json['displayAbbr'];
    displayConference = json['displayConference'];
    division = json['division'];
    id = json['id'];
    isAllStarTeam = json['isAllStarTeam'];
    isLeagueTeam = json['isLeagueTeam'];
    leagueId = json['leagueId'];
    name = json['name'];
    nameEn = json['nameEn'];
  }
}

class StatAverage {
  double? assistsPg;
  double? blocksPg;
  double? defRebsPg;
  double? efficiency;
  double? fgaPg;
  double? fgmPg;
  double? fgpct;
  double? foulsPg;
  double? ftaPg;
  double? ftmPg;
  double? ftpct;
  double? games;
  double? gamesStarted;
  double? minsPg;
  double? offRebsPg;
  double? pointsPg;
  double? rebsPg;
  double? stealsPg;
  double? tpaPg;
  double? tpmPg;
  double? tppct;
  double? turnoversPg;

  StatAverage(
      {this.assistsPg,
      this.blocksPg,
      this.defRebsPg,
      this.efficiency,
      this.fgaPg,
      this.fgmPg,
      this.fgpct,
      this.foulsPg,
      this.ftaPg,
      this.ftmPg,
      this.ftpct,
      this.games,
      this.gamesStarted,
      this.minsPg,
      this.offRebsPg,
      this.pointsPg,
      this.rebsPg,
      this.stealsPg,
      this.tpaPg,
      this.tpmPg,
      this.tppct,
      this.turnoversPg});

  StatAverage.fromJson(Map<String, dynamic> json) {
    assistsPg = json['assistsPg'];
    blocksPg = json['blocksPg'];
    defRebsPg = json['defRebsPg'];
    efficiency = json['efficiency'];
    fgaPg = json['fgaPg'];
    fgmPg = json['fgmPg'];
    fgpct = json['fgpct'];
    foulsPg = json['foulsPg'];
    ftaPg = json['ftaPg'];
    ftmPg = json['ftmPg'];
    ftpct = json['ftpct'];
    games = json['games'];
    gamesStarted = json['gamesStarted'];
    minsPg = json['minsPg'];
    offRebsPg = json['offRebsPg'];
    pointsPg = json['pointsPg'];
    rebsPg = json['rebsPg'];
    stealsPg = json['stealsPg'];
    tpaPg = json['tpaPg'];
    tpmPg = json['tpmPg'];
    tppct = json['tppct'];
    turnoversPg = json['turnoversPg'];
  }
}

class StatTotal {
  int? assists;
  int? blocks;
  int? defRebs;
  double? efficiency;
  int? fga;
  int? fgm;
  double? fgpct;
  int? fouls;
  int? fta;
  int? ftm;
  double? ftpct;
  int? mins;
  int? offRebs;
  int? points;
  int? rebs;
  int? secs;
  int? steals;
  int? technicalFouls;
  int? tpa;
  int? tpm;
  int? tppct;
  int? turnovers;

  StatTotal(
      {this.assists,
      this.blocks,
      this.defRebs,
      this.efficiency,
      this.fga,
      this.fgm,
      this.fgpct,
      this.fouls,
      this.fta,
      this.ftm,
      this.ftpct,
      this.mins,
      this.offRebs,
      this.points,
      this.rebs,
      this.secs,
      this.steals,
      this.technicalFouls,
      this.tpa,
      this.tpm,
      this.tppct,
      this.turnovers});

  StatTotal.fromJson(Map<String, dynamic> json) {
    assists = json['assists'];
    blocks = json['blocks'];
    defRebs = json['defRebs'];
    efficiency = json['efficiency'];
    fga = json['fga'];
    fgm = json['fgm'];
    fgpct = json['fgpct'];
    fouls = json['fouls'];
    fta = json['fta'];
    ftm = json['ftm'];
    ftpct = json['ftpct'];
    mins = json['mins'];
    offRebs = json['offRebs'];
    points = json['points'];
    rebs = json['rebs'];
    secs = json['secs'];
    steals = json['steals'];
    technicalFouls = json['technicalFouls'];
    tpa = json['tpa'];
    tpm = json['tpm'];
    tppct = json['tppct'];
    turnovers = json['turnovers'];
  }
}

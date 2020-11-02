class Gender {
  int id;
  String gender;

  Gender(this.id, this.gender);
  static List<Gender> getCompanies() {
    return <Gender>[
      Gender(1, 'Male'),
      Gender(2, 'Female'),

    ];
  }
}
class FirstVoterUser {
  int id;
  String type;

  FirstVoterUser(this.id, this.type);
  static List<FirstVoterUser> getCompanies() {
    return <FirstVoterUser>[

      FirstVoterUser(1, 'First time'),
      FirstVoterUser(2, 'No'),

    ];
  }
}
class Politics {
  int id;
  String name;

  Politics(this.id, this.name);
  static List<Politics> getCompanies() {
    return <Politics>[

      Politics(1, 'BJP'),
      Politics(2, 'Congress'),
      Politics(3, 'Other'),
    ];
  }
}
class Eduoption {
  int id;
  String name;
  Eduoption(this.id, this.name);
  static List<Eduoption> getCompanies() {
    return <Eduoption>[

      Eduoption(1, 'BCA'),
      Eduoption(2, 'MCA'),
      Eduoption(3, 'MSC'),
    ];
  }
}
class Incomecheck {
  int id;
  String slot;

  Incomecheck(this.id, this.slot);
  static List<Incomecheck> getCompanies() {
    return <Incomecheck>[

      Incomecheck(1, '<5,000'),
      Incomecheck(2, '<10,000'),
    ];
  }
}
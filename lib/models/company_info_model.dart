class CompanyInfo {
  final double? capital;
  final Company company;
  final double? dps;
  final double? eps;
  final String name;
  final double price;
  final int? shares;

  CompanyInfo(this.capital, this.name, this.price, this.shares, this.company,
      this.dps, this.eps);

  CompanyInfo.fromJson(Map json)
      : capital = json['capital'],
        name = json['name'],
        price = json['price'],
        shares = json['shares'],
        company = Company.fromJson(json['company']),
        dps = json['dps'],
        eps = json['eps'];

  Map toJson() {
    return {
      'capital': capital,
      'name': name,
      'price': price,
      'shares': shares,
      'company': company,
      'dps': dps,
      'eps': eps
    };
  }
}

class Company {
  final String? address;
  final List<Director> directors;
  final String? email;
  final String? facsimile;
  final String? industry;
  final String name;
  final String? sector;
  final String? telephone;
  final String? website;

  Company(this.name, this.address, this.directors, this.email, this.facsimile,
      this.industry, this.sector, this.telephone, this.website);

  Company.fromJson(Map json)
      : address = json['address'],
        directors = (json['directors'] as List)
            .map((i) => Director.fromJson(i))
            .toList(),
        email = json['email'],
        facsimile = json['facsimile'],
        website = json['website'],
        industry = json['industry'],
        sector = json['sector'],
        name = json['name'],
        telephone = json['telephone'];

  Map toJson() {
    return {
      'address': address,
      'directors': directors,
      'email': email,
      'facsimile': facsimile,
      'website': website,
      'industry': industry,
      'sector': sector,
      'name': name,
      'telephone': telephone,
    };
  }
}

class Director {
  String? position;
  String name;

  Director(
    this.position,
    this.name,
  );

  Director.fromJson(Map json)
      : position = json['position'],
        name = json['name'];

  Map toJson() {
    return {
      'position': position,
      'name': name,
    };
  }
}

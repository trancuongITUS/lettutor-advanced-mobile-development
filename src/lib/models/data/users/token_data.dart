class TokenDataDetail {
  String? token;
  String? expires;

  TokenDataDetail({
    this.token,
    this.expires,
  });

  TokenDataDetail.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'expires': expires,
  };
}

class TokenData {
  TokenDataDetail? access;
  TokenDataDetail? refresh;

  TokenData.fromJson(Map<String, dynamic> json) {
    access = TokenDataDetail.fromJson(json['access']);
    refresh = TokenDataDetail.fromJson(json['refresh']);
  }

  Map<String, dynamic> toJson() => {
    'access': access?.toJson(),
    'refresh': refresh?.toJson(),
  };
}
class WeatherModel {
  int? count;
  List<Data>? data;

  WeatherModel({this.count, this.data});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  double? appTemp;
  int? aqi;
  String? cityName;
  int? clouds;
  String? countryCode;
  String? datetime;
  double? dewpt;
  double? dhi;
  double? dni;
  double? elevAngle;
  double? ghi;
  Null? gust;
  int? hAngle;
  double? lat;
  double? lon;
  String? obTime;
  String? pod;
  Null? precip;
  double? pres;
  int? rh;
  int? slp;
  Null? snow;
  double? solarRad;
  List<String>? sources;
  String? stateCode;
  String? station;
  String? sunrise;
  String? sunset;
  int? temp;
  String? timezone;
  int? ts;
  double? uv;
  int? vis;
  Weather? weather;
  String? windCdir;
  String? windCdirFull;
  int? windDir;
  double? windSpd;

  Data(
      {this.appTemp,
      this.aqi,
      this.cityName,
      this.clouds,
      this.countryCode,
      this.datetime,
      this.dewpt,
      this.dhi,
      this.dni,
      this.elevAngle,
      this.ghi,
      this.gust,
      this.hAngle,
      this.lat,
      this.lon,
      this.obTime,
      this.pod,
      this.precip,
      this.pres,
      this.rh,
      this.slp,
      this.snow,
      this.solarRad,
      this.sources,
      this.stateCode,
      this.station,
      this.sunrise,
      this.sunset,
      this.temp,
      this.timezone,
      this.ts,
      this.uv,
      this.vis,
      this.weather,
      this.windCdir,
      this.windCdirFull,
      this.windDir,
      this.windSpd});

  Data.fromJson(Map<String, dynamic> json) {
    appTemp = json['app_temp'];
    aqi = json['aqi'];
    cityName = json['city_name'];
    clouds = json['clouds'];
    countryCode = json['country_code'];
    datetime = json['datetime'];
    dewpt = json['dewpt'];
    dhi = json['dhi'];
    dni = json['dni'];
    elevAngle = json['elev_angle'];
    ghi = json['ghi'];
    gust = json['gust'];
    hAngle = json['h_angle'];
    lat = json['lat'];
    lon = json['lon'];
    obTime = json['ob_time'];
    pod = json['pod'];
    precip = json['precip'];
    pres = json['pres'];
    rh = json['rh'];
    slp = json['slp'];
    snow = json['snow'];
    solarRad = json['solar_rad'];
    sources = json['sources'].cast<String>();
    stateCode = json['state_code'];
    station = json['station'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    temp = json['temp'];
    timezone = json['timezone'];
    ts = json['ts'];
    uv = json['uv'];
    vis = json['vis'];
    weather =
        json['weather'] != null ? Weather.fromJson(json['weather']) : null;
    windCdir = json['wind_cdir'];
    windCdirFull = json['wind_cdir_full'];
    windDir = json['wind_dir'];
    windSpd = json['wind_spd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_temp'] = appTemp;
    data['aqi'] = aqi;
    data['city_name'] = cityName;
    data['clouds'] = clouds;
    data['country_code'] = countryCode;
    data['datetime'] = datetime;
    data['dewpt'] = dewpt;
    data['dhi'] = dhi;
    data['dni'] = dni;
    data['elev_angle'] = elevAngle;
    data['ghi'] = ghi;
    data['gust'] = gust;
    data['h_angle'] = hAngle;
    data['lat'] = lat;
    data['lon'] = lon;
    data['ob_time'] = obTime;
    data['pod'] = pod;
    data['precip'] = precip;
    data['pres'] = pres;
    data['rh'] = rh;
    data['slp'] = slp;
    data['snow'] = snow;
    data['solar_rad'] = solarRad;
    data['sources'] = sources;
    data['state_code'] = stateCode;
    data['station'] = station;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['temp'] = temp;
    data['timezone'] = timezone;
    data['ts'] = ts;
    data['uv'] = uv;
    data['vis'] = vis;
    if (weather != null) {
      data['weather'] = weather!.toJson();
    }
    data['wind_cdir'] = windCdir;
    data['wind_cdir_full'] = windCdirFull;
    data['wind_dir'] = windDir;
    data['wind_spd'] = windSpd;
    return data;
  }
}

class Weather {
  String? icon;
  String? description;
  int? code;

  Weather({this.icon, this.description, this.code});

  Weather.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    description = json['description'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['description'] = description;
    data['code'] = code;
    return data;
  }
}

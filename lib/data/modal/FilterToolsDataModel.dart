import 'dart:convert';

/// success : true
/// max_price : 120000000
/// max_size : 70001
/// location : [{"id":1,"name":"SHANKAR NAGAR"},{"id":2,"name":"TELIBANDHA"},{"id":3,"name":"MOWA-SADDU"},{"id":4,"name":"NAYA RAIPUR"},{"id":5,"name":"BHATAGOAN"},{"id":6,"name":"AMLIDIH"},{"id":7,"name":"SANTOSHI NAGAR"},{"id":8,"name":"DDU NAGAR"},{"id":9,"name":"GUDHYARI"},{"id":10,"name":"TATIBANDH"},{"id":12,"name":"GAYATRI NAGAR"},{"id":13,"name":"GEETANJALI NAGAR"},{"id":14,"name":"SECTORS"},{"id":15,"name":"VIJAY NAGAR"},{"id":16,"name":"DUBEY COLONY"},{"id":17,"name":"ADARSH NAGAR"},{"id":18,"name":"VV VIHAR COLONY"},{"id":19,"name":"DALDAL SEONI"},{"id":21,"name":"AVANI VIHAR"},{"id":22,"name":"KHAMTRAI - 2"},{"id":23,"name":"AMAN NAGAR"},{"id":24,"name":"BAZAR CHOWK"},{"id":25,"name":"GDA COLONY"},{"id":26,"name":"HOUSING BOARD COLONY"},{"id":27,"name":"ANANDAM CITY"},{"id":28,"name":"SADDU"},{"id":30,"name":"AMASIONI"},{"id":32,"name":"SARDHU"},{"id":33,"name":"CITY OF DREAMS"},{"id":34,"name":"RAWATPURA FACE - 1"},{"id":35,"name":"RAWATPURA FACE - 2"},{"id":36,"name":"DHEBER CITY"},{"id":37,"name":"NAKA CHOWK"},{"id":38,"name":"SMALL KOTA"},{"id":39,"name":"KEDUWAN NAGAR"},{"id":40,"name":"NEW CHANGORABHATA"},{"id":41,"name":"SAI VIHAR"},{"id":42,"name":"RADHASWAMI NAGAR"},{"id":43,"name":"KATHADIH"},{"id":44,"name":"PROFFESER COLONY"},{"id":45,"name":"OLD DHAMTARI ROAD"},{"id":46,"name":"BORIYA KHURD"},{"id":47,"name":"SAI SIMRAN CITY"},{"id":48,"name":"SEJBAHAR"},{"id":49,"name":"KALPVRIKSH VILLA"},{"id":50,"name":"KHOPRA"},{"id":51,"name":"BHATAGAON - 2"},{"id":52,"name":"MOTI NAGAR"},{"id":53,"name":"SHRADDA VIHAR"},{"id":54,"name":"RDA COLONY"},{"id":55,"name":"PRAGTI VIHAR"},{"id":56,"name":"PRINCE COLONY"},{"id":57,"name":"DURGA PARA"},{"id":58,"name":"MATHPURENA"},{"id":59,"name":"DATRENGA"},{"id":60,"name":"DUMARTRAI"},{"id":61,"name":"BORIA KALA"},{"id":62,"name":"TEMRI"},{"id":63,"name":"LALPUR"},{"id":64,"name":"DHARAMPURA"},{"id":65,"name":"DUNDA"},{"id":66,"name":"PRIYADARSINI NAGAR"},{"id":67,"name":"TIKRAPARA"},{"id":68,"name":"LAXMI NAGAR"},{"id":69,"name":"TAGOR NAGAR"},{"id":70,"name":"RAJENDRA NAGAR"},{"id":71,"name":"UMANG NAGAR"},{"id":72,"name":"SAILENDRA NAGAR"},{"id":73,"name":"SHYAM NAGAR"},{"id":74,"name":"GANDHI NAGAR - 1"},{"id":75,"name":"SHRINAGAR"},{"id":76,"name":"SHIVANAND NAGAR"},{"id":77,"name":"VINAYAK VIHAR COLONY"},{"id":78,"name":"EKTA NAGAR"},{"id":79,"name":"RAM NAGAR"},{"id":80,"name":"AMANAKA"},{"id":81,"name":"CHOUBEY COLONY"},{"id":82,"name":"VIRDI COLONY"},{"id":83,"name":"KOTA COLONY"},{"id":84,"name":"PARMANAND NAGAR"},{"id":85,"name":"LAKHE NAGAR"},{"id":86,"name":"PURANI BASTI"},{"id":87,"name":"DDU NAGAR"},{"id":88,"name":"SUNDER NAGAR"},{"id":89,"name":"AMAPARA"},{"id":90,"name":"SIKHSAK COLONY"},{"id":91,"name":"ROHNIPURAM"},{"id":92,"name":"SECTOR - 1"},{"id":93,"name":"GANDHI NAGAR -2"},{"id":94,"name":"PURANI BASTI"},{"id":95,"name":"MAITRI NAGAR"},{"id":96,"name":"SARONA"},{"id":97,"name":"AAZAD NAGAR"},{"id":98,"name":"KUMHARI"},{"id":99,"name":"HARSHIT NAGAR"},{"id":100,"name":"KABIR NAGAR"},{"id":101,"name":"ATARI"},{"id":102,"name":"HIRAPUR"},{"id":103,"name":"MOHBA BAZAR"},{"id":104,"name":"VIPRA NAGAR"},{"id":105,"name":"AGROHA COLONY"},{"id":106,"name":"STYAM VIHAR"},{"id":107,"name":"KARGIL CHOWK"},{"id":108,"name":"INDRAPRASTH COLONY"},{"id":109,"name":"KUSHALPUR"},{"id":110,"name":""},{"id":111,"name":"AMLESHWAR"},{"id":112,"name":"MAHADEV NAGAR"},{"id":113,"name":"JIVAN VIHAR COLONY"},{"id":114,"name":"KASHIRAM NAGAR"},{"id":115,"name":"VISHAL NAGAR COLONY"},{"id":116,"name":"JAL VIHAR COLONY"},{"id":117,"name":"SHYAM NAGAR"},{"id":118,"name":"VIDHAYAK COLONY"},{"id":119,"name":"ANAND VIHAR"},{"id":120,"name":"ANAND NAGAR"},{"id":121,"name":"MOULSHREE VIHAR"},{"id":122,"name":"DEVENDRA NAGAR  PARAS NAGAR"},{"id":123,"name":"NEW RAJENDRA NAGAR"},{"id":124,"name":"MAHAVEER NAGAR"},{"id":125,"name":"JAIHIND COLONY"},{"id":126,"name":"SHREEJI"},{"id":127,"name":"MADHUBEN COLONY"},{"id":128,"name":"BASANT VIHAR"},{"id":129,"name":""},{"id":130,"name":"JORA"},{"id":131,"name":"LABHANDI"},{"id":132,"name":"PURENA"},{"id":133,"name":"PIRDA"},{"id":134,"name":"VIP CHOWK"},{"id":135,"name":"PIRDA BASTI"},{"id":136,"name":"IAS COLONY"},{"id":137,"name":""},{"id":138,"name":"FUNDHAR"},{"id":139,"name":"TEMRI"},{"id":140,"name":"MANA"},{"id":141,"name":"DHARAMPURA"},{"id":142,"name":"SECTOR - 17"},{"id":143,"name":"SECTOR -27"},{"id":144,"name":"SECTOR -29"},{"id":145,"name":"SECTOR-28"},{"id":146,"name":"SHARDA CHOWK"},{"id":147,"name":"GHADI CHOWK"},{"id":148,"name":"PHOOL CHOWK"},{"id":149,"name":"MAUDAHAPARA"},{"id":150,"name":"SADAR BAZAR"},{"id":151,"name":"GOL BAZAR"},{"id":152,"name":"MG ROAD"},{"id":153,"name":"MALVIYA ROAD"},{"id":154,"name":"JAIL ROAD"},{"id":155,"name":"TIMBER COLONY"},{"id":156,"name":"KHAMTARAI"},{"id":157,"name":"BHANPURI"},{"id":158,"name":"WRS COLONY"},{"id":159,"name":"URLA"},{"id":160,"name":"BIRGAON"},{"id":161,"name":"NARMADA PARA"},{"id":162,"name":"KATORA TALAB"},{"id":163,"name":"PESION BADA"},{"id":164,"name":"POLICE - LINE"},{"id":165,"name":"BAIRAN BAZAR"},{"id":166,"name":"JANTA COLONY"},{"id":167,"name":"BUDHAPARA"},{"id":168,"name":"KALIBADI"},{"id":169,"name":"LILICHOWK"},{"id":170,"name":"PURANI BASTI"},{"id":172,"name":"AVANTI VIHAR "},{"id":173,"name":"MOWA "},{"id":174,"name":"KACHNA "},{"id":175,"name":"SADDU "},{"id":176,"name":"BHATAGAON "},{"id":177,"name":"SANTOSHI NAGAR "},{"id":178,"name":"DEVPURI "},{"id":179,"name":"PACHPEDI NAKA "},{"id":180,"name":"GUDYARI "},{"id":181,"name":"SAMTA COLONY "},{"id":182,"name":"DAGANIYA "},{"id":183,"name":"TATIBANDH "},{"id":184,"name":"RAIPURA "},{"id":185,"name":"MAHADEV GHAT "},{"id":186,"name":"TELIBANDHA "},{"id":187,"name":"PANDRI "},{"id":188,"name":"AMLIDIH "},{"id":189,"name":"PIRDA "},{"id":190,"name":"NAYA RAIPUR "},{"id":191,"name":"JAISTAMBH"},{"id":192,"name":"FAFDIH "},{"id":193,"name":"CIVIL LINES"},{"id":194,"name":"KALI BADI "},{"id":195,"name":"GANDHI NAGAR - 1"},{"id":196,"name":"SHRINAGAR"},{"id":197,"name":"SHIVANAND NAGAR"},{"id":198,"name":"VINAYAK VIHAR COLONY"},{"id":199,"name":"EKTA NAGAR"},{"id":200,"name":"RAM NAGAR"},{"id":201,"name":"AMANAKA"},{"id":202,"name":"CHOUBEY COLONY"},{"id":203,"name":"VIRDI COLONY"},{"id":204,"name":"KOTA COLONY"},{"id":205,"name":"PARMANAND NAGAR"},{"id":206,"name":"LAKHE NAGAR"},{"id":207,"name":"PURANI BASTI"},{"id":208,"name":"DDU NAGAR"},{"id":209,"name":"SUNDER NAGAR"},{"id":210,"name":"AMAPARA"},{"id":211,"name":"SIKHSAK COLONY"},{"id":212,"name":"ROHNIPURAM"},{"id":213,"name":"SECTOR - 1"},{"id":214,"name":"GANDHI NAGAR -2"},{"id":215,"name":"PURANI BASTI"},{"id":216,"name":"MAITRI NAGAR"},{"id":217,"name":"SARONA"},{"id":218,"name":"AAZAD NAGAR"},{"id":219,"name":"KUMHARI"},{"id":220,"name":"HARSHIT NAGAR"},{"id":221,"name":"KABIR NAGAR"},{"id":222,"name":"ATARI"},{"id":223,"name":"HIRAPUR"},{"id":224,"name":"MOHBA BAZAR"},{"id":225,"name":"VIPRA NAGAR"},{"id":226,"name":"AGROHA COLONY"},{"id":227,"name":"STYAM VIHAR"},{"id":228,"name":"KARGIL CHOWK"},{"id":229,"name":"INDRAPRASTH COLONY"},{"id":230,"name":"KUSHALPUR"},{"id":232,"name":"AMLESHWAR"},{"id":233,"name":"MAHADEV NAGAR"},{"id":234,"name":"JIVAN VIHAR COLONY"},{"id":235,"name":"KASHIRAM NAGAR"},{"id":236,"name":"VISHAL NAGAR COLONY"},{"id":237,"name":"JAL VIHAR COLONY"},{"id":238,"name":"SHYAM NAGAR"},{"id":239,"name":"VIDHAYAK COLONY"},{"id":240,"name":"ANAND VIHAR"},{"id":241,"name":"ANAND NAGAR"},{"id":242,"name":"MOULSHREE VIHAR"},{"id":243,"name":"DEVENDRA NAGAR  PARAS NAGAR"},{"id":244,"name":"NEW RAJENDRA NAGAR"},{"id":245,"name":"MAHAVEER NAGAR"},{"id":246,"name":"JAIHIND COLONY"},{"id":247,"name":"SHREEJI"},{"id":248,"name":"MADHUBEN COLONY"},{"id":249,"name":"BASANT VIHAR"},{"id":251,"name":"JORA"},{"id":252,"name":"LABHANDI"},{"id":253,"name":"PURENA"},{"id":254,"name":"PIRDA"},{"id":255,"name":"VIP CHOWK"},{"id":256,"name":"PIRDA BASTI"},{"id":257,"name":"IAS COLONY"},{"id":259,"name":"FUNDHAR"},{"id":260,"name":"TEMRI"},{"id":261,"name":"MANA"},{"id":262,"name":"DHARAMPURA"},{"id":263,"name":"SECTOR - 17"},{"id":264,"name":"SECTOR -27"},{"id":265,"name":"SECTOR -29"},{"id":266,"name":"SECTOR-28"},{"id":267,"name":"SHARDA CHOWK"},{"id":268,"name":"GHADI CHOWK"},{"id":269,"name":"PHOOL CHOWK"},{"id":270,"name":"MAUDAHAPARA"},{"id":271,"name":"SADAR BAZAR"},{"id":272,"name":"GOL BAZAR"},{"id":273,"name":"MG ROAD"},{"id":274,"name":"MALVIYA ROAD"},{"id":275,"name":"JAIL ROAD"},{"id":276,"name":"TIMBER COLONY"},{"id":277,"name":"KHAMTARAI"},{"id":278,"name":"BHANPURI"},{"id":279,"name":"WRS COLONY"},{"id":280,"name":"URLA"},{"id":281,"name":"BIRGAON"},{"id":282,"name":"NARMADA PARA"},{"id":283,"name":"KATORA TALAB"},{"id":284,"name":"PESION BADA"},{"id":285,"name":"POLICE - LINE"},{"id":286,"name":"BAIRAN BAZAR"},{"id":287,"name":"JANTA COLONY"},{"id":288,"name":"BUDHAPARA"},{"id":289,"name":"KALIBADI"},{"id":290,"name":"LILICHOWK"},{"id":291,"name":"PURANI BASTI"},{"id":295,"name":"SANTOSHI NAGAR"},{"id":296,"name":"MOWA"},{"id":299,"name":"RAWABHATA"},{"id":300,"name":"TATYAPARA"},{"id":301,"name":"DHANELI"},{"id":302,"name":"NARADHA"},{"id":303,"name":"VIDHAN SABHA ROAD"},{"id":304,"name":"SRI RAM NAGAR FACE - 1"},{"id":305,"name":"SRI RAM NAGAR FACE -2"},{"id":306,"name":"RAJIV NAGAR"},{"id":307,"name":"SHANTI NAGAR"},{"id":308,"name":"BHAWNA NAGAR"},{"id":309,"name":"ANUPAM NAGAR"},{"id":310,"name":"VRINDAVAN COLONY"},{"id":311,"name":"KHAMHARDIH VIP STATE"},{"id":312,"name":"SALES TAX COLONY"},{"id":313,"name":"SECTOR - 1"},{"id":314,"name":"Gondwara"},{"id":315,"name":"Raipura"}]
/// property_type : [{"id":5,"name":"Office"},{"id":6,"name":"Shop"},{"id":7,"name":"Semi commercial"},{"id":8,"name":"Apartments /flat"},{"id":9,"name":"house"},{"id":10,"name":"Plot"},{"id":11,"name":"Studio"},{"id":12,"name":"Godown"},{"id":13,"name":"Penthouse"},{"id":14,"name":"Villa/bonglow"},{"id":15,"name":"Farm house"},{"id":16,"name":"Industrial space"},{"id":18,"name":"Plot"},{"id":19,"name":"Land"},{"id":20,"name":"Flat"},{"id":21,"name":"Godown"},{"id":22,"name":"Plot"},{"id":23,"name":"Land"},{"id":24,"name":"Godown"},{"id":25,"name":"Godown"},{"id":26,"name":"PLOT"},{"id":27,"name":"FACTORY"},{"id":28,"name":"LAND"},{"id":29,"name":"FARM HOUSE"},{"id":30,"name":"FARM HOUSE"},{"id":31,"name":"FARM HOUSE"}]
/// type : [{"id":6,"name":"Residential"},{"id":7,"name":"Commercial"},{"id":8,"name":"Agriculture"},{"id":9,"name":"industrial"}]
/// builders : [{"id":1,"name":"individual"},{"id":2,"name":"project"}]
/// bhk_type : [{"flattype":"2 BHK"},{"flattype":"3 BHK"},{"flattype":"0 BHK"},{"flattype":"5 BHK"},{"flattype":"4 BHK"},{"flattype":"1 BHK"},{"flattype":"8 BHK"},{"flattype":"9 BHK"},{"flattype":"6 BHK"}]
/// construction : [{"constructionstatus":"Resale"},{"constructionstatus":"Dismantle"},{"constructionstatus":null},{"constructionstatus":"New"}]
/// property_interior : [{"propertyinterior":"Un-Furnished"},{"propertyinterior":"Semi-Furnished"},{"propertyinterior":"Furnished"},{"propertyinterior":null}]
/// category : [{"categories_id":3,"categories_name":"Rent"},{"categories_id":5,"categories_name":"Sell"}]

FilterToolsDataModel filterToolsFromJson(String str) =>
    FilterToolsDataModel.fromJson(json.decode(str));
String filterToolsToJson(FilterToolsDataModel data) =>
    json.encode(data.toJson());

class FilterToolsDataModel {
  FilterToolsDataModel({
    bool? success,
    int? maxPrice,
    int? maxSize,
    List<Location>? location,
    List<PropertyType>? propertyType,
    List<Type>? type,
    List<Builders>? builders,
    List<BhkType>? bhkType,
    List<Construction>? construction,
    List<PropertyInterior>? propertyInterior,
    List<Category>? category,
  }) {
    _success = success;
    _maxPrice = maxPrice;
    _maxSize = maxSize;
    _location = location;
    _propertyType = propertyType;
    _type = type;
    _builders = builders;
    _bhkType = bhkType;
    _construction = construction;
    _propertyInterior = propertyInterior;
    _category = category;
  }

  FilterToolsDataModel.fromJson(dynamic json) {
    _success = json['success'];
    _maxPrice = json['max_price'];
    _maxSize = json['max_size'];
    if (json['location'] != null) {
      _location = [];
      json['location'].forEach((v) {
        _location?.add(Location.fromJson(v));
      });
    }
    if (json['property_type'] != null) {
      _propertyType = [];
      json['property_type'].forEach((v) {
        _propertyType?.add(PropertyType.fromJson(v));
      });
    }
    if (json['type'] != null) {
      _type = [];
      json['type'].forEach((v) {
        _type?.add(Type.fromJson(v));
      });
    }
    if (json['builders'] != null) {
      _builders = [];
      json['builders'].forEach((v) {
        _builders?.add(Builders.fromJson(v));
      });
    }
    if (json['bhk_type'] != null) {
      _bhkType = [];
      json['bhk_type'].forEach((v) {
        _bhkType?.add(BhkType.fromJson(v));
      });
    }
    if (json['construction'] != null) {
      _construction = [];
      json['construction'].forEach((v) {
        _construction?.add(Construction.fromJson(v));
      });
    }
    if (json['property_interior'] != null) {
      _propertyInterior = [];
      json['property_interior'].forEach((v) {
        _propertyInterior?.add(PropertyInterior.fromJson(v));
      });
    }
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(Category.fromJson(v));
      });
    }
  }
  bool? _success;
  int? _maxPrice;
  int? _maxSize;
  List<Location>? _location;
  List<PropertyType>? _propertyType;
  List<Type>? _type;
  List<Builders>? _builders;
  List<BhkType>? _bhkType;
  List<Construction>? _construction;
  List<PropertyInterior>? _propertyInterior;
  List<Category>? _category;
  FilterToolsDataModel copyWith({
    bool? success,
    int? maxPrice,
    int? maxSize,
    List<Location>? location,
    List<PropertyType>? propertyType,
    List<Type>? type,
    List<Builders>? builders,
    List<BhkType>? bhkType,
    List<Construction>? construction,
    List<PropertyInterior>? propertyInterior,
    List<Category>? category,
  }) =>
      FilterToolsDataModel(
        success: success ?? _success,
        maxPrice: maxPrice ?? _maxPrice,
        maxSize: maxSize ?? _maxSize,
        location: location ?? _location,
        propertyType: propertyType ?? _propertyType,
        type: type ?? _type,
        builders: builders ?? _builders,
        bhkType: bhkType ?? _bhkType,
        construction: construction ?? _construction,
        propertyInterior: propertyInterior ?? _propertyInterior,
        category: category ?? _category,
      );
  bool? get success => _success;
  int? get maxPrice => _maxPrice;
  int? get maxSize => _maxSize;
  List<Location>? get location => _location;
  List<PropertyType>? get propertyType => _propertyType;
  List<Type>? get type => _type;
  List<Builders>? get builders => _builders;
  List<BhkType>? get bhkType => _bhkType;
  List<Construction>? get construction => _construction;
  List<PropertyInterior>? get propertyInterior => _propertyInterior;
  List<Category>? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['max_price'] = _maxPrice;
    map['max_size'] = _maxSize;
    if (_location != null) {
      map['location'] = _location?.map((v) => v.toJson()).toList();
    }
    if (_propertyType != null) {
      map['property_type'] = _propertyType?.map((v) => v.toJson()).toList();
    }
    if (_type != null) {
      map['type'] = _type?.map((v) => v.toJson()).toList();
    }
    if (_builders != null) {
      map['builders'] = _builders?.map((v) => v.toJson()).toList();
    }
    if (_bhkType != null) {
      map['bhk_type'] = _bhkType?.map((v) => v.toJson()).toList();
    }
    if (_construction != null) {
      map['construction'] = _construction?.map((v) => v.toJson()).toList();
    }
    if (_propertyInterior != null) {
      map['property_interior'] =
          _propertyInterior?.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// categories_id : 3
/// categories_name : "Rent"

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    int? categoriesId,
    String? categoriesName,
  }) {
    _categoriesId = categoriesId;
    _categoriesName = categoriesName;
  }

  Category.fromJson(dynamic json) {
    _categoriesId = json['categories_id'];
    _categoriesName = json['categories_name'];
  }
  int? _categoriesId;
  String? _categoriesName;
  Category copyWith({
    int? categoriesId,
    String? categoriesName,
  }) =>
      Category(
        categoriesId: categoriesId ?? _categoriesId,
        categoriesName: categoriesName ?? _categoriesName,
      );
  int? get categoriesId => _categoriesId;
  String? get categoriesName => _categoriesName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categories_id'] = _categoriesId;
    map['categories_name'] = _categoriesName;
    return map;
  }
}

/// propertyinterior : "Un-Furnished"

PropertyInterior propertyInteriorFromJson(String str) =>
    PropertyInterior.fromJson(json.decode(str));
String propertyInteriorToJson(PropertyInterior data) =>
    json.encode(data.toJson());

class PropertyInterior {
  PropertyInterior({
    String? propertyinterior,
  }) {
    _propertyinterior = propertyinterior;
  }

  PropertyInterior.fromJson(dynamic json) {
    _propertyinterior = json['propertyinterior'];
  }
  String? _propertyinterior;
  PropertyInterior copyWith({
    String? propertyinterior,
  }) =>
      PropertyInterior(
        propertyinterior: propertyinterior ?? _propertyinterior,
      );
  String? get propertyinterior => _propertyinterior;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['propertyinterior'] = _propertyinterior;
    return map;
  }
}

/// constructionstatus : "Resale"

Construction constructionFromJson(String str) =>
    Construction.fromJson(json.decode(str));
String constructionToJson(Construction data) => json.encode(data.toJson());

class Construction {
  Construction({
    String? constructionstatus,
  }) {
    _constructionstatus = constructionstatus;
  }

  Construction.fromJson(dynamic json) {
    _constructionstatus = json['constructionstatus'];
  }
  String? _constructionstatus;
  Construction copyWith({
    String? constructionstatus,
  }) =>
      Construction(
        constructionstatus: constructionstatus ?? _constructionstatus,
      );
  String? get constructionstatus => _constructionstatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['constructionstatus'] = _constructionstatus;
    return map;
  }
}

/// flattype : "2 BHK"

BhkType bhkTypeFromJson(String str) => BhkType.fromJson(json.decode(str));
String bhkTypeToJson(BhkType data) => json.encode(data.toJson());

class BhkType {
  BhkType({
    String? flattype,
  }) {
    _flattype = flattype;
  }

  BhkType.fromJson(dynamic json) {
    _flattype = json['flattype'];
  }
  String? _flattype;
  BhkType copyWith({
    String? flattype,
  }) =>
      BhkType(
        flattype: flattype ?? _flattype,
      );
  String? get flattype => _flattype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['flattype'] = _flattype;
    return map;
  }
}

/// id : 1
/// name : "individual"

Builders buildersFromJson(String str) => Builders.fromJson(json.decode(str));
String buildersToJson(Builders data) => json.encode(data.toJson());

class Builders {
  Builders({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Builders.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  Builders copyWith({
    int? id,
    String? name,
  }) =>
      Builders(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

/// id : 6
/// name : "Residential"

Type typeFromJson(String str) => Type.fromJson(json.decode(str));
String typeToJson(Type data) => json.encode(data.toJson());

class Type {
  Type({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Type.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  Type copyWith({
    int? id,
    String? name,
  }) =>
      Type(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

/// id : 5
/// name : "Office"

PropertyType propertyTypeFromJson(String str) =>
    PropertyType.fromJson(json.decode(str));
String propertyTypeToJson(PropertyType data) => json.encode(data.toJson());

class PropertyType {
  PropertyType({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  PropertyType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  PropertyType copyWith({
    int? id,
    String? name,
  }) =>
      PropertyType(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

/// id : 1
/// name : "SHANKAR NAGAR"

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Location.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;
  Location copyWith({
    int? id,
    String? name,
  }) =>
      Location(
        id: id ?? _id,
        name: name ?? _name,
      );
  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

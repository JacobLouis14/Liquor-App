class StateModel {
  String? stateName;

  StateModel({this.stateName});

  StateModel.fromJson(Map<String, dynamic> json) {
    stateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateName'] = this.stateName;
    return data;
  }
}

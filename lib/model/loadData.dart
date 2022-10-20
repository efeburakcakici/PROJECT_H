class LoadData{
  final int age;
  final String name;
  final int count;

  LoadData({required this.age,required this.count,required this.name});

  factory LoadData.fromJson(Map<String, dynamic> json){
    return LoadData(age:json['age'], count:json['count'], name:json['name']);
  }
}
import 'package:hive/hive.dart';

part 'promotion.g.dart';

@HiveType(typeId: 2)
class Promotion extends HiveObject {
  @HiveField(0)
  String merchant;
  @HiveField(1)
  String account;
  @HiveField(2)
  String id;
  @HiveField(3)
  String title;
  @HiveField(4)
  String description;
  @HiveField(5)
  String img;

  Promotion({this.merchant, this.account, this.id, this.title, this.description, this.img});
}
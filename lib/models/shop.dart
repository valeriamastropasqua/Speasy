import 'package:xml/xml.dart';

class Shop {
  final int id;
  final int idShopGroup;
  final int idCategory;
  final bool active;
  final bool deleted;
  final String name;
  final String groupName; // Change themeName to groupName
  final String themeName;

  Shop({
    required this.id,
    required this.idShopGroup,
    required this.idCategory,
    required this.active,
    required this.deleted,
    required this.name,
    required this.groupName,
    required this.themeName,
  });

  factory Shop.fromXml(XmlElement xmlShop, String groupName) {
    return Shop(
      id: int.parse(xmlShop.findElements('id').first.text),
      idShopGroup: int.parse(xmlShop.findElements('id_shop_group').first.text),
      idCategory: int.parse(xmlShop.findElements('id_category').first.text),
      active: xmlShop.findElements('active').first.text == '1',
      deleted: xmlShop.findElements('deleted').first.text == '0',
      name: xmlShop.findElements('name').first.text,
      groupName: groupName, // Assign groupName value
      themeName: xmlShop.findElements('theme_name').first.text,
    );
  }
}

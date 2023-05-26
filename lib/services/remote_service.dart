import 'package:flutter_taxi_go/models/book_data_module.dart';
import 'package:flutter_taxi_go/models/book_food_data_module.dart';
import 'package:flutter_taxi_go/models/inner_data_module.dart';
import 'package:flutter_taxi_go/models/order_list_module.dart';
import 'package:flutter_taxi_go/models/person_module.dart';
import 'package:flutter_taxi_go/models/register_data_module.dart';
import 'package:flutter_taxi_go/models/scraped_data_module.dart';
import 'package:flutter_taxi_go/models/token_module.dart';
import 'package:get/get.dart';

class RemoteService extends GetConnect {
  static var client = GetConnect();
  static const String _baseUrl = 'http://localhost:8000';
  static Future<RegisterData?> logPerson(PersonModule person) async {
    var response =
        await client.post('$_baseUrl/taxigo/login', personModuleToJson(person));
    if (response.statusCode == 200) {
      return registerDataFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<RegisterData?> register(PersonModule person) async {
    var response = await client.post(
        "$_baseUrl/taxigo/register", personModuleToJson(person));
    if (response.statusCode == 200) {
      return registerDataFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<List<ScrapedData>?> scrapeData() async {
    var response = await client.get("$_baseUrl/taxigo/data");
    if (response.statusCode == 200) {
      return scrapedDataFromJson(response.bodyString!);
    }
    print("scraping data failed");
    return null;
  }

  static Future<List<String>?> getMenu(int id) async {
    var response =
        await client.get('http://localhost:8000/taxigo/data/menu/$id');
    if (response.statusCode == 200) {
      return menuDataFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<InnerData?> getInner(int id) async {
    var response = await client.get('http://localhost:8000/taxigo/data/$id');
    if (response.statusCode == 200) {
      return innerDataFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<bool> postBook(BookData data) async {
    var response = await client.post(
        'http://localhost:8000/taxigo/book', bookDataToJson(data));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<List<BookData>?> getBook(String number) async {
    var response =
        await client.get('http://localhost:8000/taxigo/book/$number');
    if (response.statusCode == 200) {
      return booksDataFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<List<BookData>?> getBooks() async {
    var response = await client.get('http://localhost:8000/taxigo/book/all');
    if (response.statusCode == 200) {
      return booksDataFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<bool> updateBook(BookData data) async {
    data.accepted = 'Принято';
    var response = await client.post(
        'http://localhost:8000/taxigo/book/update/${data.id}',
        bookDataToJson(data));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<bool> postFoodBook(BookFoodData data) async {
    print(bookFoodDataToJson(data));
    var response = await client.post(
        'http://localhost:8000/taxigo/book/food', bookFoodDataToJson(data));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<List<BookFoodData>?> getBookFood(BookFoodData data) async {
    print("PLACE ${data.place}");
    var response = await client.post(
        'http://localhost:8000/taxigo/book/food/get', bookFoodDataToJson(data));
    if (response.statusCode == 200) {
      return booksFoodDataFromJson(response.bodyString!);
    }
    return null;
  }

  static Future<bool> postOrder(OrderList data) async {
    var response = await client.post(
        'http://localhost:8000/taxigo/order', orderListToJson(data));
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<List<OrderList>?> getOrders() async {
    var response = await client.get('http://localhost:8000/taxigo/order/all');
    if (response.statusCode == 200) {
      return ordersListFromJson(response.bodyString!);
    }
    return null;
  }
}

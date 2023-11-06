import '../../libraries.dart';
import '../models/items/item_model.dart';
import '../models/status/status_model.dart';

class IngredientsRepo {
  static getIngredients() {
    return Crud.postRequest(
      url: Api.apiGetIngredients,
      data: {},
      function: itemModelFromJson,
    );
  }

  static addIngredient({
    required String name,
    required String num,
    required String sup,
    required String priceIn,
    required String priceOut,
    required String quant,
    required String pakage,
    required String piec,
    required String stockId,
    required String kind,
    required String itemCount,
    required String ingredientsNumber,
  }) {
    return Crud.postRequest(
      url: Api.apiAddIngredient,
      data: {
        'item_name': name,
        'item_num': num,
        'item_sup': sup,
        'item_price_in': priceIn,
        'item_price_out': priceOut,
        'item_count': itemCount,
        'ingredients_number': ingredientsNumber,
        'item_quant': quant,
        'stock_id': stockId,
        'item_pakage': pakage,
        'item_piec': piec,
        'kind': kind,
      },
      function: statusModelFromJson,
    );
  }

  static editIngredient({
    required String id,
    required String quant,
  }) {
    return Crud.postRequest(
      url: Api.apiEditIngredient,
      data: {
        'item_id': id,
        'item_count': quant,
      },
      function: statusModelFromJson,
    );
  }

  static deleteIngredient({
    required String id,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteIngredient,
      data: {'item_id': id},
      function: statusModelFromJson,
    );
  }

  static deleteAllProudctIngredient({
    required String proudcttId,
  }) {
    return Crud.postRequest(
      url: Api.apiDeleteIngredientWhere,
      data: {'ingredients_number': proudcttId},
      function: statusModelFromJson,
    );
  }

  // static updateStock({
  //   required String id,
  //   required String quantity,
  // }) {
  //   return Crud.postRequest(
  //     url: Api.apiStockItem,
  //     data: {
  //       'item_num': id,
  //       'item_quant': quantity,
  //     },
  //     function: statusModelFromJson,
  //   );
  // }
}

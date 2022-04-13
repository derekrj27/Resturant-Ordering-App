import 'package:flutter/animation.dart';
import 'package:ordering_app/main.dart';

import '../model/fooditem.dart';

class CartProvider {
  List<FoodItem> foodItems = [];
  


  List<FoodItem> addToList(FoodItem fooditem) {
    bool isPresent = false;

    if (foodItems.length > 0) {
      for(int i=0; i < foodItems.length; i++) {
        if(foodItems[i].id == fooditem.id) {
          isPresent = true;
          break;
          
        }
        else {
          isPresent = false;
        }
      }
    }
    if (isPresent) {
      increaseItemQuantity(fooditem);  
    }
    else {
      foodItems.add(fooditem);
    }
    

    return foodItems;

  }

  void increaseItemQuantity(FoodItem foodItem) => foodItem.incrementQuantity();
  void decreaseItemQuantity(FoodItem foodItem) => foodItem.decrementQuantity();

  List<FoodItem> removeFromList(FoodItem foodItem){
    foodItems.remove(foodItem);
    return foodItems;
  }
}


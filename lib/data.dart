import 'package:bookmark/model/food_model.dart';

List<FoodModel> foodData = [
  FoodModel(
      image:
          'https://www.eastcoastdaily.in/wp-content/uploads/2018/05/veg-paratha-1.png',
      name: "Paratha",
      id: 13,
      time: "30-40 min",
      distance: "1.5 km",
      value: 150,
      item: getList("paratha"),
      price: 50.0,
      quantity: 0),
  FoodModel(
    image:
        'https://res.cloudinary.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/ae3qqfev6j7hzhxw6if3',
    name: "Biryani",
    time: "30-40 min",
    id: 14,
    item: getList("biryani"),
    distance: "1.5 km",
    value: 150,
    quantity: 0,
    price: 50.0,
  ),
  FoodModel(
    image:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4_dflkUBUPrteC6RdN7dLiXMgpGXMnkP_4w&usqp=CAU',
    name: "Chicken",
    item: getList("chicken"),
    time: "39-40 min",
    distance: "4.5 km",
    value: 190,
    quantity: 0,
    id: 15,
    price: 1999.0,
  ),
  FoodModel(
    image:
        'https://cdn.pixabay.com/photo/2015/11/23/11/54/chocolate-smoothie-1058191_1280.jpg',
    name: "Shake",
    item: getList("shake"),
    time: "30-40 min",
    distance: "1.5 km",
    id: 16,
    value: 150,
    quantity: 0,
    price: 750.0,
  ),
  FoodModel(
    image:
        'https://res.cloudinary.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/ae3qqfev6j7hzhxw6if3',
    name: "Burger",
    item: getList("burger"),
    time: "30-40 min",
    distance: "1.5 km",
    value: 150,
    quantity: 0,
    id: 17,
    price: 340.0,
  ),
  FoodModel(
    image:
        'https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395__480.jpg',
    name: "Pizza",
    item: getList("pizza"),
    time: "30-40 min",
    distance: "1.5 km",
    id: 18,
    value: 150,
    quantity: 0,
    price: 450.0,
  ),
  FoodModel(
    image:
        'https://cdn.pixabay.com/photo/2018/08/16/23/06/ice-3611722_1280.jpg',
    name: "Sundae",
    item: getList("sundae"),
    time: "30-40 min",
    distance: "1.5 km",
    value: 150,
    id: 19,
    quantity: 0,
    price: 150.0,
  ),
  FoodModel(
    image:
        'https://www.eastcoastdaily.in/wp-content/uploads/2018/05/veg-paratha-1.png',
    name: "Paratha",
    time: "30-40 min",
    distance: "1.5 km",
    id: 20,
    value: 150,
    item: getList("paratha"),
    quantity: 0,
    price: 878.0,
  )
];

List<String> getList(String title) {
  return List.filled(10, categoriesList[title] ?? "");
}

Map<String, String> categoriesList = {
  "pizza":
      "https://tmbidigitalassetsazure.blob.core.windows.net/rms3-prod/attachments/37/1200x1200/Pizza-from-Scratch_EXPS_FT20_8621_F_0505_1_home.jpg",
  "shake":
      "https://tmbidigitalassetsazure.blob.core.windows.net/rms3-prod/attachments/37/1200x1200/Chocolate-Peanut-Butter-Shakes_EXPS_FT19_245766_F_1008_1.jpg",
  "biryani":
      "https://www.indianhealthyrecipes.com/wp-content/uploads/2022/02/hyderabadi-biryani-recipe-chicken.jpg",
  "paratha":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyer637nUWBrgueHa9X8TtZwvhZd-B4TYbBQ&usqp=CAU",
  "burger":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7xgbnAIFuTEIBNdCQlMImHBVS7RSAh9Fmwg&usqp=CAU",
  "sundae":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ3GhqpBlB0cnKo552Y-G88lxAMl1QzxgJ-A&usqp=CAU",
  "chicken":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4fQYxZCKwG9KUEq05amY_PBUdFypx-UXs4w&usqp=CAU"
};

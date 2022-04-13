import 'package:meta/meta.dart';

FooditemList fooditemList = FooditemList(foodItems: [
  FoodItem(
    id: 1,
    title: "Torta al Pastor",
    price: 6.79,
    imgUrl:
        "https://media-cdn.tripadvisor.com/media/photo-s/0e/cf/8f/0b/torta-al-pastor-a-huge.jpg",
  ),
  FoodItem(
    id: 2,
    title: "Torta de Carnitas",
    price: 6.79,
    imgUrl:
        "https://ramonamarket.com/wp-content/uploads/2017/07/CARNITAS-TORTA.jpg",
  ),
  FoodItem(
    id: 3,
    title: "Torta de Lengua",
    price: 6.79,
    imgUrl:
        "https://i1.wp.com/farm4.staticflickr.com/3705/8973985493_d916d0f0c0_z.jpg",
  ),
    FoodItem(
    id: 4,
    title: "Torta de Chorizo",
    price: 6.79,
    imgUrl:
        "https://thedepanneur.ca/wp-content/uploads/2014/11/paola-torta-chorizo-610x321.jpg",
  ),
  FoodItem(
    id: 5,
    title: "Tamales Rojo",
    price: 1.99,
    imgUrl:
        "https://www.texascooking.com/gif/flickr/tamales-200aws.jpg",
  ),
  FoodItem(
    id: 6,
    title: "Tamales Verde",
    price: 1.99,
    imgUrl:
        "https://assets.kraftfoods.com/recipe_images/opendeploy/125069_640x428.jpg",
  ),
  FoodItem(
    id: 7,
    title: "Tacos de Carnitas",
    price: 2.59,
    imgUrl: "https://keviniscooking.com/wp-content/uploads/2020/02/Homemade-Carnitas-7.jpg",
  ),
  FoodItem(
    id: 8,
    title: "Tacos al Pastor",
    price: 2.59,
    imgUrl: "https://utahstories.com/wp-content/uploads/2019/07/Tacos-al-Pastor-min.jpg",
  ),
  FoodItem(
    id: 9,
    title: "Tacos de Chorizo",
    price: 2.59,
    imgUrl: "https://i.imgur.com/sYpluHF.jpg",
  ),
  FoodItem(
    id: 10,
    title: "Tacos de Lengua",
    price: 2.59,
    imgUrl: "https://www.simplyrecipes.com/wp-content/uploads/2010/01/beef-tacos-de-lengua-vertical-a-1600-600x835.jpg",
  ),
  FoodItem(
    id: 11,
    title: "Huarache al Pastor",
    price: 14.49,
    imgUrl:
        "http://2.bp.blogspot.com/_TAdfgJeXIjE/TCYBElWPPbI/AAAAAAAAFhk/outHrrbuub8/s320/photo-758029.JPG",
  ),
  FoodItem(
    id: 12,
    title: "Huarache de Carnitas",
    price: 14.49,
    imgUrl:
        "http://www.tacosmanzano.com/wp-content/uploads/2017/05/11-Huarache-de-Asada-350x233.jpg",
  ),
  FoodItem(
    id: 13,
    title: "Huarache de Lengua",
    price: 14.49,
    imgUrl:
        "https://newyork.seriouseats.com/images/20091102Isabel2.jpg",
  ),
  FoodItem(
    id: 14,
    title: "Huarache de Chorizo",
    price: 14.49,
    imgUrl:
        "http://www.lafonditamexicanrestaurant.com/wp-content/uploads/2015/03/huarache-de-chorizo-2.jpg",
  ),
  FoodItem(
    id: 15,
    title: "Horchata",
    price: 2,
    imgUrl:
        "https://wgbh.brightspotcdn.com/dims4/default/efb86fc/2147483647/strip/true/crop/1700x927+0+19/resize/990x540!/quality/70/?url=https%3A%2F%2Fwgbh.brightspotcdn.com%2F13%2F4a%2F82fa4a484866b6f113f05a85b87f%2Fhorchata-lead.jpg",
  ),
  FoodItem(
    id: 16,
    title: "Jarritos",
    price: 2,
    imgUrl:
      'https://dmn-dallas-news-prod.cdn.arcpublishing.com/resizer/P0zi-GOsf2X7c122oWvsOqLAAnE=/1660x934/smart/filters:no_upscale()/arc-anglerfish-arc2-prod-dmn.s3.amazonaws.com/public/6XJA5RYJLRCNTALDY4OPSQMHT4.JPG',
  ),
  FoodItem(
    id: 17,
    title: "Flan",
    price: 8,
    imgUrl:
        "https://panlasangpinoy.com/wp-content/uploads/2017/05/Oven-Baked-Leche-Flan.jpg",
  ),
  FoodItem(
    id: 18,
    title: "Tres Leches",
    price: 8,
    imgUrl:
        "https://i0.wp.com/thepioneerwoman.com/wp-content/uploads/2009/09/3907874293_4a4bd166d2.jpg",
  ),
]);

class FooditemList {
  List<FoodItem> foodItems;

  FooditemList({@required this.foodItems});
}

class FoodItem {
  double id;
  String title;
  double price;
  String imgUrl;
  int quantity;

  FoodItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.imgUrl,
    this.quantity = 1,
  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import './model/fooditem.dart';
import './bloc/cartListBloc.dart';
import './model/cart.dart';
//27:13
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i)=>CartListBloc())
      ],
      child: MaterialApp(
        title: "Food Delivery",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

ScrollController scrollController;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    scrollController = new ScrollController();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          controller: scrollController,
          children: <Widget>[
          FirstHalf(),
          SizedBox(height: 45),
          for(var foodItem in fooditemList.foodItems)
            ItemContainer(foodItem: foodItem),
          ]
        ),
        
        )
      );
  }
}

class ItemContainer extends StatelessWidget {
  final FoodItem foodItem;

  ItemContainer({@required this.foodItem});

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  addToCart(FoodItem foodItem) {
    bloc.addToList(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        addToCart(foodItem);

        final snackbar= SnackBar(
          content: Text('${foodItem.title} added to the order'),
          duration: Duration(milliseconds: 550),
        );
        Scaffold.of(context).showSnackBar(snackbar);
      },
      child: Items(
        itemName: foodItem.title,
        itemPrice: foodItem.price,
        imgUrl: foodItem.imgUrl,
        leftAligned: foodItem.id % 2 == 0 ? true : false
      ),
    );
  }
}

class Items extends StatelessWidget {
  Items({
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
  });

  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final double itemPrice;

  @override 
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          //fix align
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget> [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                  left: leftAligned 
                    ? Radius.circular(0) 
                    : Radius.circular(containerBorderRadius),
                  right: leftAligned 
                    ? Radius.circular(containerBorderRadius)
                    : Radius.circular(0),
                ),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.fill
                )
                )
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(
                  left: leftAligned ? 20 : 0,
                  right: leftAligned ? 0 : 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            itemName,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                            )
                          ),),
                          Text('\$$itemPrice',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          )
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                          ),
                        )
                      ),
                    )
                  ],
                )
              ),
            ]
          )
        )
      ],
    );
  }
}

class FirstHalf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          SizedBox (height: 30),
          title(),
          SizedBox(height: 30), 
          categories(),
        ],
      )
    );
  }

  
  

  

  Widget title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 45),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Taqueria",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              )
            ),
            Text("Menu",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 30,
            ))
          ],
        )
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<FoodItem> foodItems = snapshot.data;

              int length = foodItems !=null ? foodItems.length: 0;
              return buildGestureDetector(length, context, foodItems);
            }
          )
        ]
      )
    );
  }
  GestureDetector buildGestureDetector(
    int length, 
    BuildContext context, 
    List<FoodItem> foodItems) {
      return GestureDetector(
        onTap: () {
          if (length > 0) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
          }
          else {
            return;
          }
        },
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: Text(length.toString()),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.circular(50)),
      )
    );
  }
}

var isSelected = false;

const double height = 450;

Widget categories() {
  return Container(
    height: 185,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
         GestureDetector(
          onTap: () => scrollController.animateTo(height, duration: Duration(seconds: 2), curve: Curves.ease),
          child: CategoryListItem(
            categoryIcon: Icons.folder_open,
            categoryName: "Tortas",
            selected: isSelected,
          ),
        ),
        GestureDetector(
          onTap: () => scrollController.animateTo(height * 5, duration: Duration(seconds: 2), curve: Curves.ease),
          child: CategoryListItem(
            categoryIcon: Icons.folder_open,
            categoryName: "Tacos",
            selected: isSelected,
          ),
        ),
        GestureDetector(
          onTap: () => scrollController.animateTo(height * 3.6, duration: Duration(seconds: 2), curve: Curves.ease),
          child: CategoryListItem(
            categoryIcon: Icons.folder_open,
            categoryName: "Tamales",
            selected: isSelected,
          ),
        ),
        GestureDetector(
          onTap: () => scrollController.animateTo(height * 7.6, duration: Duration(seconds: 2), curve: Curves.ease),
          child: CategoryListItem(
            categoryIcon: Icons.folder_open,
            categoryName: "Huaraches",
            selected: isSelected,
          ),
        ),
        GestureDetector(
          onTap: () => scrollController.animateTo(height * 10.3, duration: Duration(seconds: 2), curve: Curves.ease),
          child: CategoryListItem(
            categoryIcon: Icons.folder_open,
            categoryName: "Drinks",
            selected: isSelected,
          ),
        ),
        GestureDetector(
          onTap: () => scrollController.animateTo(height * 12, duration: Duration(seconds: 2), curve: Curves.ease),
          child: CategoryListItem(
            categoryIcon: Icons.folder_open,
            categoryName: "Deserts",
            selected: isSelected,
          ),
        ),
      ],
    ),
  );
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key key,
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.selected,
  }) : super(key: key);

  final IconData categoryIcon;
  final String categoryName;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: selected ? Colors.grey[200] : Colors.white,
            ),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(height: 5),
          Text(
            categoryName,
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}





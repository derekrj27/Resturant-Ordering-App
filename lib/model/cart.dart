import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ordering_app/model/payment.dart';
import './fooditem.dart';
import '../bloc/cartListBloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
//43:56

class Cart extends StatelessWidget {

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override 
  Widget build(BuildContext context) {

    List<FoodItem> foodItem;

    return StreamBuilder(
      stream: bloc.listStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          foodItem = snapshot.data;
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: CartBody(foodItem),
              ),
            ),
            bottomNavigationBar: BottomBar(foodItem),
          );
        }else{
          return Container();
        }
      }
    );

  }
}

class BottomBar extends StatelessWidget {

  final List<FoodItem> foodItem;

  BottomBar(this.foodItem);

  @override 
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, bottom: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          totalAmount(foodItem),
          FlatButton(
            color: Colors.yellow,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Payment()),
              );
            },
            child: Text(
              "Payment",
            ),
          )
        ],
      )
    );
  }

  Container totalAmount(List<FoodItem> foodItem) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Total:',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w300,
            )
          ),
          Text(
            '\$${returnTotalAmount(foodItem)}',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
          ),
      ],)
    );
  }
  String returnTotalAmount (List<FoodItem> foodItems) {
    double totalAmount = 0.0;

    for(int i=0; i< foodItem.length; i++) {
      totalAmount = totalAmount + foodItem[i].price*foodItem[i].quantity;
    }
    return totalAmount.toStringAsFixed(2);
  }
}

class CustomPersonWidget extends StatefulWidget {
  @override 
  State<StatefulWidget> createState(){
    return _CustomPersonWidgetState();
  }
}

class _CustomPersonWidgetState extends State<CustomPersonWidget> {
  int noOfPersons = 1;
  double _buttonWidth = 30;
  @override 
  Widget build(BuildContext context) {
    
    return Container(

      margin: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300], width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 5),
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              child: Text(
              '-',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              )
              ),
              onPressed: () {
                setState(() {
                  if(noOfPersons > 1){
                    noOfPersons--;
                  }
                });
              }
            )
          ),
          Text(
            noOfPersons.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            )
          ),
          SizedBox(
            width: _buttonWidth,
            height: _buttonWidth,
            child: FlatButton(
              child: Text(
              '+',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              )
              ),
              onPressed: () {
                setState(() {
                  if(noOfPersons > 1){
                    noOfPersons++;
                  }
                });
              }
            )
          ),
        ],
      ),
    );
  }
}

class CartBody extends StatelessWidget {

  final List<FoodItem> foodItems;
  CartBody(this.foodItems);

  @override 
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(35, 40, 25, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          title(),
          Expanded(
            flex: 1,
            child: foodItems.length > 0 ? foodItemList() : noItemContainer(),
          )
        ],)
    );
  }

  Container noItemContainer() {
    return Container(
      child: Center(
        child: Text('No items in the order',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.grey[500],
          fontSize: 20,
        ),
      ),)
    );
  }

  ListView foodItemList() {
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (builder, index) {
        return CartListItem(foodItem : foodItems[index]);
      }
    );
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "My",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                )
              ),
              Text(
                "Order",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                )
              )
            ],
          )
        ],
      )
    );
  }
}

class CartListItem extends StatelessWidget{
  final FoodItem foodItem;

  CartListItem ({@required this.foodItem});

  @override 
  Widget build(BuildContext context) {
    return Draggable(
      data: foodItem,
      maxSimultaneousDrags: 1,
      child: DraggableChild(foodItem: foodItem),
      feedback: DraggableChildFeedback(foodItem: foodItem),
      
    );
  }
}

class DraggableChild extends StatelessWidget {
  const DraggableChild({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: ItemContent(foodItem : foodItem),

    );
  }
}

class DraggableChildFeedback extends StatelessWidget {
  const DraggableChildFeedback({
    Key key,
    @required this.foodItem,
  }) : super(key: key);

  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
    child: Material(
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        child: ItemContent(foodItem : foodItem),
      )
    )
    );
  }
}

class ItemContent extends StatelessWidget {

  final FoodItem foodItem;

  ItemContent({@required this.foodItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              foodItem.imgUrl,
              fit: BoxFit.fitHeight,
              height:  55,
              width: 80,
            )
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: foodItem.quantity.toString()),
                TextSpan(text: ' x '),
                TextSpan(
                  text: foodItem.title
                )
              ]
            )
          ),
          Text(
            '\$${foodItem.quantity * foodItem.price}',
            style: TextStyle(color: Colors.grey[300], fontWeight: FontWeight.w400,),
          ),
        ],
      )
    );
  }
}

class CustomAppBar extends StatelessWidget {

  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  @override 
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
        Padding(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Icon(
              CupertinoIcons.back,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            }
          )

        ),
        DragTargetWidget(),
      ]
    );
  }
}

class DragTargetWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DragTargetWidgetState();
  }
}

class _DragTargetWidgetState extends State<DragTargetWidget> {

  final CartListBloc listBloc = BlocProvider.getBloc<CartListBloc>();


  @override
  Widget build(BuildContext context) {
    return DragTarget<FoodItem>(

      onWillAccept: (FoodItem foodItem){
        return true;
      },
      onAccept: (FoodItem foodItem) {
        listBloc.removeFromList(foodItem);
      },
      builder: (context, incoming, rejected) {
        return Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              CupertinoIcons.delete, 
              size: 35,
            ),
          );
      }
    );
    
  }
}
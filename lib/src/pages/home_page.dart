import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_menu/src/widgets/pinterest_menu_widget.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
        PinterestGrid(),
        _MenuScroll(),  
      ],
    ) 
      //PinterestMenuWidget() 
      //PinterestGrid()
    );
  }
  
}

class _MenuScroll extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final widthPagina = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 30,
      child: Container(
        width: widthPagina,
        child: Align(
          child: PinterestMenuWidget()
        ),
      )
    );
  }
}


class PinterestGrid extends StatelessWidget {
  const PinterestGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final List<int> item = List.generate(200, (i) => i);

    return  StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: item.length,
        itemBuilder: (BuildContext context, int index)=> _PinterestItem(index),
        staggeredTileBuilder: (int index) =>
       StaggeredTile.count(2, index.isEven ? 2 : 3),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,  
      );
  }
}

class _PinterestItem extends StatelessWidget {
  
  final int index;
  _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container (
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),

    );
  }
}
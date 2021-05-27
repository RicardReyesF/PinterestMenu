import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_menu/src/widgets/pinterest_menu_widget.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_) => new _MenuScrollP(),
      child: Scaffold(
        body: Stack(
          children: [
          PinterestGrid(),
          _MenuScroll(),  
        ],
      ) 
        //PinterestMenuWidget() 
        //PinterestGrid()
      ),
    );
  }
  
}

class _MenuScroll extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final widthPagina = MediaQuery.of(context).size.width;
    final mostrar=Provider.of<_MenuScrollP>(context).mostrar;
    return Positioned(
      bottom: 30,
      child: Container(
        width: widthPagina,
        child: Align(
          child: PinterestMenuWidget(mostrar: mostrar,background: Colors.grey,activo: Colors.red,desactivado: Colors.black,
          items: [
              PinteresButton(icon: Icons.pie_chart,onPressed: (){print("pie_chart"); }),
              PinteresButton(icon: Icons.search,onPressed: (){print("search"); }),
              PinteresButton(icon: Icons.notifications,onPressed: (){print("notificatios"); }),
              PinteresButton(icon: Icons.supervised_user_circle,onPressed: (){print("supervised_user_circle"); })
            ],
          )
        ),
      )
    );
  }
}


class PinterestGrid extends StatefulWidget {


  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {

    final List<int> item = List.generate(200, (i) => i);
    final ScrollController controllerPage = new ScrollController(); 
    double controllerAnterior = 0;

    @override
  void initState() { 
    super.initState();
    controllerPage.addListener(() { 
        if(controllerPage.offset > controllerAnterior){
          Provider.of<_MenuScrollP>(context,listen: false).mostrar = false;
        }else{
          Provider.of<_MenuScrollP>(context,listen: false).mostrar = true;
        }
        controllerAnterior = controllerPage.offset;
    });
    
  }

  @override
  void dispose() { 
    controllerPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  StaggeredGridView.countBuilder(
        controller: controllerPage,
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



class _MenuScrollP with ChangeNotifier{

  bool _mostrar = true;

  bool get mostrar => this._mostrar;

  set mostrar (bool valor){
    this._mostrar = valor;
    notifyListeners();
  } 



}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinteresButton{
  final Function onPressed;
  final IconData icon;

  PinteresButton({

   @required this.onPressed, 
   @required this.icon
});
}


class PinterestMenuWidget extends StatelessWidget {

  final bool mostrar;
  final Color background;
  final Color activo;
  final Color desactivado;

   PinterestMenuWidget({
     this.mostrar = true,
     this.background = Colors.white,
     this.activo = Colors.blueGrey,
     this.desactivado = Colors.black, 
    });

  final List<PinteresButton> items = [
    PinteresButton(icon: Icons.pie_chart,onPressed: (){print("pie_chart"); }),
    PinteresButton(icon: Icons.search,onPressed: (){print("search"); }),
    PinteresButton(icon: Icons.notifications,onPressed: (){print("notificatios"); }),
    PinteresButton(icon: Icons.supervised_user_circle,onPressed: (){print("supervised_user_circle"); }),

  ];

  @override
  Widget build(BuildContext context) {

    
    return ChangeNotifierProvider( 
      create: (_) => _MenuModel(),
        child: AnimatedOpacity(
          opacity: (mostrar) ? 1 : 0,
          duration: Duration(milliseconds: 400),
          child: Builder(
            builder: (BuildContext context){

              Provider.of<_MenuModel>(context).background=background;
              Provider.of<_MenuModel>(context).activeC=activo;
              Provider.of<_MenuModel>(context).inactiveC=desactivado;
              return  _PinterestButtonBackground(
              child: _MenuItem( items )
            );
          }
        ),
      ),
    );  
  }
}

class _PinterestButtonBackground extends StatelessWidget {
  final Widget child;
  const _PinterestButtonBackground({
   @required this.child
  });

  @override
  Widget build(BuildContext context) {
    final background = Provider.of<_MenuModel>(context).backgroundC;
    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: <BoxShadow> [
          BoxShadow(
            color: Colors.black87,
            blurRadius: 10,
            spreadRadius: -5
          )
        ]
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {

  final List <PinteresButton> menuItems;

  _MenuItem(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (i) => _PinterestM(i,menuItems[i]) )
    );
  }
}

class _PinterestM extends StatelessWidget {

  
  
  final int index;
  final PinteresButton item;

  _PinterestM(
    this.index,
    this.item
  );

  @override
  Widget build(BuildContext context) {
    final intemSeleccionado = Provider.of<_MenuModel>(context).itemSeleccionado;
    final colorActive = Provider.of<_MenuModel>(context).activeC;
    final colorInactive = Provider.of<_MenuModel>(context).inactiveC;


    return GestureDetector(
      onTap: (){
        Provider.of<_MenuModel>(context,listen: false).itemSeleccionado = index;
        item.onPressed();
      },
      child: Container(
        child: Icon(item.icon,
          size: (intemSeleccionado == index ) ? 35 : 25,
          color: (intemSeleccionado == index ) ? colorActive : colorInactive,        
        ),
      ),
    );
  }
}


class _MenuModel with ChangeNotifier{

int _itemSeleccionado =  0;

Color background    = Colors.white;
Color activeColor   = Colors.black;
Color inactiveColor = Colors.blueGrey;

int get itemSeleccionado => this._itemSeleccionado;

set itemSeleccionado (int index){
  this._itemSeleccionado = index;
  notifyListeners();
}

Color get activeC => this.activeColor;
Color get inactiveC => this.inactiveColor;
Color get backgroundC => this.background;

set activeC (Color aC){
  this.activeColor = aC;
}
set inactiveC (Color iC){
  this.inactiveColor = iC;
  
}
set backgroundC (Color bC){
  this.background = bC;
  
}

}
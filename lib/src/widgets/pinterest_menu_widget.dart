
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
        child: _PinterestButtonBackground(
          child: _MenuItem( items )
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
    return Container(
      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
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


    return GestureDetector(
      onTap: (){
        Provider.of<_MenuModel>(context,listen: false).itemSeleccionado = index;
        item.onPressed();
      },
      child: Container(
        child: Icon(item.icon,
          size: (intemSeleccionado == index ) ? 35 : 25,
          color: (intemSeleccionado == index ) ? Colors.blueGrey : Colors.black,        
        ),
      ),
    );
  }
}


class _MenuModel with ChangeNotifier{

int _itemSeleccionado =  0;

int get itemSeleccionado => this._itemSeleccionado;

set itemSeleccionado (int index){
  this._itemSeleccionado = index;
  notifyListeners();
}
}
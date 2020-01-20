import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<String> _list;
  bool _isSearching;
  String _searchText = "";

  _SearchPageState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
    init();
  }

  void init() {
    _list = List();
    _list.add("Ho Chi Minh");
    _list.add("Tokyo");
    _list.add("New York City");
    _list.add("Ha Noi");
    _list.add("Berlin");
    _list.add("Rio De Janeiro");
    _list.add("Seul");
    _list.add("Beijing");
    _list.add("Bangkok");
    _list.add("Jakarta");
    _list.add("Sydney");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: key,
        appBar: buildBar(context),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          children: _isSearching ? _buildSearchList() : _buildList(),
        ),
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => ChildItem(contact)).toList();
    } else {
      List<String> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => ChildItem(contact)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
        title: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
         elevation: 8,
         margin: EdgeInsets.all(8),
         child: Row(
           children: <Widget>[
             Expanded(
               child: TextFormField(
                 controller: _searchQuery,
                 style: TextStyle(color: Colors.black),
                 decoration: InputDecoration(
                   prefixIcon: Icon(Icons.search, color: Colors.black,),
                   hintText: "Enter your city name",
                   hintStyle: TextStyle(color: Colors.black)
                 ),
               ),
             ),
             IconButton(
               icon: Icon(Icons.close),
               color: Colors.black,
               onPressed: _handleSearchEnd,
             )
           ],
         ),
        )
    );
  }

  void _handleSearchEnd() {
    setState(() {
      _searchQuery.clear();
    });
  }

}

class ChildItem extends StatelessWidget {
  final String name;

  ChildItem(this.name);

  @override
  Widget build(BuildContext context) {
    return ListTile(title: InkWell(
        child: Text(this.name)),
      onTap:(){
      _backToHome(context, this.name);
      },
    );
  }

  //goto search page
  void _backToHome(BuildContext context, String cityName) {
    Navigator.pop(context, cityName);
  }
}

import 'package:flutter/material.dart';
import 'package:weather/models/city.dart';
import 'package:weather/models/constants.dart';
import 'package:weather/ui/home.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    List<City> cities = City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selectedCities = City.getSelectedCities();

    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondaryColor,
        title: Text(selectedCities.length.toString() + ' selected'),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: size.height * .08,
            width: size.width,
            decoration: BoxDecoration(
              border: cities[index].isSelected == true ? Border.all(
                color: myConstants.secondaryColor.withOpacity(.6),
                width: 2,
              ) : Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: myConstants.primaryColor.withOpacity(.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ]
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      cities[index].isSelected =! cities[index].isSelected;
                    });
                  },
                    child: Image.asset(cities[index].isSelected == true ? 'assets/checked.png' : 'assets/unchecked.png', width: 30,)),
                const SizedBox( width: 10,),
                Text(cities[index].city, style: TextStyle(
                  fontSize: 16,
                  color: cities[index].isSelected == true ? myConstants.primaryColor : Colors.black54,
                ),)
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myConstants.secondaryColor,
        child: const Icon(Icons.pin_drop),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
        },
      ),
    );
  }
}

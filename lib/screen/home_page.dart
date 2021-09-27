import 'package:flutter/material.dart';
import 'package:foody/models/categories_model.dart';
import 'package:foody/provider/my_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoriesModel> burgerList = [];

  Widget categoriesContainer(
      {@required String? imageName, @required String? foodCategory}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 11),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(imageName!)),
            // image: DecorationImage(image: NetworkImage(imageName!)),
            // image:DecorationImage(image: Image.network('https://pngimg.com/uploads/burger_sandwich/burger_sandwich_PNG4135.png')),
            // image:DecorationImage(image: Image.network(
            // 'https://banner2.cleanpng.com/20180324/osq/kisspng-hamburger-bacon-sushi-pizza-cheeseburger-burger-king-5ab6e5746c0b92.1832730815219357324426.jpg'),),
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          foodCategory!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget bottomFoodContainer(
      {@required String? imageNameBig,
      @required String? foodNameBig,
      @required int? price}) {
    return Container(
      height: 240,
      width: 200,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(imageNameBig!),
          ),
          ListTile(
            leading: Text(
              foodNameBig!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              '\₹ $price',
              style: TextStyle(
                fontSize: 20,
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.yellow,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget drawerThings({@required String? name, @required IconData? icon}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.yellow,
      ),
      title: Text(
        name!,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget burger() {
    return Row(
      children: burgerList
          .map((e) =>
              categoriesContainer(imageName: e.image, foodCategory: e.name))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.getCategories();
    burgerList = provider.throwList;
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.red,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'images/background.png',
                      ),
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/Snehasish.jpg'),
                  ),
                  accountName: Text(
                    'Snehasish Dey',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  accountEmail: Text(
                    'snehasishdey121@gmail.com',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    'Personal Details',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                drawerThings(name: 'Profile', icon: Icons.person),
                drawerThings(name: 'Cart', icon: Icons.add_shopping_cart),
                drawerThings(name: 'Orders', icon: Icons.shop),
                drawerThings(name: 'Change', icon: Icons.settings),
                Divider(
                  color: Colors.yellow,
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    'Communicate',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                drawerThings(name: 'About Us', icon: Icons.info),
                drawerThings(name: 'Report', icon: Icons.mail),
                Divider(
                  color: Colors.yellow,
                  thickness: 3,
                ),
                drawerThings(name: 'Log Out', icon: Icons.logout),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        // leading: Icon(
        //   Icons.sort,
        //   color: Colors.red,
        //   size: 35,
        // ),
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: Image.asset(
          'images/foody logo1.png',
          height: 170,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/Snehasish.jpg'),
              backgroundColor: Colors.redAccent,
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: 'Search Food',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                filled: true,
                fillColor: Colors.red,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // burger(),
                categoriesContainer(
                    foodCategory: "Mixed", imageName: 'images/1.png'),
                categoriesContainer(
                    foodCategory: "Burger", imageName: 'images/2.png'),
                categoriesContainer(
                    foodCategory: "Pizza", imageName: 'images/3.png'),
                categoriesContainer(
                    foodCategory: "Fries", imageName: 'images/4.png'),
                categoriesContainer(
                    foodCategory: "Roll", imageName: 'images/10.png'),
                categoriesContainer(
                    foodCategory: "Drinks", imageName: 'images/19.png'),
                categoriesContainer(
                    foodCategory: "Indian", imageName: 'images/17.png'),
                categoriesContainer(
                    foodCategory: "Chinese", imageName: 'images/13.png'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 410,
            child: GridView.count(
              shrinkWrap: false,
              primary: false,
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                bottomFoodContainer(
                    imageNameBig: 'images/6.png',
                    foodNameBig: 'Chicago Pizza \nPapperoni',
                    price: 119),
                bottomFoodContainer(
                    imageNameBig: 'images/7.png',
                    foodNameBig: 'Kebab Gyro \nChicken Pizza',
                    price: 149),
                bottomFoodContainer(
                    imageNameBig: 'images/13.png',
                    foodNameBig: 'Penne Caesar \nSalad Pasta',
                    price: 99),
                bottomFoodContainer(
                    imageNameBig: 'images/15.png',
                    foodNameBig: 'Pizza Sushi',
                    price: 220),
                bottomFoodContainer(
                    imageNameBig: 'images/16.png',
                    foodNameBig: 'Potato French \nFries',
                    price: 99),
                bottomFoodContainer(
                    imageNameBig: 'images/18.png',
                    foodNameBig: 'Samosa Indian \nChaat',
                    price: 29),
                bottomFoodContainer(
                    imageNameBig: 'images/1.png',
                    foodNameBig: 'Burger & Fries \nwith Coke',
                    price: 29),
                bottomFoodContainer(
                    imageNameBig: 'images/2.png',
                    foodNameBig: 'Large Chicken \Burger',
                    price: 149),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../models/meal.dart';


class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealScreen(this.availableMeals);

  // final String categoryId;
  // final String categoryTitle;
  //
  // CategoryMealScreen(this.categoryId, this.categoryTitle);


  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {

  late String categoryTitle;
  late List<Meal> displayedMeals;

  var _loadedInitData = false;

  @override
  void initState(){
    // final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    // final categoryId = routeArgs['id'];
    // final categoryTitle = routeArgs['title'];
    // displayedMeals = DUMMY_MEALS.where((meal) {
    //   return meal.categories.contains(categoryId);
    // }).toList();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title']!;
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(itemBuilder: (ctx, index) {
        return MealItem(
          id: displayedMeals[index].id,
          title: displayedMeals[index].title,
          imageUrl: displayedMeals[index].imageUrl,
          duration: displayedMeals[index].duration,
          affordability: displayedMeals[index].affordability,
          complexity: displayedMeals[index].complexity,
        );
      }, itemCount: displayedMeals.length,)
    );
  }
}
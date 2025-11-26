import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recipe.dart';
import 'package:flutter_application_1/pages/recipe_page.dart';
import 'package:flutter_application_1/services/data_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mealTypeFilter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Book"), centerTitle: true),
      body: SafeArea(child: _buildUI(context)),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [_recipeTypeButtons(context), _recipeList(context)],
      ),
    );
  }

  Widget _recipeTypeButtons(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "snack";
                });
              },
              child: const Text("🍿 Snacks"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "breakfast";
                });
              },
              child: const Text("🍳 Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "lunch";
                });
              },
              child: const Text("🥗 Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  _mealTypeFilter = "dinner";
                });
              },
              child: const Text("🍔 Dinner"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipeList(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: DataService().getRecipes(_mealTypeFilter),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Unable to load data."));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Recipe recipe = snapshot.data![index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RecipePage(recipe: recipe);
                      },
                    ),
                  );
                },
                contentPadding: const EdgeInsets.only(top: 20),
                isThreeLine: true,
                subtitle: Text(
                  "${recipe.cuisine}\nDifficulty: ${recipe.difficulty}",
                ),
                leading: Image.network(recipe.image),
                title: Text(recipe.name),
                trailing: Text(
                  "${recipe.rating.toString()} ⭐",
                  style: const TextStyle(fontSize: 15),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

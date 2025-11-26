import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/recipe.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;

  const RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text("Recipe Book"),
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(children: [_recipeImage(context), _recipeDetails(context)]);
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(recipe.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _recipeDetails(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${recipe.cuisine}, ${recipe.difficulty}",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          Text(
            recipe.name,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            "Prep time: ${recipe.prepTimeMinutes} minutes | Cook time: ${recipe.cookTimeMinutes} minutes",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          ),
          Text(
            "${recipe.rating.toString()} ⭐ | ${recipe.reviewCount} reviews",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

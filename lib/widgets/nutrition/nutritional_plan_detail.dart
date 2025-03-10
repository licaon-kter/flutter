/*
 * This file is part of wger Workout Manager <https://github.com/wger-project>.
 * Copyright (C) 2020, 2021 wger Team
 *
 * wger Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * wger Workout Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wger/helpers/colors.dart';
import 'package:wger/models/nutrition/nutritional_plan.dart';
import 'package:wger/providers/body_weight.dart';
import 'package:wger/screens/form_screen.dart';
import 'package:wger/widgets/measurements/charts.dart';
import 'package:wger/widgets/nutrition/charts.dart';
import 'package:wger/widgets/nutrition/forms.dart';
import 'package:wger/widgets/nutrition/macro_nutrients_table.dart';
import 'package:wger/widgets/nutrition/meal.dart';
import 'package:wger/widgets/nutrition/nutritional_diary_table.dart';

class NutritionalPlanDetailWidget extends StatelessWidget {
  final NutritionalPlan _nutritionalPlan;

  const NutritionalPlanDetailWidget(this._nutritionalPlan);

  @override
  Widget build(BuildContext context) {
    final nutritionalGoals = _nutritionalPlan.nutritionalGoals;
    final lastWeightEntry =
        Provider.of<BodyWeightProvider>(context, listen: false).getNewestEntry();
    final nutritionalGoalsGperKg =
        lastWeightEntry != null ? nutritionalGoals / lastWeightEntry.weight.toDouble() : null;

    return SliverList(
        delegate: SliverChildListDelegate(
      [
        SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlNutritionalPlanGoalWidget(
              nutritionalPlan: _nutritionalPlan,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ..._nutritionalPlan.meals.map((meal) => MealWidget(
              meal,
              _nutritionalPlan.allMealItems,
            )),
        MealWidget(
          _nutritionalPlan.pseudoMealOthers('Other logs'),
          _nutritionalPlan.allMealItems,
        ),
        if (!_nutritionalPlan.onlyLogging)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text(AppLocalizations.of(context).addMeal),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  FormScreen.routeName,
                  arguments: FormScreenArguments(
                    AppLocalizations.of(context).addMeal,
                    MealForm(_nutritionalPlan.id!),
                  ),
                );
              },
            ),
          ),
        if (nutritionalGoals.isComplete())
          Container(
            padding: const EdgeInsets.all(15),
            height: 220,
            child: FlNutritionalPlanPieChartWidget(nutritionalGoals.toValues()),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: MacronutrientsTable(
            nutritionalGoals: nutritionalGoals,
            plannedValuesPercentage: nutritionalGoals.energyPercentage(),
            nutritionalGoalsGperKg: nutritionalGoalsGperKg,
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0)),
        Text(
          AppLocalizations.of(context).logged,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          height: 300,
          child: NutritionalDiaryChartWidgetFl(nutritionalPlan: _nutritionalPlan),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Indicator(
                color: LIST_OF_COLORS3[0],
                text: AppLocalizations.of(context).deficit,
                isSquare: true,
                marginRight: 0,
              ),
              Indicator(
                color: COLOR_SURPLUS,
                text: AppLocalizations.of(context).surplus,
                isSquare: true,
                marginRight: 0,
              ),
              Indicator(
                color: LIST_OF_COLORS3[1],
                text: AppLocalizations.of(context).today,
                isSquare: true,
                marginRight: 0,
              ),
              Indicator(
                color: LIST_OF_COLORS3[2],
                text: AppLocalizations.of(context).weekAverage,
                isSquare: true,
                marginRight: 0,
              ),
            ],
          ),
        ),
        if (_nutritionalPlan.logEntriesValues.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context).nutritionalDiary,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      child: NutritionalDiaryTable(nutritionalPlan: _nutritionalPlan),
                    )),
              ],
            ),
          ),
      ],
    ));
  }
}

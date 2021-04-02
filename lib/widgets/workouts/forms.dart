/*
 * This file is part of wger Workout Manager <https://github.com/wger-project>.
 * Copyright (C) 2020 wger Team
 *
 * wger Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * wger Workout Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';
import 'package:wger/models/exercises/exercise.dart';
import 'package:wger/models/workouts/day.dart';
import 'package:wger/models/workouts/repetition_unit.dart';
import 'package:wger/models/workouts/set.dart';
import 'package:wger/models/workouts/setting.dart';
import 'package:wger/models/workouts/weight_unit.dart';
import 'package:wger/models/workouts/workout_plan.dart';
import 'package:wger/providers/auth.dart';
import 'package:wger/providers/exercises.dart';
import 'package:wger/providers/workout_plans.dart';
import 'package:wger/screens/workout_plan_screen.dart';
import 'package:wger/widgets/workouts/exercises.dart';

class WorkoutForm extends StatelessWidget {
  WorkoutPlan _plan;
  final _form = GlobalKey<FormState>();

  WorkoutForm(this._plan);

  final TextEditingController workoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_plan.id != null) {
      workoutController.text = _plan.description;
    }

    return Form(
      key: _form,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: AppLocalizations.of(context)!.description),
            controller: workoutController,
            validator: (value) {
              const minLength = 5;
              const maxLength = 100;
              if (value!.isEmpty || value.length < minLength || value.length > maxLength) {
                return AppLocalizations.of(context)!.enterCharacters(minLength, maxLength);
              }
              return null;
            },
            onFieldSubmitted: (_) {},
            onSaved: (newValue) {
              _plan.description = newValue!;
            },
          ),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.save),
            onPressed: () async {
              // Validate and save
              final isValid = _form.currentState!.validate();
              if (!isValid) {
                return;
              }
              _form.currentState!.save();

              // Save to DB
              final workout = _plan.id != null
                  ? await Provider.of<WorkoutPlans>(context, listen: false).patchWorkout(_plan)
                  : await Provider.of<WorkoutPlans>(context, listen: false).postWorkout(_plan);

              Navigator.of(context).pop();
              if (_plan.id == null) {
                Navigator.of(context).pushNamed(WorkoutPlanScreen.routeName, arguments: workout);
              }
            },
          ),
        ],
      ),
    );
  }
}

class DayCheckbox extends StatefulWidget {
  Day _day;
  final int _dayNr;

  DayCheckbox(this._dayNr, this._day);

  @override
  _DayCheckboxState createState() => _DayCheckboxState();
}

class _DayCheckboxState extends State<DayCheckbox> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget._day.getDayName(widget._dayNr)),
      value: _isSelected,
      onChanged: (bool? newValue) {
        setState(() {
          _isSelected = newValue!;
          if (!newValue) {
            widget._day.daysOfWeek.remove(widget._dayNr);
          } else {
            widget._day.daysOfWeek.add(widget._dayNr);
          }
        });
      },
    );
  }
}

class DayFormWidget extends StatefulWidget {
  final WorkoutPlan workout;
  final dayController = TextEditingController();
  Day _day = Day();

  DayFormWidget(this.workout, [Day? day]) {
    this._day = day ?? Day();
    _day.workoutId = this.workout.id!;
  }

  @override
  _DayFormWidgetState createState() => _DayFormWidgetState();
}

class _DayFormWidgetState extends State<DayFormWidget> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _form,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.description),
              controller: widget.dayController,
              onSaved: (value) {
                widget._day.description = value!;
              },
              validator: (value) {
                const minLength = 5;
                const maxLength = 100;
                if (value!.isEmpty || value.length < minLength || value.length > maxLength) {
                  return AppLocalizations.of(context)!.enterCharacters(minLength, maxLength);
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Text('Week days'),
            ...Day.weekdays.keys.map((dayNr) => DayCheckbox(dayNr, widget._day)).toList(),
            ElevatedButton(
              child: Text(AppLocalizations.of(context)!.save),
              onPressed: () async {
                if (!_form.currentState!.validate()) {
                  return;
                }
                _form.currentState!.save();

                try {
                  Provider.of<WorkoutPlans>(context, listen: false).addDay(
                    widget._day,
                    widget.workout,
                  );

                  widget.dayController.clear();
                  Navigator.of(context).pop();
                } catch (error) {
                  await showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('An error occurred!'),
                      content: Text('Something went wrong.'),
                      actions: [
                        TextButton(
                          child: Text('Okay'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        )
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SetFormWidget extends StatefulWidget {
  Day _day;
  late Set _set;

  SetFormWidget(Day this._day, [Set? set]) {
    //this._day = day;
    this._set = set ?? Set.withData(day: _day.id, sets: 4);
  }

  @override
  _SetFormWidgetState createState() => _SetFormWidgetState();
}

class _SetFormWidgetState extends State<SetFormWidget> {
  double _currentSetSliderValue = Set.DEFAULT_NR_SETS.toDouble();
  bool _detailed = false;

  // Form stuff
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _exercisesController = TextEditingController();

  /// Removes an exercise from the current set
  void removeExercise(Exercise exercise) {
    setState(() {
      widget._set.removeExercise(exercise);
    });
  }

  /// Adds an exercise to the current set
  void addExercise(Exercise exercise) {
    setState(() {
      widget._set.addExercise(exercise);
      addSettings();
    });
  }

  /// Adds settings to the set
  void addSettings() {
    widget._set.settings = [];
    for (var exercise in widget._set.exercisesObj) {
      for (int loop = 0; loop < widget._set.sets; loop++) {
        Setting setting = Setting.empty();
        setting.exerciseObj = exercise;
        widget._set.settings.add(setting);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TypeAheadFormField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: this._exercisesController,
              decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.exercise,
                  helperMaxLines: 3,
                  helperText: AppLocalizations.of(context)!.selectExercises),
            ),
            suggestionsCallback: (pattern) async {
              return await Provider.of<Exercises>(context, listen: false).searchExercise(pattern);
            },
            itemBuilder: (context, suggestion) {
              final result = suggestion! as Map;

              String serverUrl = Provider.of<Auth>(context, listen: false).serverUrl!;
              final exercise =
                  Provider.of<Exercises>(context, listen: false).findById(result['data']['id']);
              return ListTile(
                leading: Container(
                  width: 45,
                  child: ExerciseImageWidget(image: exercise.getMainImage),
                ),
                title: Text(exercise.name),
                subtitle: Text(
                    '${exercise.categoryObj.name} / ${exercise.equipment.map((e) => e.name).join(', ')}'),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            onSuggestionSelected: (suggestion) {
              final result = suggestion! as Map;
              final exercise =
                  Provider.of<Exercises>(context, listen: false).findById(result['data']['id']);
              addExercise(exercise);
              this._exercisesController.text = '';
            },
            validator: (value) {
              if (value!.isEmpty) {
                return AppLocalizations.of(context)!.selectExercise;
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          Text(AppLocalizations.of(context)!.nrOfSets(_currentSetSliderValue.round())),
          Slider(
            value: _currentSetSliderValue,
            min: 1,
            max: 10,
            divisions: 10,
            label: _currentSetSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                widget._set.sets = value.round();
                _currentSetSliderValue = value;
                addSettings();
              });
            },
          ),
          SwitchListTile(
            title: Text(AppLocalizations.of(context)!.toggleDetails),
            value: _detailed,
            onChanged: (value) {
              setState(() {
                _detailed = !_detailed;
              });
            },
          ),
          Text(AppLocalizations.of(context)!.sameRepetitions),
          ...widget._set.exercisesObj.map((exercise) {
            final settings =
                widget._set.settings.where((e) => e.exerciseObj.id == exercise.id).toList();

            return ExerciseSetting(
              exercise,
              settings,
              _detailed,
              _currentSetSliderValue,
              removeExercise,
            );
          }).toList(),
          ElevatedButton(
            child: Text(AppLocalizations.of(context)!.save),
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (!isValid) {
                return;
              }
              _formKey.currentState!.save();

              final workoutProvider = Provider.of<WorkoutPlans>(context, listen: false);

              // Save set
              Set setDb = await workoutProvider.addSet(widget._set);
              widget._set.id = setDb.id;

              // Remove unused settings
              widget._set.settings.removeWhere((s) => s.weight == null && s.reps == null);

              // Save remaining settings
              for (var setting in widget._set.settings) {
                setting.setId = setDb.id!;

                setting.weightUnitId = workoutProvider.defaultWeightUnit.id;
                setting.repetitionUnitId = workoutProvider.defaultRepetitionUnit.id;
                setting.comment = '';
                setting.repsText = 'temp text';

                Setting settingDb = await workoutProvider.addSetting(setting);
                setting.id = settingDb.id;
              }

              // Add to workout day
              widget._day.sets.add(widget._set);

              // Close the bottom sheet
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class ExerciseSetting extends StatelessWidget {
  final Exercise _exercise;
  int _numberOfSets = 4;
  bool _detailed;
  final Function removeExercise;
  List<Setting> _settings = [];

  ExerciseSetting(
    this._exercise,
    this._settings,
    this._detailed,
    double sliderValue,
    this.removeExercise,
  ) {
    this._numberOfSets = sliderValue.round();
  }

  Widget getRow() {
    List<Widget> out = [];
    for (var i = 0; i < _numberOfSets; i++) {
      var setting = _settings[i];
      out.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RepsInputWidget(setting),
            SizedBox(width: 4),
            if (_detailed) WeightUnitInputWidget(key: Key(i.toString())),
            WeightInputWidget(setting),
            SizedBox(width: 4),
            if (_detailed) RepetitionUnitInputWidget(),
            if (_detailed) RiRInputWidget(),
          ],
        ),
      );
    }
    return Column(
      children: out,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(_exercise.name, style: TextStyle(fontWeight: FontWeight.bold)),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            removeExercise(_exercise);
          },
        ),
        //ExerciseImage(imageUrl: _exercise.images.first.url),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(AppLocalizations.of(context)!.repetitions),
            if (_detailed) Text(AppLocalizations.of(context)!.unit),
            Text(AppLocalizations.of(context)!.weight),
            if (_detailed) Text(AppLocalizations.of(context)!.unit),
            if (_detailed) Text(AppLocalizations.of(context)!.rir),
          ],
        ),
        getRow(),
      ],
    );
  }
}

class RepsInputWidget extends StatelessWidget {
  final _repsController = TextEditingController();
  Setting _setting;

  RepsInputWidget(this._setting);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        //decoration: InputDecoration(labelText: 'Reps'),
        controller: _repsController,
        keyboardType: TextInputType.number,
        onSaved: (newValue) {
          if (newValue != null && newValue != '') {
            _setting.reps = int.parse(newValue);
          }
        },
      ),
    );
  }
}

class WeightInputWidget extends StatelessWidget {
  final _weightController = TextEditingController();
  Setting _setting;

  WeightInputWidget(this._setting);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        //decoration: InputDecoration(labelText: 'Weight'),
        controller: _weightController,
        keyboardType: TextInputType.number,
        onSaved: (newValue) {
          if (newValue != null && newValue != '') {
            _setting.weight = double.parse(newValue);
          }
        },
      ),
    );
  }
}

class RiRInputWidget extends StatefulWidget {
  RiRInputWidget();

  @override
  _RiRInputWidgetState createState() => _RiRInputWidgetState();
}

class _RiRInputWidgetState extends State<RiRInputWidget> {
  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      underline: Container(
        height: 0,
        //color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['1', '1.5', '2', '2.5', '3', '3.5']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class WeightUnitInputWidget extends StatefulWidget {
  WeightUnitInputWidget({Key? key}) : super(key: key);

  @override
  _WeightUnitInputWidgetState createState() => _WeightUnitInputWidgetState();
}

class _WeightUnitInputWidgetState extends State<WeightUnitInputWidget> {
  late WeightUnit dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<WeightUnit>(
      value: dropdownValue,
      underline: Container(
        height: 0,
        //  color: Colors.deepPurpleAccent,
      ),
      onChanged: (WeightUnit? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: Provider.of<WorkoutPlans>(context, listen: false)
          .weightUnits
          .map<DropdownMenuItem<WeightUnit>>((WeightUnit value) {
        return DropdownMenuItem<WeightUnit>(
          value: value,
          child: Text(
            value.name,
            style: TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
    );
  }
}

class RepetitionUnitInputWidget extends StatefulWidget {
  RepetitionUnitInputWidget();

  @override
  _RepetitionUnitInputWidgetState createState() => _RepetitionUnitInputWidgetState();
}

class _RepetitionUnitInputWidgetState extends State<RepetitionUnitInputWidget> {
  late RepetitionUnit dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<RepetitionUnit>(
      value: dropdownValue,
      underline: Container(
        height: 0,
        //  color: Colors.deepPurpleAccent,
      ),
      onChanged: (RepetitionUnit? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: Provider.of<WorkoutPlans>(context, listen: false)
          .repetitionUnits
          .map<DropdownMenuItem<RepetitionUnit>>((RepetitionUnit value) {
        return DropdownMenuItem<RepetitionUnit>(
          value: value,
          child: Text(
            value.name,
            style: TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
    );
  }
}

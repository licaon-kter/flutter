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
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wger/helpers/consts.dart';
import 'package:wger/models/exercises/exercise.dart';
import 'package:wger/models/http_exception.dart';
import 'package:wger/models/workouts/day.dart';
import 'package:wger/models/workouts/log.dart';
import 'package:wger/models/workouts/repetition_unit.dart';
import 'package:wger/models/workouts/session.dart';
import 'package:wger/models/workouts/set.dart';
import 'package:wger/models/workouts/setting.dart';
import 'package:wger/models/workouts/weight_unit.dart';
import 'package:wger/models/workouts/workout_plan.dart';
import 'package:wger/providers/auth.dart';
import 'package:wger/providers/base_provider.dart';
import 'package:wger/providers/exercises.dart';

class WorkoutPlans extends WgerBaseProvider with ChangeNotifier {
  static const _workoutPlansUrlPath = 'workout';
  static const _daysUrlPath = 'day';
  static const _setsUrlPath = 'set';
  static const _settingsUrlPath = 'setting';
  static const _logsUrlPath = 'workoutlog';
  static const _sessionUrlPath = 'workoutsession';
  static const _weightUnitUrlPath = 'setting-weightunit';
  static const _repetitionUnitUrlPath = 'setting-repetitionunit';

  WorkoutPlan? _currentPlan;
  Exercises _exercises;
  List<WorkoutPlan> _workoutPlans = [];
  List<WeightUnit> _weightUnits = [];
  List<RepetitionUnit> _repetitionUnit = [];

  WorkoutPlans(Auth auth, Exercises exercises, List<WorkoutPlan> entries, [http.Client? client])
      : this._exercises = exercises,
        this._workoutPlans = entries,
        super(auth, client);

  List<WorkoutPlan> get items {
    return [..._workoutPlans];
  }

  List<WeightUnit> get weightUnits {
    return [..._weightUnits];
  }

  /// Return the default weight unit (kg)
  WeightUnit get defaultWeightUnit {
    return _weightUnits.firstWhere((element) => element.id == DEFAULT_WEIGHT_UNIT);
  }

  List<RepetitionUnit> get repetitionUnits {
    return [..._repetitionUnit];
  }

  /// Return the default weight unit (reps)
  RepetitionUnit get defaultRepetitionUnit {
    return _repetitionUnit.firstWhere((element) => element.id == DEFAULT_REPETITION_UNIT);
  }

  WorkoutPlan findById(int id) {
    return _workoutPlans.firstWhere((workoutPlan) => workoutPlan.id == id);
  }

  int findIndexById(int id) {
    return _workoutPlans.indexWhere((workoutPlan) => workoutPlan.id == id);
  }

  /// Set the currently "active" workout plan
  void setCurrentPlan(int id) {
    _currentPlan = findById(id);
  }

  /// Returns the currently "active" workout plan
  WorkoutPlan? get currentPlan {
    return _currentPlan;
  }

  /// Reset the currently "active" workout plan to null
  void resetCurrentPlan() {
    _currentPlan = null;
  }

  /// Returns the current active workout plan. At the moment this is just
  /// the latest, but this might change in the future.
  WorkoutPlan? get activePlan {
    if (_workoutPlans.length > 0) {
      return _workoutPlans.first;
    }
  }

  /*
   * Workouts
   */

  Future<void> fetchAndSetAllPlans() async {
    final data = await fetch(makeUrl(_workoutPlansUrlPath, query: {'ordering': '-creation_date'}));
    for (final entry in data['results']) {
      await fetchAndSetWorkoutPlan(entry['id']);
    }

    notifyListeners();
  }

  Future<void> fetchAndSetWorkoutPlan(int workoutId) async {
    // Plan
    final planData = await fetch(makeUrl(_workoutPlansUrlPath, id: workoutId));
    final plan = WorkoutPlan.fromJson(planData);

    // Days
    List<Day> days = [];
    final daysData = await fetch(makeUrl(_daysUrlPath, query: {'training': workoutId.toString()}));
    for (final dayEntry in daysData['results']) {
      final day = Day.fromJson(dayEntry);

      // Sets
      List<Set> sets = [];
      final setData = await fetch(makeUrl(_setsUrlPath, query: {'exerciseday': day.id.toString()}));
      for (final setEntry in setData['results']) {
        final workoutSet = Set.fromJson(setEntry);

        // Settings
        List<Setting> settings = [];
        final settingData = await fetch(
          makeUrl(_settingsUrlPath, query: {'set': workoutSet.id.toString()}),
        );
        for (final settingEntry in settingData['results']) {
          final workoutSetting = Setting.fromJson(settingEntry);

          workoutSetting.exerciseObj = _exercises.findById(workoutSetting.exerciseId);
          workoutSetting.weightUnitObj = _weightUnits.firstWhere(
            (e) => e.id == workoutSetting.weightUnitId,
          );
          workoutSetting.repetitionUnitObj = _repetitionUnit.firstWhere(
            (e) => e.id == workoutSetting.repetitionUnitId,
          );
          if (!workoutSet.exercisesIds.contains(workoutSetting.exerciseId)) {
            workoutSet.addExercise(workoutSetting.exerciseObj);
          }
          workoutSetting.repsText = 'FIXME!';
          settings.add(workoutSetting);
        }
        workoutSet.settings = settings;
        sets.add(workoutSet);
      }
      day.sets = sets;
      days.add(day);
    }
    plan.days = days;

    // Logs
    final logData = await fetch(makeUrl(_logsUrlPath, query: {'workout': workoutId.toString()}));
    for (final entry in logData['results']) {
      plan.logs.add(Log.fromJson(entry));
    }

    // ... and done
    _workoutPlans.add(plan);
    _workoutPlans.sort((a, b) => b.creationDate.compareTo(a.creationDate));
    notifyListeners();
  }

  Future<void> fetchAndSetWorkouts() async {
    final data = await fetch(makeUrl(_workoutPlansUrlPath, query: {'ordering': '-creation_date'}));
    final List<WorkoutPlan> loadedWorkoutPlans = [];

    for (final entry in data['results']) {
      loadedWorkoutPlans.add(WorkoutPlan.fromJson(entry));
    }

    _workoutPlans = loadedWorkoutPlans;
    notifyListeners();
  }

  Future<WorkoutPlan> postWorkout(WorkoutPlan workout) async {
    final data = await post(workout.toJson(), makeUrl(_workoutPlansUrlPath));
    final plan = WorkoutPlan.fromJson(data);
    _workoutPlans.insert(0, plan);
    notifyListeners();
    return plan;
  }

  Future<WorkoutPlan> patchWorkout(WorkoutPlan workout) async {
    final data = await patch(workout.toJson(), makeUrl(_workoutPlansUrlPath, id: workout.id));
    final plan = WorkoutPlan.fromJson(data);
    _workoutPlans[findIndexById(plan.id!)] = plan;
    notifyListeners();
    return plan;
  }

  Future<void> deleteWorkout(int id) async {
    final existingWorkoutIndex = _workoutPlans.indexWhere((element) => element.id == id);
    var existingWorkout = _workoutPlans[existingWorkoutIndex];
    _workoutPlans.removeAt(existingWorkoutIndex);
    notifyListeners();

    final response = await deleteRequest(_workoutPlansUrlPath, id);

    if (response.statusCode >= 400) {
      _workoutPlans.insert(existingWorkoutIndex, existingWorkout);
      notifyListeners();
      throw WgerHttpException(response.body);
    }
  }

  Future<Map<String, dynamic>> fetchLogData(WorkoutPlan workout, Exercise exercise) async {
    final data = await fetch(
      makeUrl(
        _workoutPlansUrlPath,
        id: workout.id,
        objectMethod: 'log_data',
        query: {'id': exercise.id.toString()},
      ),
    );
    return data;
  }

  /// Fetch and set weight units for workout (kg, lb, plate, etc.)
  Future<void> fetchAndSetRepetitionUnits() async {
    final response = await client.get(makeUrl(_repetitionUnitUrlPath));
    final units = json.decode(response.body) as Map<String, dynamic>;
    try {
      for (final unit in units['results']) {
        _repetitionUnit.add(RepetitionUnit.fromJson(unit));
      }
    } catch (error) {
      throw (error);
    }
  }

  /// Fetch and set weight units for workout (kg, lb, plate, etc.)
  Future<void> fetchAndSetWeightUnits() async {
    final response = await client.get(makeUrl(_weightUnitUrlPath));
    final units = json.decode(response.body) as Map<String, dynamic>;
    try {
      for (final unit in units['results']) {
        _weightUnits.add(WeightUnit.fromJson(unit));
      }
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetUnits() async {
    // Load units from cache, if available
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('workoutUnits')) {
      final unitData = json.decode(prefs.getString('workoutUnits')!);
      if (DateTime.parse(unitData['expiresIn']).isAfter(DateTime.now())) {
        unitData['repetitionUnits'].forEach(
          (e) => _repetitionUnit.add(RepetitionUnit.fromJson(e)),
        );
        unitData['weightUnit'].forEach(
          (e) => _weightUnits.add(WeightUnit.fromJson(e)),
        );
        log("Read workout units data from cache. Valid till ${unitData['expiresIn']}");
        return;
      }
    }

    // Load units
    await fetchAndSetWeightUnits();
    await fetchAndSetRepetitionUnits();

    // Save the result to the cache
    final exerciseData = {
      'date': DateTime.now().toIso8601String(),
      'expiresIn': DateTime.now().add(Duration(days: DAYS_TO_CACHE)).toIso8601String(),
      'repetitionUnits': _repetitionUnit.map((e) => e.toJson()).toList(),
      'weightUnit': _weightUnits.map((e) => e.toJson()).toList(),
    };
    prefs.setString('workoutUnits', json.encode(exerciseData));
    notifyListeners();
  }

  /*
   * Days
   */
  Future<Day> addDay(Day day, WorkoutPlan workout) async {
    /*
     * Saves a new day instance to the DB and adds it to the given workout
     */
    day.workoutId = workout.id!;
    final data = await post(day.toJson(), makeUrl(_daysUrlPath));
    day = Day.fromJson(data);
    day.sets = [];
    workout.days.insert(0, day);
    notifyListeners();
    return day;
  }

  Future<void> deleteDay(Day day) async {
    await deleteRequest(_daysUrlPath, day.id!);
    for (var workout in _workoutPlans) {
      workout.days.removeWhere((element) => element.id == day.id);
    }
    notifyListeners();
  }

  /*
   * Sets
   */
  Future<Set> addSet(Set workoutSet) async {
    final data = await post(workoutSet.toJson(), makeUrl(_setsUrlPath));
    final set = Set.fromJson(data);
    notifyListeners();
    return set;
  }

  Future<void> deleteSet(Set workoutSet) async {
    await deleteRequest(_setsUrlPath, workoutSet.id!);

    for (var workout in _workoutPlans) {
      for (var day in workout.days) {
        day.sets.removeWhere((element) => element.id == workoutSet.id);
      }
    }
    notifyListeners();
  }

  /*
   * Setting
   */
  Future<Setting> addSetting(Setting workoutSetting) async {
    final data = await post(workoutSetting.toJson(), makeUrl(_settingsUrlPath));
    final setting = Setting.fromJson(data);
    notifyListeners();
    return setting;
  }

  /*
   * Sessions
   */
  Future<dynamic> fetchSessionData() async {
    final data = await fetch(
      makeUrl(_sessionUrlPath),
    );
    return data;
  }

  Future<WorkoutSession> addSession(WorkoutSession session) async {
    final data = await post(session.toJson(), makeUrl(_sessionUrlPath));
    final newSession = WorkoutSession.fromJson(data);
    notifyListeners();
    return newSession;
  }

  /*
   * Logs
   */
  Future<Log> addLog(Log log) async {
    final data = await post(log.toJson(), makeUrl(_logsUrlPath));
    final newLog = Log.fromJson(data);
    notifyListeners();
    return newLog;
  }
}

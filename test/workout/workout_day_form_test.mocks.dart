// Mocks generated by Mockito 5.4.2 from annotations
// in wger/test/workout/workout_day_form_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;
import 'dart:ui' as _i15;

import 'package:mockito/mockito.dart' as _i1;
import 'package:wger/models/exercises/base.dart' as _i13;
import 'package:wger/models/exercises/translation.dart' as _i14;
import 'package:wger/models/workouts/day.dart' as _i6;
import 'package:wger/models/workouts/log.dart' as _i10;
import 'package:wger/models/workouts/repetition_unit.dart' as _i4;
import 'package:wger/models/workouts/session.dart' as _i9;
import 'package:wger/models/workouts/set.dart' as _i7;
import 'package:wger/models/workouts/setting.dart' as _i8;
import 'package:wger/models/workouts/weight_unit.dart' as _i3;
import 'package:wger/models/workouts/workout_plan.dart' as _i5;
import 'package:wger/providers/base_provider.dart' as _i2;
import 'package:wger/providers/workout_plans.dart' as _i11;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeWgerBaseProvider_0 extends _i1.SmartFake
    implements _i2.WgerBaseProvider {
  _FakeWgerBaseProvider_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeightUnit_1 extends _i1.SmartFake implements _i3.WeightUnit {
  _FakeWeightUnit_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRepetitionUnit_2 extends _i1.SmartFake
    implements _i4.RepetitionUnit {
  _FakeRepetitionUnit_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWorkoutPlan_3 extends _i1.SmartFake implements _i5.WorkoutPlan {
  _FakeWorkoutPlan_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDay_4 extends _i1.SmartFake implements _i6.Day {
  _FakeDay_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSet_5 extends _i1.SmartFake implements _i7.Set {
  _FakeSet_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSetting_6 extends _i1.SmartFake implements _i8.Setting {
  _FakeSetting_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWorkoutSession_7 extends _i1.SmartFake
    implements _i9.WorkoutSession {
  _FakeWorkoutSession_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLog_8 extends _i1.SmartFake implements _i10.Log {
  _FakeLog_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [WorkoutPlansProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockWorkoutPlansProvider extends _i1.Mock
    implements _i11.WorkoutPlansProvider {
  MockWorkoutPlansProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WgerBaseProvider get baseProvider => (super.noSuchMethod(
        Invocation.getter(#baseProvider),
        returnValue: _FakeWgerBaseProvider_0(
          this,
          Invocation.getter(#baseProvider),
        ),
      ) as _i2.WgerBaseProvider);

  @override
  List<_i5.WorkoutPlan> get items => (super.noSuchMethod(
        Invocation.getter(#items),
        returnValue: <_i5.WorkoutPlan>[],
      ) as List<_i5.WorkoutPlan>);

  @override
  List<_i3.WeightUnit> get weightUnits => (super.noSuchMethod(
        Invocation.getter(#weightUnits),
        returnValue: <_i3.WeightUnit>[],
      ) as List<_i3.WeightUnit>);

  @override
  _i3.WeightUnit get defaultWeightUnit => (super.noSuchMethod(
        Invocation.getter(#defaultWeightUnit),
        returnValue: _FakeWeightUnit_1(
          this,
          Invocation.getter(#defaultWeightUnit),
        ),
      ) as _i3.WeightUnit);

  @override
  List<_i4.RepetitionUnit> get repetitionUnits => (super.noSuchMethod(
        Invocation.getter(#repetitionUnits),
        returnValue: <_i4.RepetitionUnit>[],
      ) as List<_i4.RepetitionUnit>);

  @override
  _i4.RepetitionUnit get defaultRepetitionUnit => (super.noSuchMethod(
        Invocation.getter(#defaultRepetitionUnit),
        returnValue: _FakeRepetitionUnit_2(
          this,
          Invocation.getter(#defaultRepetitionUnit),
        ),
      ) as _i4.RepetitionUnit);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void clear() => super.noSuchMethod(
        Invocation.method(
          #clear,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i5.WorkoutPlan> getPlans() => (super.noSuchMethod(
        Invocation.method(
          #getPlans,
          [],
        ),
        returnValue: <_i5.WorkoutPlan>[],
      ) as List<_i5.WorkoutPlan>);

  @override
  _i5.WorkoutPlan findById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findById,
          [id],
        ),
        returnValue: _FakeWorkoutPlan_3(
          this,
          Invocation.method(
            #findById,
            [id],
          ),
        ),
      ) as _i5.WorkoutPlan);

  @override
  int findIndexById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findIndexById,
          [id],
        ),
        returnValue: 0,
      ) as int);

  @override
  void setCurrentPlan(int? id) => super.noSuchMethod(
        Invocation.method(
          #setCurrentPlan,
          [id],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resetCurrentPlan() => super.noSuchMethod(
        Invocation.method(
          #resetCurrentPlan,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i12.Future<void> fetchAndSetAllPlansFull() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetAllPlansFull,
          [],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<void> fetchAndSetAllPlansSparse() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetAllPlansSparse,
          [],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<_i5.WorkoutPlan> fetchAndSetPlanSparse(int? planId) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetPlanSparse,
          [planId],
        ),
        returnValue: _i12.Future<_i5.WorkoutPlan>.value(_FakeWorkoutPlan_3(
          this,
          Invocation.method(
            #fetchAndSetPlanSparse,
            [planId],
          ),
        )),
      ) as _i12.Future<_i5.WorkoutPlan>);

  @override
  _i12.Future<_i5.WorkoutPlan> fetchAndSetWorkoutPlanFull(int? workoutId) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetWorkoutPlanFull,
          [workoutId],
        ),
        returnValue: _i12.Future<_i5.WorkoutPlan>.value(_FakeWorkoutPlan_3(
          this,
          Invocation.method(
            #fetchAndSetWorkoutPlanFull,
            [workoutId],
          ),
        )),
      ) as _i12.Future<_i5.WorkoutPlan>);

  @override
  _i12.Future<_i5.WorkoutPlan> addWorkout(_i5.WorkoutPlan? workout) =>
      (super.noSuchMethod(
        Invocation.method(
          #addWorkout,
          [workout],
        ),
        returnValue: _i12.Future<_i5.WorkoutPlan>.value(_FakeWorkoutPlan_3(
          this,
          Invocation.method(
            #addWorkout,
            [workout],
          ),
        )),
      ) as _i12.Future<_i5.WorkoutPlan>);

  @override
  _i12.Future<void> editWorkout(_i5.WorkoutPlan? workout) =>
      (super.noSuchMethod(
        Invocation.method(
          #editWorkout,
          [workout],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<void> deleteWorkout(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteWorkout,
          [id],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<Map<String, dynamic>> fetchLogData(
    _i5.WorkoutPlan? workout,
    _i13.ExerciseBase? base,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchLogData,
          [
            workout,
            base,
          ],
        ),
        returnValue:
            _i12.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i12.Future<Map<String, dynamic>>);

  @override
  _i12.Future<void> fetchAndSetRepetitionUnits() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetRepetitionUnits,
          [],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<void> fetchAndSetWeightUnits() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetWeightUnits,
          [],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<void> fetchAndSetUnits() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetUnits,
          [],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<_i6.Day> addDay(
    _i6.Day? day,
    _i5.WorkoutPlan? workout,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addDay,
          [
            day,
            workout,
          ],
        ),
        returnValue: _i12.Future<_i6.Day>.value(_FakeDay_4(
          this,
          Invocation.method(
            #addDay,
            [
              day,
              workout,
            ],
          ),
        )),
      ) as _i12.Future<_i6.Day>);

  @override
  _i12.Future<void> editDay(_i6.Day? day) => (super.noSuchMethod(
        Invocation.method(
          #editDay,
          [day],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<void> deleteDay(_i6.Day? day) => (super.noSuchMethod(
        Invocation.method(
          #deleteDay,
          [day],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<_i7.Set> addSet(_i7.Set? workoutSet) => (super.noSuchMethod(
        Invocation.method(
          #addSet,
          [workoutSet],
        ),
        returnValue: _i12.Future<_i7.Set>.value(_FakeSet_5(
          this,
          Invocation.method(
            #addSet,
            [workoutSet],
          ),
        )),
      ) as _i12.Future<_i7.Set>);

  @override
  _i12.Future<void> editSet(_i7.Set? workoutSet) => (super.noSuchMethod(
        Invocation.method(
          #editSet,
          [workoutSet],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<List<_i7.Set>> reorderSets(
    List<_i7.Set>? sets,
    int? startIndex,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #reorderSets,
          [
            sets,
            startIndex,
          ],
        ),
        returnValue: _i12.Future<List<_i7.Set>>.value(<_i7.Set>[]),
      ) as _i12.Future<List<_i7.Set>>);

  @override
  _i12.Future<void> fetchComputedSettings(_i7.Set? workoutSet) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchComputedSettings,
          [workoutSet],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<String> fetchSmartText(
    _i7.Set? workoutSet,
    _i14.Translation? exercise,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchSmartText,
          [
            workoutSet,
            exercise,
          ],
        ),
        returnValue: _i12.Future<String>.value(''),
      ) as _i12.Future<String>);

  @override
  _i12.Future<void> deleteSet(_i7.Set? workoutSet) => (super.noSuchMethod(
        Invocation.method(
          #deleteSet,
          [workoutSet],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  _i12.Future<_i8.Setting> addSetting(_i8.Setting? workoutSetting) =>
      (super.noSuchMethod(
        Invocation.method(
          #addSetting,
          [workoutSetting],
        ),
        returnValue: _i12.Future<_i8.Setting>.value(_FakeSetting_6(
          this,
          Invocation.method(
            #addSetting,
            [workoutSetting],
          ),
        )),
      ) as _i12.Future<_i8.Setting>);

  @override
  _i12.Future<dynamic> fetchSessionData() => (super.noSuchMethod(
        Invocation.method(
          #fetchSessionData,
          [],
        ),
        returnValue: _i12.Future<dynamic>.value(),
      ) as _i12.Future<dynamic>);

  @override
  _i12.Future<_i9.WorkoutSession> addSession(_i9.WorkoutSession? session) =>
      (super.noSuchMethod(
        Invocation.method(
          #addSession,
          [session],
        ),
        returnValue:
            _i12.Future<_i9.WorkoutSession>.value(_FakeWorkoutSession_7(
          this,
          Invocation.method(
            #addSession,
            [session],
          ),
        )),
      ) as _i12.Future<_i9.WorkoutSession>);

  @override
  _i12.Future<_i10.Log> addLog(_i10.Log? log) => (super.noSuchMethod(
        Invocation.method(
          #addLog,
          [log],
        ),
        returnValue: _i12.Future<_i10.Log>.value(_FakeLog_8(
          this,
          Invocation.method(
            #addLog,
            [log],
          ),
        )),
      ) as _i12.Future<_i10.Log>);

  @override
  _i12.Future<void> deleteLog(_i10.Log? log) => (super.noSuchMethod(
        Invocation.method(
          #deleteLog,
          [log],
        ),
        returnValue: _i12.Future<void>.value(),
        returnValueForMissingStub: _i12.Future<void>.value(),
      ) as _i12.Future<void>);

  @override
  void addListener(_i15.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i15.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

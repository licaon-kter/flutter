// Mocks generated by Mockito 5.3.2 from annotations
// in wger/test/workout/weight_unit_form_widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:http/http.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:wger/models/body_weight/weight_entry.dart' as _i4;
import 'package:wger/providers/auth.dart' as _i2;
import 'package:wger/providers/body_weight.dart' as _i5;

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

class _FakeAuthProvider_0 extends _i1.SmartFake implements _i2.AuthProvider {
  _FakeAuthProvider_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClient_1 extends _i1.SmartFake implements _i3.Client {
  _FakeClient_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWeightEntry_2 extends _i1.SmartFake implements _i4.WeightEntry {
  _FakeWeightEntry_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUri_3 extends _i1.SmartFake implements Uri {
  _FakeUri_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_4 extends _i1.SmartFake implements _i3.Response {
  _FakeResponse_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BodyWeightProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockBodyWeightProvider extends _i1.Mock
    implements _i5.BodyWeightProvider {
  MockBodyWeightProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i4.WeightEntry> get items => (super.noSuchMethod(
        Invocation.getter(#items),
        returnValue: <_i4.WeightEntry>[],
      ) as List<_i4.WeightEntry>);
  @override
  _i2.AuthProvider get auth => (super.noSuchMethod(
        Invocation.getter(#auth),
        returnValue: _FakeAuthProvider_0(
          this,
          Invocation.getter(#auth),
        ),
      ) as _i2.AuthProvider);
  @override
  set auth(_i2.AuthProvider? _auth) => super.noSuchMethod(
        Invocation.setter(
          #auth,
          _auth,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_1(
          this,
          Invocation.getter(#client),
        ),
      ) as _i3.Client);
  @override
  set client(_i3.Client? _client) => super.noSuchMethod(
        Invocation.setter(
          #client,
          _client,
        ),
        returnValueForMissingStub: null,
      );
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
  _i4.WeightEntry findById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #findById,
          [id],
        ),
        returnValue: _FakeWeightEntry_2(
          this,
          Invocation.method(
            #findById,
            [id],
          ),
        ),
      ) as _i4.WeightEntry);
  @override
  _i4.WeightEntry? findByDate(DateTime? date) =>
      (super.noSuchMethod(Invocation.method(
        #findByDate,
        [date],
      )) as _i4.WeightEntry?);
  @override
  _i6.Future<List<_i4.WeightEntry>> fetchAndSetEntries() => (super.noSuchMethod(
        Invocation.method(
          #fetchAndSetEntries,
          [],
        ),
        returnValue:
            _i6.Future<List<_i4.WeightEntry>>.value(<_i4.WeightEntry>[]),
      ) as _i6.Future<List<_i4.WeightEntry>>);
  @override
  _i6.Future<_i4.WeightEntry> addEntry(_i4.WeightEntry? entry) =>
      (super.noSuchMethod(
        Invocation.method(
          #addEntry,
          [entry],
        ),
        returnValue: _i6.Future<_i4.WeightEntry>.value(_FakeWeightEntry_2(
          this,
          Invocation.method(
            #addEntry,
            [entry],
          ),
        )),
      ) as _i6.Future<_i4.WeightEntry>);
  @override
  _i6.Future<void> editEntry(_i4.WeightEntry? entry) => (super.noSuchMethod(
        Invocation.method(
          #editEntry,
          [entry],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteEntry(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteEntry,
          [id],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  Map<String, String> getDefaultHeaders({dynamic includeAuth = false}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getDefaultHeaders,
          [],
          {#includeAuth: includeAuth},
        ),
        returnValue: <String, String>{},
      ) as Map<String, String>);
  @override
  Uri makeUrl(
    String? path, {
    int? id,
    String? objectMethod,
    Map<String, dynamic>? query,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #makeUrl,
          [path],
          {
            #id: id,
            #objectMethod: objectMethod,
            #query: query,
          },
        ),
        returnValue: _FakeUri_3(
          this,
          Invocation.method(
            #makeUrl,
            [path],
            {
              #id: id,
              #objectMethod: objectMethod,
              #query: query,
            },
          ),
        ),
      ) as Uri);
  @override
  _i6.Future<Map<String, dynamic>> fetch(Uri? uri) => (super.noSuchMethod(
        Invocation.method(
          #fetch,
          [uri],
        ),
        returnValue:
            _i6.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i6.Future<Map<String, dynamic>>);
  @override
  _i6.Future<Map<String, dynamic>> post(
    Map<String, dynamic>? data,
    Uri? uri,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [
            data,
            uri,
          ],
        ),
        returnValue:
            _i6.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i6.Future<Map<String, dynamic>>);
  @override
  _i6.Future<Map<String, dynamic>> patch(
    Map<String, dynamic>? data,
    Uri? uri,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [
            data,
            uri,
          ],
        ),
        returnValue:
            _i6.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i6.Future<Map<String, dynamic>>);
  @override
  _i6.Future<_i3.Response> deleteRequest(
    String? url,
    int? id,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteRequest,
          [
            url,
            id,
          ],
        ),
        returnValue: _i6.Future<_i3.Response>.value(_FakeResponse_4(
          this,
          Invocation.method(
            #deleteRequest,
            [
              url,
              id,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Response>);
  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
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

import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/0_data/models/advice_model.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('AdviceRemoteDatasource', () {
    group('Should return AdviceModel', () {
      test('when client response was 200 and has valid data', () async {
        final mockClient = MockClient();
        // final mockClient = MockClient((request) async {
        //   return Response(
        //     '{ "advice_id": 1, "advice": "test advice" }',
        //     200,
        //   );
        // });
        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDatasourceImpl(client: mockClient);

        when(
          mockClient.get(
              Uri.parse('https://api.flutter-community.com/api/v1/advice'),
              headers: {'Content-Type': 'application/json'}),
        ).thenAnswer(
          (_) async => Future.value(
            Response(
              '{"advice_id":1,"advice":"test advice"}',
              200,
            ),
          ),
        );
        final result = await adviceRemoteDatasourceUnderTest.getAdviceFromApi();
        expect(result, AdviceModel(advice: 'test advice', id: 1));
      });
    });

    group('should throw', () {
      test('a serverException when client response is not 200', () {
        final mockClient = MockClient();
        // final mockClient = MockClient((request) async {
        //   return Response(
        //     '',
        //     201,
        //   );
        // });
        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDatasourceImpl(client: mockClient);
        when(
          mockClient.get(
              Uri.parse('https://api.flutter-community.com/api/v1/advice'),
              headers: {'Content-Type': 'application/json'}),
        ).thenAnswer(
          (_) async => Future.value(
            Response(
              '{"advice_id":1,"advice":"test advice"}',
              201,
            ),
          ),
        );
        expect(
          adviceRemoteDatasourceUnderTest.getAdviceFromApi(),
          throwsA(isA<ServerException>()),
        );
      });

      test('a type error when Client response was 200 and data not valid', () {
        // final mockClient = MockClient((request) async {
        //   return Response(
        //     '{"advice": "test advice"}',
        //     200,
        //   );
        // });
        final mockClient = MockClient();

        when(
          mockClient.get(
              Uri.parse('https://api.flutter-community.com/api/v1/advice'),
              headers: {'Content-Type': 'application/json'}),
        ).thenAnswer(
          (_) async => Future.value(
            Response(
              '{"advice":"test advice"}',
              200,
            ),
          ),
        );

        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDatasourceImpl(client: mockClient);
        expect(
          adviceRemoteDatasourceUnderTest.getAdviceFromApi(),
          throwsA(isA<TypeError>()),
        );
      });
    });
  });
}

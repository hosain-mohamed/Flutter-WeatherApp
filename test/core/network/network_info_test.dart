import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:weather_app/core/network/network_info.dart';

// check that isConnected method of networkInfoImpl call DataconnectionChecker.hasconnection

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl( dataConnectionChecker: mockDataConnectionChecker);
  });

  test(
    'should call DataConnectionChecker.hasconnection', () async {
        final tHasConnectionFuture = Future.value(true);
    when(mockDataConnectionChecker.hasConnection)
        .thenAnswer((_)  => tHasConnectionFuture);
    final result = networkInfo.isConnected;
    verify(mockDataConnectionChecker.hasConnection);
    expect(result, tHasConnectionFuture);
  });
  
}

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

String url = 'http://192.168.0.23:8080';

final Client client =
    HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);


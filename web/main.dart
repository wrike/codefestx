import 'package:angular/angular.dart';
import 'package:codefest/app_component.template.dart' as ng;
import 'package:codefest/src/services/api_service.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:angular_router/angular_router.dart';

import 'main.template.dart' as self;
@GenerateInjector([
  // For local development without backend
  //ClassProvider<Client>(Client, useClass: ApiService),
  // For real development with backend
  ClassProvider<Client>(Client, useClass: BrowserClient),
  routerProvidersHash,
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}

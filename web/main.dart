import 'package:angular/angular.dart';
import 'package:codefest/app_component.template.dart' as ng;
import 'package:codefest/src/services/api_service.dart';
import 'package:http/http.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  ClassProvider(Client, useClass: ApiService),
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}

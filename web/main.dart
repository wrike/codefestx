import 'package:angular/angular.dart';
import 'package:codefest/app_component.template.dart' as ng;
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:angular_router/angular_router.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  ClassProvider<Client>(Client, useClass: BrowserClient),
  routerProviders,
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}

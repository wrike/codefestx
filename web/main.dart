import 'package:angular/angular.dart';
import 'package:codefest/app_component.template.dart' as ng;
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:angular_router/angular_router.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'main.template.dart' as self;

@GenerateInjector([
  ValueProvider.forToken(appBaseHref, '/'),
  ClassProvider<Client>(Client, useClass: BrowserClient),
  routerProviders,
])
final InjectorFactory injector = self.injector$Injector;

void main() {
  Intl.defaultLocale = 'ru_RU';
  initializeDateFormatting(Intl.defaultLocale);
  runApp(ng.AppComponentNgFactory, createInjector: injector);
}

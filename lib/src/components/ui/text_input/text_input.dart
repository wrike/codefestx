import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Component(
  selector: 'input[text-input]',
  template: '',
)
class TextInput implements AfterViewInit {
  final HtmlElement _hostElement;
  final NgZone _zone;

  @Input()
  bool isAutoFocused = false;

  TextInput(
    this._hostElement,
    this._zone,
  );

  InputElement get nativeElement => _hostElement as InputElement;

  @override
  void ngAfterViewInit() {
    _zone.runOutsideAngular(() {
      if (isAutoFocused) {
        _scheduleViewUpdate(() => nativeElement.focus());

        _scheduleViewUpdate(() => nativeElement.setSelectionRange(nativeElement.value.length, nativeElement.value.length));
      }
    });
  }

  void _scheduleViewUpdate(void Function() callback) {
    Timer(Duration.zero, () {
      callback();
    });
  }
}

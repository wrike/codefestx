import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';

@Component(
  selector: 'talk-post-input',
  templateUrl: 'talk_post_input_component.html',
  styleUrls: const ['talk_post_input_component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  directives: [
    NgIf,
    NgModel,
    formDirectives,
  ],
  preserveWhitespace: false,
)
class TalkPostInputComponent {
  bool get isAllowToSend => newPostText.length > 1 && newPostText.length <= 255;
  final _onSend = new StreamController<String>();

  @ViewChild('input')
  InputElement input;

  @Output()
  Stream get onSend => _onSend.stream;

  String newPostText = '';

  void send() {
    if (isAllowToSend) {
      _onSend.add(newPostText);
      newPostText = '';
    }
  }

  void focus() {
    input.focus();
  }

}

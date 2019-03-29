import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:codefest/src/components/ui/button/button.dart';

@Component(
  selector: 'talk-post-input',
  templateUrl: 'talk_post_input_component.html',
  styleUrls: const ['talk_post_input_component.css'],
  changeDetection: ChangeDetectionStrategy.OnPush,
  directives: [
    NgIf,
    NgModel,
    formDirectives,
    ButtonComponent,
  ],
  preserveWhitespace: false,
)
class TalkPostInputComponent {
  bool get isAllowToSend => newPostText.length > 1 && newPostText.length <= 255;
  final _onSend = new StreamController<String>();

  @HostBinding('class.message-send')
  final bool isHostMarked = true;

  @ViewChild('inputs')
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

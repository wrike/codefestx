import 'dart:html';

class DOMService {
  toggleDocumentClass(className, value) {
    window.document.documentElement.classes.toggle(className, value);
  }
}
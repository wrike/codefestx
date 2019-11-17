# Codefest X
Application for Codefest X

## Install 
```bash
pub upgrade
```

## Dev run
```bash
webdev serve
```
## For localization 

Generate ARB:
```bash
pub run intl_translation:extract_to_arb --output-dir=arb lib/src/services/intl_service.dart
```

Go to https://translate.google.com/toolkit/list?hl=en#translations/active

Generate Dart Dictionaries:
```bash
pub run intl_translation:generate_from_arb --output-dir=lib/intl lib/src/services/intl_service.dart arb/intl_*.arb
```

# Journal of Edits
with simple explainations of what I did and why

## `dart fix --apply`
First of all I've set up Visual Studio Code to apply auto fixes on your codebase on save.
Then, I added the most recent version of Dart lints, by:
  - Updating `flutter_lints v2.0.1` as a dependency on `pubspec.yaml`;
  - Adding `analysis_options.yaml` to instruct the linter on what to fix;
  - Executing `dart fix --dry-run` to review the changes that would be made by the formatter and linter;
  - Executing `dart fix --apply` to actually apply such changes.

This is useful because you want your codebase to be readable. This was _not_ requested by you, but I find it very important to deliver a better developer experience to you. One of the most important rules of Software Engineering that I've stumbled upon is: _In your dev path, you'll read *a lot* more code than you'll write, so make sure your code is readable_.

The previous sentence will guide most of the refactoring I'm going to apply in order to achieve the requirements in `TODO.md`.
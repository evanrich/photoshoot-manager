# Journal of Edits
A simple journal of what I did, in what order, and why.

## `dart fix --apply`
First of all I've set up Visual Studio Code to apply auto fixes on your codebase on save.
Then, I added the most recent version of Dart lints, by:
  - Updating `flutter_lints v2.0.1` as a dependency on `pubspec.yaml`;
  - Adding a new `analysis_options.yaml` file to instruct the linter on what to fix;
  - Executing `dart fix --dry-run` to review the changes that would be made by the formatter and linter;
  - Executing `dart fix --apply` to actually apply such changes.

This is useful because you want your codebase to be readable. This was _not_ requested by you, but I find it very important to deliver a better developer experience to you. One of the most important rules of Software Engineering that I've stumbled upon is: _In your dev path, you'll read **a lot** more code than you'll write, so make sure your code is readable_.

Since you need to _read_ my changes, I am sure this will surely help.

This reasoning will guide most of the refactoring I'm going to apply in order to achieve the requirements in `TODO.md`. Most of the times it feels like I'm "wasting time", but most of the steps are necessary to achieve what you've requested.

## Lifting State Up: a premise
The following is another important premise to allow your requested fixes to be implemented.

### What is State

Flutter heavily relies on the concept of "state": they dedicated a whole section of [their website](https://docs.flutter.dev/development/data-and-backend/state-mgmt) to explain what state is and why it is important.

In a nutshell: it is important [to distinguish](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app) between [ephemeral](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app#ephemeral-state) state and [app](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app#app-state) state:
 - The former concerns a single widget. It's state that is used to handle internal widget transformations. A good example would be animation state, that changes over time and concerns just that single widget. The official way Flutter handles ephimeral state is `setState`, as you've seen already;
 - The latter concerns the behavior of one or more widgets, based on information that can be found _anywhere_ in the Flutter tree. A good example would be... exactly your app! The user clicks on a menu item, and that (which is deep somewhere in the tree) triggers a state change that lies somewhere else (the screen you're trying to visualize). The official way Flutter handles global state is via `InheritedWidget`(s), which I am not going to directly implement because they're way too complicated (continue reading).

If you think about it, [while there is no clear distinction between those two](https://docs.flutter.dev/development/data-and-backend/state-mgmt/ephemeral-vs-app#there-is-no-clear-cut-rule), it's easy to reason around the two.

_“The rule of thumb is: Do whatever is less awkward.”_ is a very neat answer you can find on the docs.

### About your use case

Why are these premises very important?

Because it is very difficult to handle _global_ (or sub-global, non-ephimeral) state changes with just `setState`.

While it is 100% doable, it is not recommended for a long list of reasons. One problem could be exactly what your app is trying to do right now: `CustomDrawer` changes its internal state when `_isCollapsed` is changed. This information _must_ (as of now) be passed down to all of its children as a property, and this gets old pretty quickly.

There's also another problem: how could one trigger a page change on the click event (i.e. your request) with just `setState`? One solution could be to instantiate another `_selectedScreen` variable in your `HomeScreen` Widget (that should be a `Stateful` one) and then trigger `setState` from there on. This leads to even more complicated code, which not only is hard to maintain, but it's probably not so efficient (unless you're _very_ careful). If actually you want to dig into that, [there's a Widget for that](https://api.flutter.dev/flutter/widgets/StatefulBuilder-class.html) that can be used in combination with `InheritedWidget`.

### Riverpod
Ok, this long premise leads to a single, quick, easy solution: _using a state management package solution out there_.

While there are A LOT of good (and bad) state management related packages for Flutter, I **strongly** suggest to use a package called [Riverpod](https://riverpod.dev/) (I believe in it so much that I am contributing and sponsoring its ecosystem).

There's three reasons why I use Riverpod:
  - Google promotes Provider as the recommended approach: Riverpod is just Provider v2, created and maintained by the same guy, and soon enough (2023) Riverpod is going to replace Provider
  - It's very well documented and used by the community
  - It's simple to use and forces you to write good Flutter code

I highly recommend to read Riverpod's [documentation](https://riverpod.dev/docs/getting_started) when you've got some time.
ALSO Riverpod v2 is coming out soon with many simplifications. I'll point you towards a free youtube course based on Riverpod v2 when it comes out, if you want it.

In a nusthell, Riverpod offers a class named `Provider` that can be listened to. If a `Widget` listens to a `Provider`, then it's "subscribed" to it: when a Provider changes its inner value, it notifies the Widget that such change happened and, therefore, the Widget rebuilds with the new value given to it. Basically you can think of it as a more scalable and reusable `setState` pattern.

The beauty of this approach is that, while there are [several types of Providers](https://riverpod.dev/docs/concepts/providers#different-types-of-providers), `Provider` objects can be [combined](https://riverpod.dev/docs/concepts/combining_providers/). We'll see if such concepts will be useful along the way.

## Preliminary Work
As you've requested, it's time to use such concepts (and library) to implement our menu.

I am going to use a [StateProvider](https://riverpod.dev/docs/providers/state_provider) to encapsulate - you've guessed it - **state** regarding "Which menu item did the user click".

To do so I'll create an `enum` to represent such state. I'll make so that such `enum` holds everything we need to create the icons and redirect to the correct page.

### Flutter 2 --> Flutter 3
Before doing anything else, I'd like to have [enhanced enums](https://medium.com/dartlang/dart-2-17-b216bfc80c5d) enabled on this project. To do so, we must update the Dart's SDK to be > 2.17 (released on May, 2022).

This allows to also fix other minor lints.

Don't worry, the migration is painless as there is basically no breaking change between Flutter 2 and Flutter 3. Make sure you upgrade your SDK on your machine by running `flutter upgrade`.

### Creating State
I've created the `enum` and its `StateNotifier` (to hold state) in `home_screen_state.dart`.

The enum holds its corresponding screen to be shown in it.

A simple `StateProvider`exposes this state so that it can be listened to from our Widget Tree.
As the documentation of Riverpod states, one could listen to a Provider like so:

```dart
class MyListenerWidget extends ConsumerWidget {  // Riverpod special Widget!
  const MyListenerWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {  // Riverpod special build method
    // the following means: "I'm listening to this provider AND I will rebuild on its changes"
    final selectedScreen = ref.watch(selectedPageProvider);  

    return Container(
      // do something with `selectedScreen`...
    );
  }
}
```

The above example is actually 99% close to the actual implementation: yes, that's really all it takes.

### Refactoring of the app
Now we're ready to change your Widget Tree so that we can satisfy the requirements; before we actually write code that behaves as mentioned above, we need to touch the code base once more.

#### Renaming and small refactorings
First, we're going to refactor the `HomeScreen` widget by renaming it. There should be a global "AppWidget" that reacts to state changes. `HomeScreen` should just refer - indeed - to the home screen.

Then, I realize that the correct naming of these Widgets should be "Pages". We are actually implementing - by hand - the navigation between pages. The App's architecture should be:
  + main.dart
  + app_state.dart
  + app_providers.dart
  + pages/
    + home/home_page.dart
    + calendar/calendar_page.dart
    + etc.

#### Creation of the pages
Then, I'll create some of the screens required (I'll do it by intuition with respect to what I see in the menu icons).

I'll leave some out for your if you want to get your hands dirty (I can do that too, if you want).

Then, let's have the enum state contain the correct pages.

#### A UX/UI problem
I postponed this fix until now, but I think it's a good time to do it: our drawer _overflows_ its available space (or at least it does on my screen).

This has to be fixed or I wouldn't be able to go ahead otherwise.

To avoid this, one simple solution could be to wrap our drawer in a `SingleChildScrollView`, so that the user can scroll trough the icons. Unluckily it's not that straightforward, as `Column`s and `ScrollView`s "conflict" between each other (we need to be careful towards the Flutter's algorithm).

I'll avoid explaining why I slightly refactored this UI part, but I can explain later if you need. Now, let's actually implement what you need.


## Implementing the screen-change
Finally, we should trigger the screen change via the `onTap` event.

Simply, instead of searching a way to use `setState` on the icon widget, we use Riverpod to trigger the state change via `StateProvider`.

Some refactoring are be applied, too, in order to have more readable and reusable code.
  1. I've moved out the "fixed" items for each menu item to the state, so that their features are centralized in one single, visible, reusable piece of logic;
  2. I refactored `CustomListTile` indeed accept our enum as property, so it can exploit the logic in it

Now we're ready to trigger the `onTap` event via a single line of code:
```dart
  ref.read(selectedPageProvider.notifier).state = page;
```
Here, we tell the `StateProvider`: "hey, the user requested for _this_ page. Change it.".

And... voilà! The listeners will react to that change (as we did a few steps ago): the page behind changes.

## The "jump" effect on the Drawer's animation
The reason there's a jump at the start and at the end of the animation is straightforward: starting and final sizes don't match when the animation starts.

A quick analysis lead me towards noticing the following into the drawer:
  1. There are _many_ `AnimatedContainer`s: one for each tile, and one for the parent widget (drawer). Probably you've added so many of them because you've noticed that when the first `AnimatedContainer` is animating (expanding / shrinking) your contents will most likely show overflowing warnings while animating. This can be avoided by implementing our own custom animation. But to address and to actually _show_ that this is the case, we should simplify the layouting and the implementations. This should highlight the "jump problem" better. So...
  2. The layout of the single `CustomListTile` confuses me some times: there are two rows, nested in each other. Maybe this can be simplified in order to be able to work with it, as discussed above;
  3. You've done a great work placing the red dot icons on the "important" menu items (or "unread"), but that's heavy overhead that could be avoided. I personally dislike working with `Stack` unless _I have to_, because they introduce some heavy complexity, often unneeded. Have you tried using [this package](https://pub.dev/packages/badges)? I'll use it for you to show how easy it is to add what you need there;
  5. Some expanded menu items are hidden by the notification count. To simplify things, I'll move the notification count up into the badge, so it's simpler and it solves this problem directly.

Let's start working on this with the low handing fruits first.

### Badges (3.)
First, let's install `badges v2.0.3` via the `flutter pub add badges` command. Then, let's use it inside our `CustomListTile`.

Using a Badge is as easy as the following:
```dart
Badge(
  // only show the badge if there's a notification
  showBadge: infoCount > 0,
  // the content should just be the plain counter
  badgeContent: Text('$infoCount'),
  // I modified the color to match what you've chosen
  badgeColor: Colors.purple.shade200,
  // in your use case, the child is just a simple icon (which is common)
  child: Icon(page.icon, color: Colors.white),
),
```

This allows us (the devs) to simplify our drawer tile a lot: we can now just rely on this new badge without the complicated layout we built before.

Also, I slightly corrected the `SizedBox`'s width.

#### `_isCollapsed` behavior
While testing what I did above, I noticed some more weird behavior from our app.

The `isCollapsed` parameter is behaving at the exact opposite as I'd expect: when it's `true` I'd expect the drawer to be minimized; otherwise, the drawer should expand. Instead, it behaves as the exact opposite: this is probably unintended / bug. Don't worry, _naming things is hard_ and probably one of the most hard things in Computer Science in general. This needs a quick refactoring that will improve readability.

I'll simply rename this parameter `_isExpanded`, so its intentions are clearer / more understandable.

### Simplifying `CustomListTile` Layout (2.)
While trying to address the "jump" problem, I think there's room to improve the layout of this custom tile. This is important as it will simplify the implementation of the actual solution later.

I see there's a little problem with how the `doHaveMoreOptions` is layouted: I can see a `Spacer` property is being exploited to add proportional space between the `title` and the "more options" button.

This causes the title to be "cut away" from the layout when the text is too long.

We can work around this by refactoring the layout; the actual implementation you'll find in my commits is actuall very close to this pseudo code:

```dart
Row(
  mainAxisAlignment:
    // this is important to correctly layout the row
    isExpanded ? MainAxisAlignment.start : MainAxisAlignment.center,
    children: [
      Badge(... our badge ...),
      // if we want to see more, we spread all the following widgets into the row
      if (isExpanded) ...[
        const SizedBox(width: 15),
        Text(... our title ...),
        Expanded(
          // forces this symbol to take the remaining of the row
          child: Align(
            // after taking all of the space available, this occupies the rightmost space available
            alignment: Alignment.centerRight,
            child: doHaveMoreOptions == null
                ? const SizedBox.shrink()  // it will disappear when the drawer is collapsed
                : IconButton(... right arrow button ...),
          ),
        ),
      ]
    ],
)
```

### Fixing the animation problems (1.)
Now to the real deal: addressing the jump effects. The simplifications above were actually very useful, as it allowed me to see what was going on when the jumps occurred.

The animation problems actually _worsened_ after our refactoring (now the tiles overflow while animating), but:
  1. This pretty common when trying to address these kinds of issues;
  2. This is good, as we can see what the problem is.

When the parent `AnimatedContainer` (the drawer) animates, Flutter has _no way_ of knowing how to correctly layout its children.

This implies that when the drawer is expanding, at the start of the animation (and immediately after) the text will overflow and Flutter will complain about it. Also, this is not so great UX.

Furthermore, when shrinking, the `Row` will change its layouting rules (from `start` to `center`) and another ugly jump is shown.

#### How to actually solve this?
I just did a heavy refactoring to solve this, but in a nusthell...

At the end of the day, we need to do two things:
  1. Animate the SIZE of the drawer
  2. Animate the fact that the latter part of the drawer tile _disappear_ upon animating

To do so, again, _there are widgets for that_. The former is addressed with `AnimatedSize`. The latter with `AnimatedSwitcher`.
Finally, I've done two things to improve the solution:
  1. I've made your Menu an actual part of the layout. The drawer isn't really your use case.
  2. I've removed the AppBar as it uselessly clutters the view (as a demo), but you could re-add it anytime you want.
  3. I've removed the "blackened" effect onto the actual page to more clearly see the page switch


#### Scaling up
As a bonus....

"e se voglio mettere un sottomenu là dentro?"
use: https://www.youtube.com/watch?v=2aJZzRMziJc
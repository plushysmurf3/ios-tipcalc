# Pre-work - TipCalc

TipCalc is a tip calculator application for iOS.

Submitted by: Savio Tsui

Time spent: 3-5 hours spent in total.

## User Stories

The following **required** functionality is complete:

* [yes] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [yes] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [yes] UI animations
* [yes] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [yes] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [yes] Auto-calculating the bill when adjusting the percentages on the settings page such that it calculates the tip and bill based on previous selection.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='https://github.com/plushysmurf3/ios-tipcalc/blob/master/demo/tipcalc_licecap.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I have never developed with iOS but have experience developing web applications.  Getting accustomed to the correct Swift syntax was sometimes tricky.  It appears that Swift
syntax has been changing quite rapidly and some of the articles I have found online as reference on places like StackOverflow are sometimes out of date.

Using Doubles gave me a higher precision than I anticipated initially.  I needed to round my values to the correct decimal places.

I was having difficulty with figuring out how to Dependency Injection with storyboard created UIViewControllers

## License

    Copyright [2016] [Savio Tsui]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
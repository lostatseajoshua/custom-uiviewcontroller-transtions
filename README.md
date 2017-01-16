# custom-uiviewcontroller-transtions

Implementation of custom UIViewController transitions. The goal of this project is to give a base implementation of how to create simple custom transition between UIViewControllers. 
###### This project was created for a presentation I gave at the [Boulder iOS September Meetup](https://www.meetup.com/Boulder-iOS/events/233561765/)

### Prerequisites

Xcode 8

Swift 3

### Running the animations
There are four custom view controller transitions implemented in the project.

##### UITabBarController
When you launch the application the initial view is in a `UITabBarController` with two tabs. Switching between tabs displays an animation.

##### UINavigationController
The first tab of the tab bar controller holds a view controller that is in a navigation bar. This view controller has two `UIButton`s in the view. One is titled `push` and the other with the title `present`.

##### Modal Presentation
Tapping on `present` will display a custom modal presentation transition.

##### Interactive Animation
Performing a pinch gesture on the first tab view controller will be activate the interactive transition.

#### UI Test
Run the UI test target and view a demo of the transitions on the simulator! In Xcode press `CMD+U`

## Known Issues
The interactive transition in the project lags in the simulator.
Workaround: Run on an actual iOS device which displays no lag.

## Authors
* **Joshua Alvarado** - *Initial work*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Notes
If you find any problems please open a new issue. Obj-c and Swift 3 implementation coming soon.

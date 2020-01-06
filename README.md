# AnimatedButtonSPM

This button subclass has touch events mapped, its react when user touch,  scaling down and than getting back to the original size.
It has also a spin animation with a activityview that is optional.

<img height="30%" width="30%" src="https://github.com/Alvathor/AnimatedButtonSPM/blob/master/ezgif.com-video-to-gif.gif" alt="AnimatedButton.gif"></img>



# AnimatedButtonSPM

This button subclass has touch events mapped, its react when user touch,  scaling down and than getting back to the original size. It has also a spin animation with a activityview that is optional.

### Prerequisites

What things you need to install the software and how to install them

```
Xcode
```

### Installing

```
Add https://github.com/Alvathor/AnimatedButtonSPM to your project
Import AnimatedButtonSPM
```

```
Create the button component
   let animatedButton = configure(AnimatedButton()) {
        $0.backgroundColor = .red
        $0.clipsToBounds = true
        $0.setTitle("SIGN UP", for: .normal)
    }
```

```
Add to the view. If you want to animate your button you should not put constraints at the edges, but center in superView.
   view.add(animatedButton) {
            $0.centerInSuperview(size: .init(width: buttonSize.width, height: buttonSize.height))
            $0.layer.cornerRadius = buttonSize.height / 2
            ...            
```

```
Call bindableCompletedTouch that is a subscription for touchInside
view.add(animatedButton) {
            $0.centerInSuperview(size: .init(width: buttonSize.width, height: buttonSize.height))
            $0.layer.cornerRadius = buttonSize.height / 2
            $0.bindableCompletedTouch.bind { _ in
                self.handleTouchAnimatedButton()
            }
```

```
Call animateButtonActivity setting to true or false when you need.
    @objc private func handleTouchAnimatedButton() {
        if animatedButton.tag == 0 {
            animatedButton.tag = 1
            animatedButton.animateButtonActivity(hasActivity: true)
        } else {
            animatedButton.tag = 0
            animatedButton.animateButtonActivity(hasActivity: false)
        }
    }
```

End with an example of getting some data out of the system or using it for a little demo


## Authors

* **Juliano Alvarenga** - *Initial work* - [PurpleBooth](https://github.com/Alvathor)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

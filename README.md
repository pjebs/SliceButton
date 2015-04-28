Purpose
--------------

SliceButton is a button that is shaped like a pie/pizza and sliced up
according to the number in the *buttons* property. It supports user-input and responds
to any touches by firing the delegate **sliceButtonTapped:buttonIndex:** method
with information about which 'slice' was touched.
The button itself only represents half of a pie/pizza (either left or right half).
You can use two buttons to form a full pie/pizza.

![Screen shot of SliceButton](https://raw.github.com/pjebs/SliceButton/master/screenshot.png)

Supported OS & SDK Versions
-----------------------------

* Supported build target - iOS 7.0+ 
* Earliest supported deployment target - iOS 4.0 


Installation
--------------

### CocoaPods

pod 'SliceButton', '~> 1.0'

### Standard

To install SliceButton into your app, drag the **SliceButton.h** and **SliceButton.m** files into your project.

Add:
```
#import "SliceButton.h"
```
to the top of any class (*.h or *.m) that will use SliceButton.

Optionally make sure the class conforms to the SliceButtonDelegate protocol:

Modify .h file:

	@interface ViewController : UIViewController <SliceButtonDelegate>

Implement Protocol methods such as:

``` 
-(void)sliceButtonTapped: (SliceButton *)sliceButton buttonIndex:(int) index;
{
    sliceButton.selected = index;
}
```

Properties
--------------

An image that looks like a pie/pizza shaped button should be provided. The image
should have the 'slices' clearly marked. See the image "LeftSlice.png" that
is provided in the example project for guidance.

    @property (nonatomic, strong) UIImage *button_image;

An optional image can be provided. It should be small (i.e. 12x12) and circular.
When a user touches a 'slice', the *selected* property can be set to the 'slice'
that was touched. The *selected* property dictates where this image is placed. It is
placed in the middle of the 'selected' slice.

    @property (nonatomic, strong) UIImage *dot_image;

This forms a small circle that is centred around the centre of the 'pie'. This area
does not respond to user-input (i.e. touches). Although strictly optional (i.e. you
can set the value to 0), it is recommended that you set the *small_radius* value
based on the size of the 'average' users fingers.

    @property int small_radius;

This forms the big circle that represents the outer edge of the 'pie'. Any touches
on the outside of the outer edge is ignored. The value should be set based on the
*button_image* provided. See the image "LeftSlice.png" that is provided in
the example project for guidance.

    @property (nonatomic) int big_radius;

If this property is set to YES, then the button only shows the RIGHT side of the
pie/pizza. Whether the button should respond or not to a particular touch (based on
the position of the touch) is influenced by this property. If the property is set to
NO, then the button only shows the LEFT side.

    @property BOOL orientation_left;


This sets how many 'slices' the button should have. It should correspond to how many
slices are drawn on the *button_image* provided. See the image "LeftSlice.png"
that is provided in the example project for guidance.

    @property int buttons;

This sets which 'slice' should be noted as being touched. A value of -1 means none
is selected. Any other value between 0 and (*buttons* - 1) property will draw
the *dot_image* provided near the outer edge of the 'pie'. The *selected* value
represents the slice counting from the top down. The top-most slice is represented
by selected=0...

    @property (nonatomic) int selected; //-1 = none

This represents how far inwards the *dot_image* is drawn relative to the outer edge. A value of 0 will center the center of the *dot_image* at the outer-edge (as determined by
*big_radius*). The larger the *dot_image_radius_offset* property is, the more inward *dot_image* gets drawn.

    @property (nonatomic) float dot_image_radius_offset;

Optional delegate that will implement **sliceButtonTapped:buttonIndex:** so that
when the user touches a 'slice', the **sliceButtonTapped:buttonIndex:** method will
get fired. The method's buttonIndex value will indicate which 'slice' was touched.
It does not automatically 'adjust' the 'selected' property. You must do so yourself.

    @property (nonatomic, weak) IBOutlet id <SliceButtonDelegate> delegate;

This is for debugging purposes ONLY. When it is set to YES, the background image
provided (*button_image*) will be shown with a CLEAR marking of where the button
believes the individual slices are. The button uses the CLEAR marking to determine
the boundaries of each slice which is itself used to determine which slice was
touched. Use this property to ENSURE that the background image provided clearly
aligns with the button's CLEAR marking. They MUST align precisely.

    @property (nonatomic) BOOL debug;

Methods
--------------

Initializer: The initializer automatically places the button inside the superview
container. You still must set the frame of the button accordingly using the inherited
*frame* property. See the Example Project for an illustration. All the arguments are
self-explanatory and correspond to the properties noted above. The **ButtonNumber**
argument corresponds to the *button* property.


```
- (id)initWithSettingsSuchAsLeftOrientation:(BOOL)orientation_left ButtonNumber:(int)number SmallRadius:(int)small_radius BigRadius:(int)big_radius Image:(UIImage *)image DotImage:(UIImage *)dot_image DotImageRadiusOffset:(float)offset SuperView:(UIView*)superview;
```


Delegate methods
---------------

Optional delegate can implement **sliceButtonTapped:buttonIndex:** so that
when the user touches a 'slice', the **sliceButtonTapped:buttonIndex:** will get
fired. The method's *buttonIndex* value will indicate which 'slice' was touched.
It does not automatically adjust the *selected* property. You must do so yourself.
See the Example Project for an illustration.

    -(void)sliceButtonTapped: (SliceButton *)sliceButton buttonIndex:(int) index;


Example Projects
---------------

The Example Project will showcase how to use the button and also respond to use input.


Any Questions
---------------

If you found this library useful, please **Star** it on github. Feel free to fork or provide pull requests. Any bug reports will be warmly received.

PJ Engineering and Business Solutions Pty. Ltd
http://www.pjebs.com.au

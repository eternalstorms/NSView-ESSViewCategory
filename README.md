# NSView+ESSViewCategory
a category on NSView that simplifies zoom-transitioning between two NSViews, inspired by OS X 10.10.3's Photos.app ([Blog Post](http://wp.me/p1hxut-6f))

![NSView+ESSViewCategory Zoom Transition Animation Example](http://eternalstorms.at/opensource/NSViewESSViewCategory/zoomtransition.gif "NSView+ESSViewCategory Zoom Transition Animation Example")

## First, the License Agreement

1) You can use the code in your own products.  
2) You can modify the code as you wish, and use the modified code in your products.  
3) You can redistribute the original, unmodified code, but you have to include the full license text below.  
4) You can redistribute the modified code as you wish (without the full license text below).  
5) In all cases, you must include a credit mentioning Matthias Gansrigler as the original author of the source.  
6) I’m not liable for anything you do with the code, no matter what. So be sensible.  
7) You can’t use my name or other marks to promote your products based on the code.  
8) If you agree to all of that, go ahead and download the source. Otherwise, don’t.

# How To Use NSView+ESSViewCategory

You’ll have to first add the NSView+ESSViewCategory.h and *.m files to your project.
Please note that the category imports <Quartz/Quartz.h> for Core Animation’s CAMediaTiming class, so you might have to add that framework to your project, too.

fromView
It has to be inside of a view hierarchy. Fades out during the transition.

toView
Can be in a different xib file (for example, a NSViewController) or in the same as fromView. It’s important that it is not already on screen somewhere. Fades in during the transition.

Once you have set up your views, either call the class method and pass fromView and toView as well as the other parameters or call the instance method on fromView.

The class method:  
`+ (void)transitionFromView:(NSView *)fromView toView:(NSView *)toView withZoomingTransition:(ESSViewZoomTransition)transition duration:(CGFloat)duration completionHandler:(void (^)(void))completionHandler;`

The instance method:  
`- (void)transitionToView:(NSView *)toView withZoomingTransition:(ESSViewZoomTransition)transition duration:(CGFloat)duration completionHandler:(void (^)(void))completionHandler;`

Please refer to the sample project and/or the ([Blog Post](http://wp.me/p1hxut-6f)) for more information.

## Requirements
This code has been tested on OS X Yosemite 10.10.3. It might work with earlier versions of the operating system.  
Developed with Xcode 6.3.1

## Support
The framework and code is provided as-is, but if you need help or have suggestions, you can contact me anytime at [opensource@eternalstorms.at](mailto:opensource@eternalstorms.at) or [@eternalstorms on twitter](http://twitter.com/eternalstorms)

For other Open Source projects of mine, please visit http://www.eternalstorms.at/opensource

# I'd like to hear from you
If you use NSView+ESSViewCategory in one of your projects, please be sure to [let me know](mailto:opensource@eternalstorms.at)! I'd love to hear about your apps and mention them here on this project page :) !!
//
//  NSView+ESSViewCategory.h
//  ESSTransitionByZooming
//
//  Created by Matthias Gansrigler on 28.04.2015.
//  Copyright (c) 2015 Eternal Storms Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*!
 @typedef			ESSViewZoomTransition
 @abstract			The zoom animation to be used in +transitionFromView:toView:withZoomingTransition:duration:completionHandler:
 @discussion		Might be used to create a zoom in, zoom out effect (like, zoom into a detailed setup view, zoom out of it to the more general overview-view)
 */
typedef enum : NSUInteger {
	ESSViewZoomTransitionZoomIn,
	ESSViewZoomTransitionZoomOut
} ESSViewZoomTransition;

@interface NSView (ESSViewCategory)

/*!
 @method			transitionFromView:toView:withZoomingTransition:duration:completionHandler:
 @abstract			A class method to transition from one view to another by zooming into or out of it.
 @param				fromView
					The NSView to be transitioned from, already in a view hierarchy. Must not be nil.
 @param				toView
					The NSView to be transitioned to, assumed not to be inside any view hierarchy. Must not be nil.
 @param				transition
					The transition to be used.
 @param				duration
					The duration of the transition animation.
 @param				completionHandler
					An optional completionHandler that is called after the transition animation ends.
 @discussion		fromView and toView should be of the same frame size.
 */
+ (void)transitionFromView:(NSView *)fromView
					toView:(NSView *)toView
	 withZoomingTransition:(ESSViewZoomTransition)transition
				  duration:(CGFloat)duration
		 completionHandler:(void (^)(void))completionHandler;

/*!
 @method			transitionToView:withZoomingTransition:duration:completionHandler:
 @abstract			An instance method to transition from one view to another by zooming into or out of it.
 @param				toView
					The NSView to be transitioned to, assumed not to be inside any view hierarchy. Must not be nil.
 @param				transition
					The transition to be used.
 @param				duration
					The duration of the transition animation.
 @param				completionHandler
					An optional completionHandler that is called after the transition animation ends.
 @discussion		fromView and toView should be of the same frame size. This method calls the class method with the target of this method as fromView.
 */
- (void)transitionToView:(NSView *)toView
   withZoomingTransition:(ESSViewZoomTransition)transition
				duration:(CGFloat)duration
	   completionHandler:(void (^)(void))completionHandler;

@end

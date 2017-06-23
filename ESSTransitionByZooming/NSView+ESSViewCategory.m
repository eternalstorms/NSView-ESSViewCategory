//
//  NSView+ESSViewCategory.m
//  ESSTransitionByZooming
//
//  Created by Matthias Gansrigler on 28.04.2015.
//  Copyright (c) 2015 Eternal Storms Software. All rights reserved.
//

#import "NSView+ESSViewCategory.h"
#import <Quartz/Quartz.h>

@implementation NSView (ESSViewCategory)

+ (void)transitionFromView:(NSView *)fromView
					toView:(NSView *)toView
	 withZoomingTransition:(ESSViewZoomTransition)transition
				  duration:(CGFloat)duration
		 completionHandler:(void (^)(void))completionHandler
{
	if (fromView == nil || toView == nil)
	{
		if (completionHandler)
			completionHandler();
		return;
	}
	
	BOOL wantsLayer = fromView.superview.wantsLayer;
	fromView.superview.wantsLayer = YES;
	toView.frame = fromView.frame;
	
	//create an image of the view we're transitioning to
	NSBitmapImageRep *rep = [toView bitmapImageRepForCachingDisplayInRect:toView.bounds];
	[toView cacheDisplayInRect:toView.bounds toBitmapImageRep:rep];
	NSImage *toImage = [[NSImage alloc] initWithSize:rep.size];
	[toImage addRepresentation:rep];
	
	NSRect initialToRect = NSZeroRect;
	CGFloat widthDiff = (fromView.superview.frame.size.width/20.0);
	CGFloat heightDiff = (fromView.superview.frame.size.height/20.0);
	if (transition == ESSViewZoomTransitionZoomOut)
		initialToRect = NSMakeRect(-widthDiff,
								   -heightDiff,
								   fromView.superview.frame.size.width+(widthDiff*2),
								   fromView.superview.frame.size.height+(heightDiff*2));
	else if (transition == ESSViewZoomTransitionZoomIn)
		initialToRect = NSMakeRect(widthDiff,
								   heightDiff,
								   fromView.superview.frame.size.width-(widthDiff*2),
								   fromView.superview.frame.size.height-(heightDiff*2));
	
	NSView *toImageView = [[NSView alloc] initWithFrame:initialToRect];
	toImageView.wantsLayer = YES;
	toImageView.layer.contents = toImage;
	toImageView.alphaValue = 0.0;
	
	toView.alphaValue = 0.0;
	[fromView.superview addSubview:toView];
	
	//create an image of the view we're transitioning from
	rep = [fromView bitmapImageRepForCachingDisplayInRect:fromView.bounds];
	[fromView cacheDisplayInRect:fromView.bounds toBitmapImageRep:rep];
	NSImage *fromImage = [[NSImage alloc] initWithSize:rep.size];
	[fromImage addRepresentation:rep];
	
	NSView *fromImageView = [[NSView alloc] initWithFrame:fromView.frame];
	fromImageView.wantsLayer = YES;
	fromImageView.layer.contents = fromImage;
	
	[fromView.superview addSubview:fromImageView positioned:NSWindowAbove relativeTo:nil];
	[fromView.superview addSubview:toImageView positioned:NSWindowAbove relativeTo:nil];
	[fromView removeFromSuperview];
	
	[NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
		context.duration = duration;
		context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
		fromImageView.animator.alphaValue = 0.0;
		NSRect zoomRect = NSZeroRect;
		if (transition == ESSViewZoomTransitionZoomOut)
			zoomRect = NSMakeRect(widthDiff,
								  heightDiff,
								  fromImageView.frame.size.width-(widthDiff*2),
								  fromImageView.frame.size.height-(heightDiff*2));
		else if (transition == ESSViewZoomTransitionZoomIn)
			zoomRect = NSMakeRect(-widthDiff,
								  -heightDiff,
								  fromImageView.frame.size.width+(widthDiff*2),
								  fromImageView.frame.size.height+(heightDiff*2));
		fromImageView.animator.frame = zoomRect;
		
		toImageView.animator.alphaValue = 1.0;
		toImageView.animator.frame = fromImageView.superview.frame;
	}
						completionHandler:^{
							toView.alphaValue = 1.0;
							[fromImageView.superview addSubview:toView positioned:NSWindowAbove relativeTo:nil];
							[fromImageView removeFromSuperview];
							[toImageView removeFromSuperview];
							[fromView removeFromSuperview];
							fromView.superview.wantsLayer = wantsLayer;
							
							if (completionHandler)
								completionHandler();
						}];
}

- (void)transitionToView:(NSView *)toView
   withZoomingTransition:(ESSViewZoomTransition)transition
				duration:(CGFloat)duration
	   completionHandler:(void (^)(void))completionHandler
{
	[[self class] transitionFromView:self
							  toView:toView
			   withZoomingTransition:transition
							duration:duration
				   completionHandler:completionHandler];
}

@end




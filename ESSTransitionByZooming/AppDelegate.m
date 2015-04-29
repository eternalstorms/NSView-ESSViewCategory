//
//  AppDelegate.m
//  ESSTransitionByZooming
//
//  Created by Matthias Gansrigler on 28.04.2015.
//  Copyright (c) 2015 Eternal Storms Software. All rights reserved.
//

#import "AppDelegate.h"
#import "NSView+ESSViewCategory.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (strong) IBOutlet NSView *firstView;
@property (strong) IBOutlet NSView *secondView;

- (IBAction)transitionIn:(id)sender;
- (IBAction)transitionOut:(id)sender;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
	// Insert code here to tear down your application
}

- (void)transitionOut:(id)sender
{
	[NSView transitionFromView:self.firstView
					toView:self.secondView
		 withZoomingTransition:ESSViewZoomTransitionZoomOut
					  duration:0.15
			 completionHandler:nil];
}

- (void)transitionIn:(id)sender
{
	[NSView transitionFromView:self.secondView
						toView:self.firstView
		 withZoomingTransition:ESSViewZoomTransitionZoomIn
					  duration:0.15
			 completionHandler:nil];
}

@end

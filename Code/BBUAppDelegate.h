//
//  BBUAppDelegate.h
//  Put.io for Mac
//
//  Created by Boris Bügling on 29.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class BBUFileBrowserViewController;
@class BBUVideoPlayerController;

@interface BBUAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet BBUFileBrowserViewController* fileBrowser;
@property (assign) IBOutlet BBUVideoPlayerController* videoPlayer;
@property (assign) IBOutlet NSWindow *window;

@end

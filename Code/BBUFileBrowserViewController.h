//
//  BBUFileBrowserViewController.h
//  Put.io for Mac
//
//  Created by Boris Bügling on 29.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface BBUFileBrowserViewController : NSViewController

@property IBOutlet NSTableView* view;

-(void)startBrowsing;

@end

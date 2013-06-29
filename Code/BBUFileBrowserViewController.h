//
//  BBUFileBrowserViewController.h
//  Put.io for Mac
//
//  Created by Boris Bügling on 29.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PKFile;

typedef void(^BBUFileAction)(PKFile* file);

@interface BBUFileBrowserViewController : NSViewController

@property (copy) BBUFileAction fileAction;
@property IBOutlet NSTableView* tableView;

-(void)startBrowsing;

@end

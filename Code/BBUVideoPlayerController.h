//
//  BBUVideoPlayerController.h
//  Put.io for Mac
//
//  Created by Boris Bügling on 30.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PKFile;

@interface BBUVideoPlayerController : NSViewController

-(void)playVideoFromPutIOFile:(PKFile*)file;

@end

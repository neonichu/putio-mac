//
//  NSViewController+Activity.m
//  Put.io for Mac
//
//  Created by Boris Bügling on 30.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import "NSViewController+Activity.h"

static const CGFloat kSpinnerWidth = 30.0;
static const CGFloat kSpinnerHeight = kSpinnerWidth;

@implementation NSViewController (Activity)

-(NSView*)bbu_showActivity {
    CGFloat x = (self.view.frame.size.width - kSpinnerWidth) / 2.0;
    CGFloat y = (self.view.frame.size.height - kSpinnerHeight) / 2.0;
    
    NSProgressIndicator* indicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect(x, y, kSpinnerWidth, kSpinnerHeight)];
    [indicator setStyle:NSProgressIndicatorSpinningStyle];
    [self.view addSubview:indicator];
    [indicator startAnimation:self];
    
    return indicator;
}

@end

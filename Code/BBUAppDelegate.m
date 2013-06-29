//
//  BBUAppDelegate.m
//  Put.io for Mac
//
//  Created by Boris Bügling on 29.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <PutioKit/PutIONetworkConstants.h>

#import "BBUAppDelegate.h"
#import "BBUFileBrowserViewController.h"
#import "BBUVideoPlayerController.h"
#import "PutIO_AuthConstants.h"
#import "PutIOOAuthHelper.h"

typedef void(^BBUAuthenticationSucessfulHandler)();

@interface BBUAppDelegate ()

@property PutIOOAuthHelper* authHelper;

@end

#pragma mark -

@implementation BBUAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.fileBrowser.fileAction = ^(PKFile* file) {
        [self.videoPlayer playVideoFromPutIOFile:file];
    };
    
    [self authenticateIfNeededWithCompletionHandler:^{
        [self.fileBrowser startBrowsing];
    }];
}

-(void)authenticateIfNeededWithCompletionHandler:(BBUAuthenticationSucessfulHandler)handler {
#if 0
    self.authHelper = [PutIOOAuthHelper new];
    
    // Put your own client ID and secret here
    self.authHelper.clientID = PUTIO_CLIENT_ID;
    self.authHelper.clientSecret = PUTIO_CLIENT_SECRET;
    // ---
    
    self.authHelper.webView.frame = [self.window.contentView bounds];
    [self.authHelper loadAuthPage];
    
    [self.window.contentView addSubview:self.authHelper.webView];
    
    // TODO: Invoke the handler if authentication was successful
#else
    [[NSUserDefaults standardUserDefaults] setValue:PUTIO_OAUTH_TOKEN forKey:PKAppAuthTokenDefault];
    
    if (handler) {
        handler();
    }
#endif
}

@end

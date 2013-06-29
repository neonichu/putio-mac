//
//  PutIOOAuthHelper.h
//  Put.io for Mac
//
//  Created by Boris Bügling on 29.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class PutIOOAuthHelper;

@protocol PutIOOAuthHelperDelegate <NSObject>

- (void)authHelperDidLogin:(PutIOOAuthHelper *)helper;
- (void)authHelperLoginFailedWithDescription:(NSString *)errorDescription;
- (void)authHelperHasDeclaredItScrewed;

@end

#pragma mark -

@interface PutIOOAuthHelper : NSObject

@property (strong) WebView *webView;
@property (weak) NSObject <PutIOOAuthHelperDelegate> *delegate;

@property (strong) NSString *clientID;
@property (strong) NSString *clientSecret;

- (void)loginWithUsername:(NSString *)username andPassword:(NSString *)password;
- (void)loadAuthPage;

@end

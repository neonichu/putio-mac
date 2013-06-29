//
//  BBUFileBrowserViewController.m
//  Put.io for Mac
//
//  Created by Boris Bügling on 29.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <PutioKit/PutioKit.h>

#import "BBUFileBrowserViewController.h"
#import "PKFolder+BBUAdditions.h"

@implementation BBUFileBrowserViewController

-(void)awakeFromNib {
    self.view = self.tableView;
}

-(id)init {
    self = [super init];
    return self;
}

-(void)startBrowsing {
    PutIOClient* client = [PutIOClient sharedClient];
    [client getFolderItems:[PKFolder rootFolder] :^(NSArray *filesAndFolders) {
        NSLog(@"Files: %@", filesAndFolders);
    } failure:^(NSError *error) {
        [[NSAlert alertWithError:error] runModal];
    }];
}

@end

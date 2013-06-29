//
//  PKFolder+BBUAdditions.m
//  Put.io for Mac
//
//  Created by Boris Bügling on 29.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import "PKFolder+BBUAdditions.h"

@implementation PKFolder (BBUAdditions)

+(PKFolder*)rootFolder {
    PKFolder *rootFolder = [PKFolder new];
    rootFolder.id = @"0";
    rootFolder.name = @"";
    rootFolder.parentID = @"0";
    return rootFolder;
}

@end

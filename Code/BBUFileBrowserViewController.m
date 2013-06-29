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

@interface BBUFileBrowserViewController () <NSTableViewDataSource>

@property PKFolder* currentFolder;
@property NSArray* filesAndFolders;

@end

#pragma mark -

@implementation BBUFileBrowserViewController

-(void)awakeFromNib {
    self.tableView.dataSource = self;
    self.tableView.doubleAction = @selector(doubleClickedRow);
    self.tableView.target = self;
    self.view = self.tableView;
}

-(void)clear {
    self.currentFolder = nil;
    self.filesAndFolders = nil;
    [self.tableView reloadData];
}

-(void)doubleClickedRow {
    PKObject<PKFolderItem>* item = [self folderItemAtRow:[self.tableView clickedRow]];
    if ([item isKindOfClass:[PKFolder class]]) {
        [self loadItemsForFolder:(PKFolder*)item];
    } else {
        if (self.fileAction && [item isKindOfClass:[PKFile class]]) {
            self.fileAction((PKFile*)item);
        }
    }
}

-(PKObject<PKFolderItem>*)folderItemAtRow:(NSInteger)row {
    return self.filesAndFolders[row];
}

-(id)init {
    self = [super init];
    return self;
}

-(void)loadItemsForFolder:(PKFolder*)folder {
    [self clear];
    
    NSView* indicator = [self bbu_showActivity];
    
    PutIOClient* client = [PutIOClient sharedClient];
    [client getFolderItems:folder :^(NSArray *filesAndFolders) {
        [indicator removeFromSuperview];
        
        self.currentFolder = folder;
        self.filesAndFolders = filesAndFolders;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [indicator removeFromSuperview];
        
        [[NSAlert alertWithError:error] runModal];
    }];
}

-(void)startBrowsing {
    [self loadItemsForFolder:[PKFolder rootFolder]];
}

#pragma mark - NSTableView data source methods

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.filesAndFolders.count;
}

-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    PKObject<PKFolderItem>* item = [self folderItemAtRow:row];
    if ([item isKindOfClass:[PKFolder class]]) {
        return [@"[]  " stringByAppendingString:item.name];
    }
    return item.name;
}

@end

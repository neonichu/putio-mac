//
//  BBUVideoPlayerController.m
//  Put.io for Mac
//
//  Created by Boris Bügling on 30.06.13.
//  Copyright (c) 2013 Boris Bügling. All rights reserved.
//

#import <PutioKit/PutioKit.h>
#import <QTKit/QTKit.h>

#import "BBUVideoPlayerController.h"

// TODO: Use AVFoundation
#pragma mark - Mountain Lion bugfix for QTMovieView (http://stackoverflow.com/questions/10942006/has-anyone-seen-stdmovieuislidercell-slidertype-unrecognized-selector-sent-t)

// Make sure that we have the right headers.
#import <objc/runtime.h>

// The selectors should be recognized by class_addMethod().
@interface NSObject (SliderCellBugFix)

- (NSSliderType)sliderType;
- (NSInteger)numberOfTickMarks;

@end

// Add C implementations of missing methods that we’ll add
// to the StdMovieUISliderCell class later.
static NSSliderType SliderType(id self, SEL _cmd)
{
    return NSLinearSlider;
}

static NSInteger NumberOfTickMarks(id self, SEL _cmd)
{
    return 0;
}

// rot13, just to be extra safe.
static NSString *ResolveName(NSString *aName)
{
    const char *_string = [aName cStringUsingEncoding:NSASCIIStringEncoding];
    NSUInteger stringLength = [aName length];
    char newString[stringLength+1];
    
    NSUInteger x;
    for(x = 0; x < stringLength; x++)
    {
        unsigned int aCharacter = _string[x];
        
        if( 0x40 < aCharacter && aCharacter < 0x5B ) // A - Z
            newString[x] = (((aCharacter - 0x41) + 0x0D) % 0x1A) + 0x41;
        else if( 0x60 < aCharacter && aCharacter < 0x7B ) // a-z
            newString[x] = (((aCharacter - 0x61) + 0x0D) % 0x1A) + 0x61;
        else  // Not an alpha character
            newString[x] = aCharacter;
    }
    newString[x] = '\0';
    
    return [NSString stringWithCString:newString encoding:NSASCIIStringEncoding];
}

#pragma mark -

@implementation BBUVideoPlayerController

// Add both methods if they aren’t already there. This should makes this
// code safe, even if Apple decides to implement the methods later on.
+ (void)load
{
    Class MovieSliderCell = NSClassFromString(ResolveName(@"FgqZbivrHVFyvqrePryy"));
    
    if (!class_getInstanceMethod(MovieSliderCell, @selector(sliderType)))
    {
        const char *types = [[NSString stringWithFormat:@"%s%s%s",
                              @encode(NSSliderType), @encode(id), @encode(SEL)] UTF8String];
        class_addMethod(MovieSliderCell, @selector(sliderType),
                        (IMP)SliderType, types);
    }
    if (!class_getInstanceMethod(MovieSliderCell, @selector(numberOfTickMarks)))
    {
        const char *types = [[NSString stringWithFormat: @"%s%s%s",
                              @encode(NSInteger), @encode(id), @encode(SEL)] UTF8String];
        class_addMethod(MovieSliderCell, @selector(numberOfTickMarks),
                        (IMP)NumberOfTickMarks, types);
    }
}

#pragma mark -

-(void)playVideoFromPutIOFile:(PKFile *)file {
    PutIOClient* client = [PutIOClient sharedClient];
    [client getMP4InfoForFile:file :^(PKMP4Status *status) {
        // TODO: Proper status support
        if (status.mp4Status != PKMP4StatusCompleted) {
            [self showVideoStreamingError];
            return;
        }
        
        [self streamMovieAtURL:[self urlFromPutIOFile:file]];
    } failure:^(NSError *error) {
        [[NSAlert alertWithError:error] runModal];
    }];
}

-(void)showVideoStreamingError {
    [[NSAlert alertWithMessageText:NSLocalizedString(@"Video streaming not available.", nil)
                     defaultButton:NSLocalizedString(@"OK", nil)
                   alternateButton:nil
                       otherButton:nil
         informativeTextWithFormat:@""] runModal];
}

-(void)streamMovieAtURL:(NSURL*)url {
    NSError* error;
    QTMovie* movie = [QTMovie movieWithURL:url error:&error];
    if (!movie) {
        [[NSAlert alertWithError:error] runModal];
        return;
    }
    
    NSWindow* mainWindow = [NSApp mainWindow];
    QTMovieView* movieView = [[QTMovieView alloc] initWithFrame:[mainWindow.contentView bounds]];
    [mainWindow.contentView addSubview:movieView];
    
    movieView.movie = movie;
    [movieView play:nil];
}

-(NSURL*)urlFromPutIOFile:(PKFile*)file {
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://put.io/v2/files/%@/stream", file.id]];
}

@end

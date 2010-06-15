//
//  fetchController.m
//  iGallery
//
//  Created by EragonJ on 2010/6/15.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import "fetchController.h"

@implementation fetchController
@synthesize myURL;
@synthesize myImage;
-(void) work
{
	// Store the specific image at myImage
	myImage = [[NSImage alloc]initWithContentsOfURL:myURL];
}
@end

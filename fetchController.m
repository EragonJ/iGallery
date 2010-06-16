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
-(void) work:(id)img
{
	// Store the specific image at myImage
	myImage = [[NSImage alloc] initWithContentsOfURL:myURL];
	
	// Call the submitController to assign fetch.myImage to self.img
	[img setImage:[self myImage]];
}
@end

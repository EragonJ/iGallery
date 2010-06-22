//
//  fetchController.m
//  iGallery
//
//  Created by EragonJ on 2010/6/15.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import "fetchController.h"
#import "submitController.h"
@implementation fetchController
@synthesize myURL;
@synthesize myImage;
@synthesize myImageList;
@synthesize _ajaxImg;
@synthesize _errorImg;
-(id) init
{
	if(self = [super init])
	{
		imageListCount = 1;
		currentIndex   = 0;
		myImageList    = [[NSMutableArray alloc] init];
		_ajaxImg       = [[NSImage alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ajax-loader" ofType:@"gif"]];
		_errorImg      = [[NSImage alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"error" ofType:@"png"]]; 
	}
	return self;
}
-(void) work:(id)array
{
	
	NSImageView* mainImageView  = [array objectAtIndex:0];
	NSImageView* ajaxLoaderView = [array objectAtIndex:1];
	
	// To make mainImageView nil , to perform a better effect to users
	if(mainImageView!=nil)
	{
		[mainImageView setImage:nil];
	}
	
	// Use ajaxToggle to show the loading indicator
	[self performSelectorOnMainThread:@selector(ajaxToggle:) withObject:ajaxLoaderView waitUntilDone:NO];

	// Store the specific image at myImage
	myImage = [[NSImage alloc] initWithContentsOfURL:myURL];
	
	if(nil!=myImage)
	{
		// Call the submitController to assign fetch.myImage to self.img
		[mainImageView setImage:[self myImage]];
		
		// Add it to the imageList
		[myImageList addObject:myImage];
		
		// To get the count of myImageList
		imageListCount = [myImageList count];
		
		// To get the currentIndex
		currentIndex = imageListCount-1;
	}
	else
	{
		// It means we can't get the picuture from the given url
		[mainImageView setImage:_errorImg];
	}
	
	// ajaxToggle to show the loading 
	[self performSelectorOnMainThread:@selector(ajaxToggle:) withObject:ajaxLoaderView waitUntilDone:NO];	
}
-(void) changeImage:(id)array
{
	NSImageView* mainImageView = [array objectAtIndex:0];
	NSNumber*            which = [array objectAtIndex:1];
	
	if([which intValue]==1)
	{
		currentIndex = (currentIndex+1)%(imageListCount);
		if(imageListCount!=1)
		{
			[mainImageView setImage:[myImageList objectAtIndex:currentIndex]];
		}
	}
	else
	{
		currentIndex = ((currentIndex-1) >= 0) ? (currentIndex-1) : imageListCount-1;
		if(imageListCount!=1)
		{
			[mainImageView setImage:[myImageList objectAtIndex:currentIndex]];
		}
	}
}
-(void) ajaxToggle:(NSImageView*)ajaxloader
{
	if(nil==[ajaxloader image])
	{
		[ajaxloader setImage:_ajaxImg];
		NSLog(@"No pic , assigned just now");
	}
	else
	{
		[ajaxloader	setImage:nil];
		NSLog(@"With pic , assigned to nill just now");
	}	
}
-(int) returnCurrentIndex
{
	return currentIndex;
}
@end

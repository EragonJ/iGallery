//
//  submitController.m
//  iGallery
//
//  Created by EragonJ on 2010/6/15.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import "submitController.h"
#import "fetchController.h"

@implementation submitController
-(id) init
{
	[super init];
	if(self)
	{
		// Initialize fetchController and _ajaxImg , need to fix the path later
		fetch = [[fetchController alloc] init];
		_ajaxImg = [[NSImage alloc] initWithContentsOfFile:@"/Users/EragonJ/Mac-Dev/iGallery/ajax-loader.gif"];
	}
	return self;
}
-(IBAction) submit:(id)sender
{
	// It is hidden in the middle of the screen
	[self ajaxToggle];
		
	// Because url is NSTextField* which is inherited from NSObject ,
	// there is a object method called stringValue which returns (NSString*)
	[fetch setMyURL:[[NSURL alloc] initWithString:[url stringValue]]];
	
	// Run the fetchController and to get the myImage
	[NSThread detachNewThreadSelector:@selector(work:) toTarget:fetch withObject:img];
}

-(void)ajaxToggle
{
	// I have to use Thread to fix the problems
	if(nil==[ajaxImg image])
	{
		[ajaxImg setImage:_ajaxImg];
		NSLog(@"No pic , assigned just now");
	}
	else
	{
		[ajaxImg setImage:nil];
		NSLog(@"With pic , assigned to nill just now");
	}
}

@synthesize _ajaxImg;
@end

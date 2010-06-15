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
-(IBAction) submit:(id)sender
{
	
	//self._ajaxImg = [[NSImage alloc] initWithContentsOfFile:@"/Users/EragonJ/Mac-Dev/iGallery/ajax-loader.gif"];

	// It is hidden in the middle of the screen
	//[self ajaxToggle];
	
	// Initialize the fetchController
	// BTW, we enable garbage collection here in order not to dealloc it by ourselves
	fetchController* fetch = [[fetchController alloc] init];
	
	// Because url is NSTextField* which is inherited from NSObject ,
	// there is a object method called stringValue which returns (NSString*)
	fetch.myURL = [[NSURL alloc] initWithString:[url stringValue]];
	
	// Run the fetchController and to get the myImage
	[fetch work];
	
	//[self ajaxToggle];
	
	// Call the submitController to assign fetch.myImage to self.img
	[img setImage:[fetch myImage]];
}

-(void)ajaxToggle
{
	// I have to use Thread to fix the problems
	if(nil==[ajaxImg image])
	{
		[ajaxImg setImage:_ajaxImg];
	}
	else
	{
		[ajaxImg setImage:nil];
	}
}

@synthesize _ajaxImg;
@end

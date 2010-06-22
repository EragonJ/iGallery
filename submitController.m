//
//  submitController.m
//  iGallery
//
//  Created by EragonJ on 2010/6/15.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import "submitController.h"
#import "fetchController.h"
#import "NSString-Utilities.h"
@implementation submitController
@synthesize savePath;
-(void) awakeFromNib
{
	// Initialize fetchController and _ajaxImg , need to fix the path later
	fetch = [[fetchController alloc] init];
	savePath = [NSHomeDirectory() stringByAppendingString:@"/Desktop/"];
	displayedImage = [[NSImage alloc] init];
}
-(IBAction) submit:(id)sender
{
	// To judge whether the stringValue of url is URL or not
	// Here I use categories to help us to do this kind of judgement 
	if([[url stringValue] isURL])
	{
		// Because url is NSTextField* which is inherited from NSObject ,
		// there is a object method called stringValue which returns (NSString*)
		[fetch setMyURL:[[NSURL alloc] initWithString:[url stringValue]]];
	
		// Run the fetchController and to get the myImage
		[NSThread detachNewThreadSelector:@selector(work:) 
								 toTarget:fetch 
							   withObject:[NSArray arrayWithObjects:img,ajaxloader,nil]];
	}
}
-(IBAction) save:(id)sender
{
	NSSavePanel* panel = [NSSavePanel savePanel];
	[panel setDirectory:[savePath stringByExpandingTildeInPath]];
	[panel setPrompt:@"Save"];
	[panel beginSheetForDirectory:savePath
							 file:nil 
				   modalForWindow:nil
					modalDelegate:self
				   didEndSelector:@selector(savePanelDidEnd:returnCode:contextInfo:)
					  contextInfo:nil];
}
-(IBAction) load:(id)sender
{
	// Get the path
	NSArray* supportedImageTypes = [NSImage	imageFileTypes];
	NSOpenPanel* panel = [NSOpenPanel openPanel];
	[panel setDirectory:[savePath stringByExpandingTildeInPath]];
	[panel setCanChooseFiles:YES];
	[panel setCanChooseDirectories:NO];
	
	int returnCode = [panel runModalForTypes:supportedImageTypes];
	if(returnCode != NSOKButton)
	{
		return;
	}	
	
	[fetch setMyURL:[NSURL fileURLWithPath:[panel filename]]];
	
	[NSThread detachNewThreadSelector:@selector(work:) 
							 toTarget:fetch 
						   withObject:[NSArray arrayWithObjects:img,ajaxloader,nil]];	
}
-(IBAction) rotate:(id)sender
{
	int x;
	int which = [fetch returnCurrentIndex];
	float bigSide;
	
	NSAffineTransform *imageRotationg, *translate;
	NSSize bigSize;
	NSSize tmpRect;
	NSPoint center;
	NSImage *tmpImage = [[fetch myImageList] objectAtIndex:which];
	NSImage *targetImage;

	currentDegree = (currentDegree+1)%4;
	x = currentDegree * 90;
	
	tmpRect = [tmpImage size];
	
	bigSide = sqrt(tmpRect.width*tmpRect.width+tmpRect.height*tmpRect.height);
	bigSize = NSMakeSize(bigSide,bigSide);
	targetImage = [[NSImage alloc] initWithSize:bigSize];
	imageRotationg = [NSAffineTransform transform];
	translate = [NSAffineTransform transform];
	center = NSMakePoint((bigSide-((tmpRect.width)*cos(x*M_PI/180.0)-tmpRect.height*sin(x*M_PI/180.0)))/2.0,
						 (bigSide-((tmpRect.width)*sin(x*M_PI/180.0)+tmpRect.height*cos(x*M_PI/180.0)))/2.0);
	[targetImage lockFocus];
	[imageRotationg rotateByDegrees:x];
	[translate translateXBy:center.x yBy:center.y];
	[imageRotationg appendTransform:translate];
	
	[imageRotationg concat];
	[tmpImage drawAtPoint:NSMakePoint(0, 0) 
				 fromRect:NSMakeRect(0, 0, tmpRect.width, tmpRect.height) 
				operation:NSCompositeCopy 
				 fraction:1.0];
	
	[targetImage unlockFocus];
	[img setImage:targetImage];
}
-(IBAction) next:(id)sender
{
	[NSThread detachNewThreadSelector:@selector(changeImage:) 
							 toTarget:fetch 
						   withObject:[NSArray arrayWithObjects:img,[NSNumber numberWithInt:1],nil]];		 
}
-(IBAction) previous:(id)sender
{
	
	[NSThread detachNewThreadSelector:@selector(changeImage:) 
							 toTarget:fetch 
						   withObject:[NSArray arrayWithObjects:img,[NSNumber numberWithInt:-1],nil]];		
	 
}
-(IBAction) zoomIn:(id)sender
{
	[NSThread detachNewThreadSelector:@selector(zoomAction:) 
							 toTarget:self 
						   withObject:[NSNumber numberWithFloat:1.2]];
}
-(IBAction) zoomOut:(id)sender
{
	[NSThread detachNewThreadSelector:@selector(zoomAction:) 
							 toTarget:self 
						   withObject:[NSNumber numberWithFloat:0.8]];
}
-(IBAction) makeGrayScale:(id)sender
{
	int which = [fetch returnCurrentIndex];
	displayedImage = [[fetch myImageList] objectAtIndex:which];
	
	NSBitmapImageRep * abitmap;
	abitmap = (NSBitmapImageRep*)[displayedImage bestRepresentationForDevice:nil];
	int pw =  [abitmap pixelsWide];
	int ph =  [abitmap pixelsHigh];
	
	NSBitmapImageRep * bitmap =  [[NSBitmapImageRep alloc]  
								  initWithBitmapDataPlanes:NULL pixelsWide:pw  
								  pixelsHigh:ph bitsPerSample:8 samplesPerPixel:1  
								  hasAlpha:NO isPlanar:NO colorSpaceName:NSCalibratedWhiteColorSpace  
								  bytesPerRow:0 bitsPerPixel:0];
	
	[bitmap setSize: [displayedImage size]];
	
	NSImage * image =[ [NSImage alloc] initWithSize:[displayedImage size ] ];
	
	NSGraphicsContext *nsContext = [NSGraphicsContext  
									graphicsContextWithBitmapImageRep:bitmap];
	
	[NSGraphicsContext saveGraphicsState];
	
	[NSGraphicsContext setCurrentContext: nsContext];
	[ displayedImage drawAtPoint:NSMakePoint(0,0) fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
	
	// Restore the previous graphics context and state.
	[NSGraphicsContext restoreGraphicsState];
	
	[image addRepresentation: bitmap];
	[bitmap release];
	[image setScalesWhenResized:YES];
	[image setSize:[displayedImage size]];
	displayedImage = [image copy];
	
	[img setImage:displayedImage];
}
-(void) savePanelDidEnd:(NSSavePanel*)savePanel returnCode:(int)returnCode contextInfo:(void *) contextInfo
{
	if(returnCode==NSOKButton)
	{
		//int now = [fetch returnCurrentIndex];
		//[[[fetch.myImageList objectAtIndex:now] TIFFRepresentation] writeToFile:[savePanel filename] atomically:YES];
		
		NSString* path = [NSString stringWithString:[savePanel filename]];
		if([[[img image] TIFFRepresentation] writeToFile:path atomically:YES])
		{
			NSRunInformationalAlertPanel(@"Write Completely", path, @"OK", nil, nil);
		}
		else
		{
			NSRunInformationalAlertPanel(@"Write Failed", path, @"OK", nil, nil);			
		}
	}
}
-(void) zoomAction:(id)ratio
{
	float value = [ratio floatValue];
	
	NSSize scaledRect;
	NSImage* tmpImage = nil;
	int currentIndex = [fetch returnCurrentIndex];
	displayedImage = [[fetch myImageList] objectAtIndex:currentIndex];
	tmpImage       = [displayedImage retain];
	
	NSSize tmpRect    = [tmpImage size];
	scaledRect.width  = tmpRect.width*value;
	scaledRect.height = tmpRect.height*value;
	[tmpImage setSize:scaledRect];
	
	displayedImage = [tmpImage retain];	
	[img setImage:displayedImage];	
}
@end

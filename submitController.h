//
//  submitController.h
//  iGallery
//
//  Created by EragonJ on 2010/6/15.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "fetchController.h"
@interface submitController : NSObject {
	int currentDegree;
	// it's fetch object
	fetchController* fetch;
	NSString* savePath;
	NSImage* displayedImage;
	IBOutlet NSTextField* url;
	IBOutlet NSImageView* img;
	IBOutlet NSImageView* ajaxloader;
}
-(IBAction) submit:(id)sender;
-(IBAction) save:(id)sender;
-(IBAction) load:(id)sender;
-(IBAction) rotate:(id)sender;
-(IBAction) next:(id)sender;
-(IBAction) previous:(id)sender;
-(IBAction) zoomIn:(id)sender;
-(IBAction) zoomOut:(id)sender;
-(IBAction) makeGrayScale:(id)sender;
-(void) savePanelDidEnd:(NSSavePanel*)savePanel returnCode:(int)returnCode contextInfo:(void *) contextInfo;
-(void) awakeFromNib;
-(void) zoomAction:(id)ratio;
@property (retain) NSString* savePath;
@end

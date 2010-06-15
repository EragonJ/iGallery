//
//  submitController.h
//  iGallery
//
//  Created by EragonJ on 2010/6/15.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface submitController : NSObject {
	NSImage* _ajaxImg;
	IBOutlet NSTextField* url;
	IBOutlet NSImageView* img;
	IBOutlet NSImageView* ajaxImg;
}
-(IBAction) submit:(id)sender;
-(void) ajaxToggle;
@property (retain) NSImage* _ajaxImg;
@end

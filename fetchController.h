//
//  fetchController.h
//  iGallery
//
//  Created by EragonJ on 2010/6/15.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface fetchController : NSObject {
	NSURL* myURL;
	NSImage* myImage;
}
-(void) work:(id)img;
@property (retain) NSURL* myURL;
@property (retain) NSImage* myImage;
@end

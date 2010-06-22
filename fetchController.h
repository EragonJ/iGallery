//
//  fetchController.h
//  iGallery
//
//  Created by EragonJ on 2010/6/15.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface fetchController : NSObject {
	int currentIndex;
	int imageListCount;
	NSURL* myURL;
	NSImage* myImage;
	NSImage* _ajaxImg;
	NSImage* _errorImg;
	NSMutableArray* myImageList;
}
-(id) init;
-(void) work:(id)array;
-(void) changeImage:(id)array;
-(void) ajaxToggle:(NSImageView*)ajaxloader;
-(int) returnCurrentIndex;
@property (retain) NSURL* myURL;
@property (retain) NSImage* myImage;
@property (retain) NSImage* _ajaxImg;
@property (retain) NSImage* _errorImg;
@property (retain) NSMutableArray* myImageList;
@end

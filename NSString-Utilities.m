//
//  NSString-Utilities.m
//  iGallery
//
//  Created by EragonJ on 2010/6/19.
//  Copyright 2010 Hax4.in. All rights reserved.
//

#import "NSString-Utilities.h"


@implementation NSString (Utilities)
-(BOOL) isURL
{
	if([self hasPrefix:@"http://"])
	{
		return YES;
	}
	else
	{
		return NO;
	}
}
@end

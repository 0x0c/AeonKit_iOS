//
//  ANKHapticDisplay.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKHapticDisplay.h"

@interface ANKHapticDisplay ()
{
	BOOL lock_;
}

@end

@implementation ANKHapticDisplay

- (void)vibrateWithPattern:(ANKHapticPattern)pattern
{
	[self vibrateWithPattern:pattern completionHandler:nil];
}

- (void)vibrateWithDurationPattern:(NSArray *)duration completionHandler:(void (^)())handler
{
	[duration enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL *stop) {
		NSTimeInterval d = [obj doubleValue];
		if (idx % 2 == 0) {
			if (d > 0) {
				[self digitalWrite:KonashiDigitalIO7 value:KonashiLevelHigh];
				[NSThread sleepForTimeInterval:d];
			}
		}
		else {
			[self digitalWrite:KonashiDigitalIO7 value:KonashiLevelLow];
			[NSThread sleepForTimeInterval:d];
		}
	}];
}

- (void)vibrateForDuration:(NSTimeInterval)duration completionHandler:(void (^)())handler
{
	if (lock_ == NO && duration > 0) {
		[self digitalWrite:KonashiDigitalIO7 value:KonashiLevelHigh];
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[self digitalWrite:KonashiDigitalIO7 value:KonashiLevelLow];
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
				lock_ = NO;
				if (handler) {
					handler();		
				}
			});
		});
		lock_ = YES;
	}
}

- (void)vibrateWithPattern:(ANKHapticPattern)pattern completionHandler:(void (^)())handler
{
	switch (pattern) {
		case ANKHapticPatternSingleTap: {
			[self vibrateForDuration:0.1 completionHandler:handler];
		}
			break;
		case ANKHapticPatternDoubleTap: {
			[self vibrateWithPattern:ANKHapticPatternSingleTap completionHandler:^{
				dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
					[self vibrateWithPattern:ANKHapticPatternSingleTap completionHandler:handler];
				});
			}];
		}
			break;
		case ANKHapticPatternShortDuration: {
			[self vibrateForDuration:1.0 completionHandler:handler];
		}
		case ANKHapticPatternLongDuration:
			[self vibrateForDuration:5.0 completionHandler:handler];
			break;
		default:
			break;
	}
}

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	ANKHapticPattern pattern = (ANKHapticPattern)[(NSNumber *)data unsignedIntegerValue];
	[self vibrateWithPattern:pattern];
}

@end

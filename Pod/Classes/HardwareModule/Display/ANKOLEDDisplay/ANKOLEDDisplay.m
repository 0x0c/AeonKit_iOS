//
//  ANKOLEDDisplay.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKOLEDDisplay.h"

@implementation ANKOLEDDisplay

- (void)putText:(NSString *)text
{
	
}

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	NSString *string = (NSString *)data;
	[self putText:string];
}

@end

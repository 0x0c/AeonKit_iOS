//
//  ANKDepthSensor.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKDepthSensor.h"

@interface ANKDepthSensor()

@end

@implementation ANKDepthSensor

- (instancetype)init
{
	self = [super init];
	if (self) {
		__weak typeof(self) bself = self;
		[self setReadyHandler:^() {
			[bself uartMode:KonashiUartModeEnable baudrate:KonashiUartBaudrateRate9K6];
			[bself setUartRxCompleteHandler:^(NSData *data) {
				Byte op = *(Byte *)([data bytes]);
				bself.depth = (NSInteger)op;
				NSLog(@"%ld", bself.depth);
				if (bself.depthChangedHandler) {
					bself.depthChangedHandler(bself.depth);
				}
				[bself sendData:@(bself.depth)];
			}];
		}];
	}
	
	return self;
}

- (void)setDepth:(NSInteger)depth
{
	_depth = depth;
	[self sendData:@(depth)];
}

- (void)sendData:(id)data
{
	[self.output receiveDataFromModule:self data:data];
}

@end

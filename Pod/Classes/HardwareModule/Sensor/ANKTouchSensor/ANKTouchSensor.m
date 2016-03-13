//
//  ANKTocuhSensor.m
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKTouchSensor.h"

@interface ANKTouchSensor ()

@property (nonatomic, readwrite) NSInteger pressure;
@property (nonatomic, readwrite) NSInteger position;

@end

@implementation ANKTouchSensor

- (instancetype)init
{
	self = [super init];
	if (self) {
		__weak typeof(self) bself = self;
		[self setReadyHandler:^() {
			[bself uartMode:KonashiUartModeEnable baudrate:KonashiUartBaudrateRate9K6];
			[bself setUartRxCompleteHandler:^(NSData *data) {
				Byte op = *(Byte *)([data bytes]);
				BOOL type = op & 0b10000000;
				UInt8 value = op & 0b01111111;
				if (type) {
					bself.pressure = value;
					if (bself.pressureChangedHandler) {
						bself.pressureChangedHandler(value);
					}
					[bself.positionOutput receiveDataFromModule:bself data:@(value)];
				}
				else {
					bself.position = value;
					if (bself.positionChangedHandler) {
						bself.positionChangedHandler(value);
					}
					[bself.pressureOutput receiveDataFromModule:bself data:@(value)];
				}
			}];
		}];
	}
	
	return self;
}

@end

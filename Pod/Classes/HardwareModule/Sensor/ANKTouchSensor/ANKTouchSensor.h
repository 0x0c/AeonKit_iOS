//
//  ANKTocuhSensor.h
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKModule.h"

@interface ANKTouchSensor : ANKModule

@property (nonatomic, readonly) id<ANKModuleCommunicationProtocol> positionOutput;
@property (nonatomic, readonly) id<ANKModuleCommunicationProtocol> pressureOutput;
@property (nonatomic, assign) BOOL feedbackEnabled;
@property (nonatomic, readonly) NSInteger pressure;
@property (nonatomic, readonly) NSInteger position;
@property (nonatomic, copy) void (^positionChangedHandler)(NSInteger position);
@property (nonatomic, copy) void (^pressureChangedHandler)(NSInteger pressure);

@end

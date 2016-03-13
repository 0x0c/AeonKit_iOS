//
//  ANKDepthSensor.h
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import "ANKModule.h"

@interface ANKDepthSensor : ANKModule

@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> output;
@property (nonatomic, assign) NSInteger depth;
@property (nonatomic, copy) void (^depthChangedHandler)(NSInteger depth);

@end

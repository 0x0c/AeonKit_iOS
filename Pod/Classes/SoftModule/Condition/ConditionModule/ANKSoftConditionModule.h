//
//  ANKSoftConditionModule.h
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import <Foundation/Foundation.h>
#import "ANKModule.h"

typedef NS_ENUM(NSUInteger, ANKSoftConditionModuleCmparisonType) {
	ANKSoftConditionModuleCmparisonTypeEqual,
	ANKSoftConditionModuleCmparisonTypeNotEqual,
	ANKSoftConditionModuleCmparisonTypeGrater,
	ANKSoftConditionModuleCmparisonTypeGraterThan,
	ANKSoftConditionModuleCmparisonTypeLess,
	ANKSoftConditionModuleCmparisonTypeLessThan
};

@interface ANKSoftConditionModule : NSObject <ANKModuleCommunicationProtocol>

@property (nonatomic, assign) ANKSoftConditionModuleCmparisonType comparisonType;
@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> in1;
@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> in2;
@property (nonatomic, strong) id<ANKModuleCommunicationProtocol> output;

@end

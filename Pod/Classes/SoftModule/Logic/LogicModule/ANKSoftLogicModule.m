//
//  ANKSoftLogicModule.m
//  Pods
//
//  Created by Akira Matsuda on 3/13/16.
//
//

#import "ANKSoftLogicModule.h"

@implementation ANKSoftLogicModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)sendData:(id)data
{
	[self.output receiveDataFromModule:self data:data];
}

- (void)receiveDataFromModule:(ANKModule *)modul data:(id)data
{
	
}

@end

@interface ANKSoftLogicNOTModule ()

@property (nonatomic, assign) BOOL input1Value;
@property (nonatomic, assign) BOOL input2Value;

@end

@implementation ANKSoftLogicNOTModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	[self sendData:@(![(NSNumber *)data boolValue])];
}

@end

@interface ANKSoftLogicANDModule ()

@property (nonatomic, assign) BOOL input1Value;
@property (nonatomic, assign) BOOL input2Value;

@end

@implementation ANKSoftLogicANDModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	[self sendData:@(self.input1Value & self.input2Value)];
}

@end

@interface ANKSoftLogicORModule ()

@property (nonatomic, assign) BOOL input1Value;
@property (nonatomic, assign) BOOL input2Value;

@end

@implementation ANKSoftLogicORModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	[self sendData:@(self.input1Value | self.input2Value)];
}

@end

@interface ANKSoftLogicXORModule ()

@property (nonatomic, assign) BOOL input1Value;
@property (nonatomic, assign) BOOL input2Value;

@end

@implementation ANKSoftLogicXORModule

#pragma mark - ANKModuleCommunicationProtocol

- (void)receiveDataFromModule:(ANKModule *)module data:(id)data
{
	[self sendData:@(self.input1Value ^ self.input2Value)];
}

@end
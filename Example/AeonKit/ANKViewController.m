//
//  ANKViewController.m
//  AeonKit
//
//  Created by Akira Matsuda on 02/09/2016.
//  Copyright (c) 2016 Akira Matsuda. All rights reserved.
//

#import "ANKViewController.h"
#import "AeonKit.h"

@interface ANKViewController ()

@property (strong, nonatomic) NSMutableDictionary<NSString *, id<ANKModuleCommunicationProtocol>> *modules;
@property (strong, nonatomic) ANKDepthSensor *depth;
@property (strong, nonatomic) ANKSoftConditionModule *condition;
@property (strong, nonatomic) IBOutlet UITextField *depthValueTextField;
@property (strong, nonatomic) IBOutlet UIButton *depthSettingButton;
@property (strong, nonatomic) IBOutlet UIButton *changeComparisonTypeButton;

@end

@implementation ANKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.modules = [NSMutableDictionary new];
	
	// Do any additional setup after loading the view, typically from a nib.
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"graph" ofType:@"amg"];
	NSError *error;
	NSString *text = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
	NSLog(@"%@", text);
	
	NSArray *line = [text componentsSeparatedByString:@"\n"];
	for (NSString *connection in line) {
		if (connection.length == 0) {
			break;
		}
		NSLog(@"%@", connection);
		NSArray *module = [connection componentsSeparatedByString:@" "];
		NSArray *param = [module[0] componentsSeparatedByString:@":"];
		NSLog(@"%@ - %@", module[0], param);
		NSObject<ANKModuleCommunicationProtocol> *node1 = self.modules[param[0]];
		if (node1 == nil) {
			node1 = [self nodeFromString:param];
			self.modules[param[0]] = node1;
		}
		NSString *outputKey = param[2];
		param = [module[1] componentsSeparatedByString:@":"];
		NSLog(@"%@ - %@", module[1], param);
		NSObject<ANKModuleCommunicationProtocol> *node2 = self.modules[param[0]];
		if (node2 == nil) {
			node2 = [self nodeFromString:param];
			self.modules[param[0]] = node2;
		}
		NSString *inputKey = param[2];
		[node1 setValue:node2 forKey:outputKey];
		[node2 setValue:node1 forKey:inputKey];
		if ([node1 isKindOfClass:[ANKDepthSensor class]]) {
			self.depth = (ANKDepthSensor *)node1;
		}
		if ([node1 isKindOfClass:[ANKSoftConditionModule class]]) {
			self.condition = (ANKSoftConditionModule *)node1;
		}
	}
	
//	self.depth = [[ANKDepthSensor alloc] initWithModuleName:@"konashi02-aabbcc"];
//	
//	ANKSoftValueModule *threshold = [ANKSoftValueModule new];
//	threshold.moduleValue = 100;
//	
//	self.condition = [ANKSoftConditionModule new];
//	self.condition.comparisonType = ANKSoftConditionModuleCmparisonTypeGrater;
//
//	self.depth.output = self.condition;
//	self.condition.input1 = self.depth;
//	
//	threshold.output = self.condition;
//	self.condition.input2 = threshold;
//	
//	ANKSoftHapticPatternGeneratorModule *generator = [ANKSoftHapticPatternGeneratorModule new];
//	generator.pattern = ANKHapticPatternDoubleTap;
//	generator.input = self.condition;
//	self.condition.output = generator;
//	
//	ANKHapticDisplay *haptic = [[ANKHapticDisplay alloc] initWithModuleName:@"konashi02-ddeeff"];
//	generator.output = haptic;
}

- (IBAction)updateDepth:(id)sender
{
	NSInteger depth = [self.depthValueTextField.text integerValue];
	self.depth.depthValue = depth;
}

- (IBAction)changeComparisonType:(id)sender
{
	self.condition.comparisonType = ANKSoftConditionModuleCmparisonTypeLess;
}

- (id<ANKModuleCommunicationProtocol>)nodeFromString:(NSArray<NSString *> *)param
{
	id<ANKModuleCommunicationProtocol> node = nil;
	NSString *label = param[0];
	if ([label isEqualToString:@"BOOL"]) {
//		node = new AeonKitMapper::LogicBooleanModule(offset, offset);
	}
	else if ([label isEqualToString:@"NOT"]) {
		node = [ANKSoftLogicNOTModule new];
	}
	else if ([label isEqualToString:@"AND"]) {
		node = [ANKSoftLogicANDModule new];
	}
	else if ([label isEqualToString:@"OR"]) {
		node = [ANKSoftLogicORModule new];
	}
	else if ([label isEqualToString:@"XOR"]) {
		node = [ANKSoftLogicXORModule new];
	}
	else if ([label isEqualToString:@"HapticPatternGenerator"]) {
		node = [ANKSoftHapticPatternGeneratorModule new];
	}
	else if ([label isEqualToString:@"Counter"]) {
		node = [ANKSoftCounterModule new];
	}
	else if ([label isEqualToString:@"Value"]) {
		node = [ANKSoftValueModule new];
		((ANKSoftValueModule *)node).moduleValue = [param[3] integerValue];
	}
	else if ([label isEqualToString:@"Condition"]) {
		node = [ANKSoftConditionModule new];
		((ANKSoftConditionModule *)node).comparisonType = [param[3] integerValue];
	}
	else if ([label isEqualToString:@"OLEDDisplay"]) {
		node = [[ANKOLEDDisplay alloc] initWithModuleName:param[3]];
	}
	else if ([label isEqualToString:@"HapticDisplay"]) {
		node = [[ANKHapticDisplay alloc] initWithModuleName:param[3]];
	}
	else if ([label isEqualToString:@"DepthSensor"]) {
		node = [[ANKDepthSensor alloc] initWithModuleName:param[3]];
	}
	else if ([label isEqualToString:@"TiltSensor"]) {
		node = [[ANKTiltSensor alloc] initWithModuleName:param[3]];
	}
	else if ([label isEqualToString:@"TouchSensor"]) {
		node = [[ANKTiltSensor alloc] initWithModuleName:param[3]];
	}
	
	return node;
}

@end

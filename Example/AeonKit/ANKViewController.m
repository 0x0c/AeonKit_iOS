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
	// Do any additional setup after loading the view, typically from a nib.
	self.depth = [[ANKDepthSensor alloc] initWithModuleName:@"konashi02-aabbcc"];
	
	ANKSoftValueModule *threshold = [ANKSoftValueModule new];
	threshold.moduleValue = 100;
	
	self.condition = [ANKSoftConditionModule new];
	self.condition.comparisonType = ANKSoftConditionModuleCmparisonTypeGrater;

	self.condition.input1 = self.depth;
	self.depth.output = self.condition;
	
	self.condition.input2 = threshold;
	threshold.output = self.condition;
	
	ANKSoftHapticPatternGeneratorModule *generator = [ANKSoftHapticPatternGeneratorModule new];
	generator.pattern = ANKHapticPatternDoubleTap;
	generator.input = self.condition;
	self.condition.output = generator;
	
	ANKHapticDisplay *haptic = [[ANKHapticDisplay alloc] initWithModuleName:@"konashi02-ddeeff"];
	generator.output = haptic;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateDepth:(id)sender
{
	NSInteger depth = [self.depthValueTextField.text integerValue];
	self.depth.depth = depth;
}

- (IBAction)changeComparisonType:(id)sender
{
	self.condition.comparisonType = ANKSoftConditionModuleCmparisonTypeLess;
}

@end

//
//  ANKModule.h
//  Pods
//
//  Created by Akira Matsuda on 2/9/16.
//
//

#import <Foundation/Foundation.h>
#import "ANKModuleCommunicationProtocol.h"
#import "Konashi.h"

typedef NS_ENUM(NSInteger, ANKModuleType) {
	ANKModuleTypeSensor,
	ANKModuleTypeDisplay,
	ANKModuleTypeSoftLogic,
	ANKModuleTypeSoftUtility,
	ANKModuleTypeSoftCondition,
};

@interface ANKModule : KNSPeripheral <ANKModuleCommunicationProtocol>

- (_Nonnull instancetype)initWithModuleName:(NSString * _Nonnull )moduleName;
- (void)connect;
- (void)disconnect;

@property (nonatomic, assign) ANKModuleType type;
@property (nonatomic, strong) ANKModule * _Nullable inputModule;
@property (nonatomic, strong) ANKModule * _Nullable outputModule;
@property (nonatomic, readonly) NSString * _Nonnull moduleName;
@property (nonatomic, readonly) BOOL connected;

@end

//
//  IGEventManager.m
//  FBSnapshotTestCase
//
//  Created by land sun on 2020/12/9.
//

#import "IGEventManager.h"
#import "IGEventModel.h"

@interface IGEventManager ()

@property (nonatomic, strong) NSMutableArray *eventData;

@end

@implementation IGEventManager

+ (instancetype)sharedManager {
    static id sharedInstaller = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstaller = [[self alloc] init];
    });
    return sharedInstaller;
}

+ (void)load {
    
}

- (void)pushKTBehaviorData:(id)data {
    //线程锁、保证数据完整性
    @synchronized(self) {
        IGEventModel *eventModel = (IGEventModel *)data;
        [self.eventData addObject:eventModel];
        //NSLogDebug(@"打点记录::%@",[eventModel ig_modelToJSONString]);
    }
}
@end

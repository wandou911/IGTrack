//
//  IGEventManager.h
//  FBSnapshotTestCase
//
//  Created by land sun on 2020/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGEventManager : NSObject

+ (instancetype)sharedManager;

//代码埋点

- (void)pushKTBehaviorData:(id)data;

@end

NS_ASSUME_NONNULL_END

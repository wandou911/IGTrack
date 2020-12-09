//
//  UIViewController+IGRouter.h
//  FBSnapshotTestCase
//
//  Created by land sun on 2020/12/9.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (IGRouter)
///>获取当前活动VC
+ (UIViewController *_Nullable)ig_currentViewController;

@end

NS_ASSUME_NONNULL_END

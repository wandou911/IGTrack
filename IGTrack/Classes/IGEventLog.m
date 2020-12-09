//
//  IGEventLog.m
//  FBSnapshotTestCase
//
//  Created by land sun on 2020/12/9.
//

#import "IGEventLog.h"
#import "IGEventModel.h"
#import "IGEventManager.h"
#import "UIViewController+IGRouter.h"

@implementation IGEventLog

+ (void)logEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID btnTitle:(NSString *)btnTitle
{
    NSString *targetName =NSStringFromClass([klass class]);
    NSString *actionName =NSStringFromSelector(selector);
    
    UIViewController *vc = [UIViewController ig_currentViewController];
    
    
    IGEventModel *btnModel = [[IGEventModel alloc] init];
    btnModel.targetName = targetName;
    btnModel.actionName = actionName;
    btnModel.buttonType = eventID;
    btnModel.buttonTitle = btnTitle;
    [[IGEventManager sharedManager] pushKTBehaviorData:btnModel];
    
}

@end

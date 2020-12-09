//
//  UIControl+IGHook.m
//  FBSnapshotTestCase
//
//  Created by land sun on 2020/12/9.
//

#import "UIControl+IGHook.h"
#import <objc/runtime.h>
#import "IGEventLog.h"

@implementation UIControl (IGHook)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = [UIControl class];
        
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(igLogSendAction:to:forEvent:);
        Method originalMethod = class_getInstanceMethod(cls, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
        
        BOOL add = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (add) {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else{
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
- (void)igLogSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    
    NSString *actionName =NSStringFromSelector(action);
    NSString *targetName =NSStringFromClass([target class]);
    NSString *btnTitle;
    if (@available(iOS 13.0, *)) {
        btnTitle = self.largeContentTitle;
    } else {
        // Fallback on earlier versions
        if ([self isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)self;
            btnTitle = [btn currentTitle];
        }
    }
    //跳过growing iO
    if (![actionName hasPrefix:@"growingHook"]) {
        
        NSString *viewpath = [self viewPath:self];
        if (![target isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = [UIViewController ig_currentViewController];
            NSString *name = NSStringFromClass([vc class]);
            
            [IGEventLog logEventWithClass:[vc class] selector:action eventID:viewpath btnTitle:btnTitle];
            
        }else{
            [IGEventLog logEventWithClass:target selector:action eventID:viewpath btnTitle:btnTitle];
        }
        
        NSLog(@"viewpath:%@",[self viewPath:self]);
        
    }
    [self igLogSendAction:action to:target forEvent:event];
}

-(NSString *)viewPath:(UIView *)currentView{
    __block NSString *viewPath = @"";
    
    for (UIView *view = currentView;view;view = view.superview) {
        //NSLog(@"%@",view);
        if ([view isKindOfClass:[UICollectionViewCell class]]) {
            // 是一个
            UICollectionViewCell *cell = (UICollectionViewCell *)view;
            UICollectionView *cv = (UICollectionView *)cell.superview;
            NSIndexPath *indexPath = [cv indexPathForCell:cell];
            NSString *className = NSStringFromClass([cell class]);
            viewPath = [NSString stringWithFormat:@"%@[%ld:%ld]/%@",className,indexPath.section,indexPath.row,viewPath];
            continue;
        }
        
        if ([view isKindOfClass:[UITableViewCell class]]) {
            // 是一个
            UITableViewCell *cell = (UITableViewCell *)view;
            UITableView *tb = (UITableView *)cell.superview;
            NSIndexPath *indexPath = [tb indexPathForCell:cell];
            NSString *className = NSStringFromClass([cell class]);
            viewPath = [NSString stringWithFormat:@"%@[%ld:%ld]/%@",className,indexPath.section,indexPath.row,viewPath];
            continue;
        }
        
        
        if ([view isKindOfClass:[UIView class]]) {
            [view.superview.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj == view) {
                    NSString *className = NSStringFromClass([view class]);
                    viewPath = [NSString stringWithFormat:@"%@[%ld]/%@",className,idx,viewPath];
                    *stop = YES;
                }
            }];
        }
        
        UIResponder *responder = [view nextResponder];
        if ([responder isKindOfClass:[UIViewController class]]) {
            
            NSString *className = NSStringFromClass([responder class]);
            viewPath = [NSString stringWithFormat:@"%@/%@",className,viewPath];
            return viewPath;
        }
    }
    return viewPath;
}

@end

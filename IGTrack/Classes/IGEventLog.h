//
//  IGEventLog.h
//  FBSnapshotTestCase
//
//  Created by land sun on 2020/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGEventLog : NSObject

+ (void)logEventWithClass:(Class)klass selector:(SEL)selector eventID:(NSString*)eventID btnTitle:(NSString *)btnTitle;

@end

NS_ASSUME_NONNULL_END

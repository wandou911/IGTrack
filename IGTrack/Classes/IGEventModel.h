//
//  IGEventModel.h
//  FBSnapshotTestCase
//
//  Created by land sun on 2020/12/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGEventModel : NSObject

@property (nonatomic, strong) NSString *targetName;//当前页面类名
@property (nonatomic, strong) NSString *pageTitle;//页面标题
@property (nonatomic, strong) NSString *actionName;//方法名
@property (nonatomic, strong) NSString *buttonTitle;//按钮名称
@property (nonatomic, strong) NSString *buttonType;//按钮唯一标识符
@end



NS_ASSUME_NONNULL_END

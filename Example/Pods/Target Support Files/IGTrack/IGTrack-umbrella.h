#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IGEventLog.h"
#import "IGEventManager.h"
#import "IGEventModel.h"
#import "IGTrackManager.h"
#import "UIControl+IGHook.h"
#import "UIViewController+IGRouter.h"

FOUNDATION_EXPORT double IGTrackVersionNumber;
FOUNDATION_EXPORT const unsigned char IGTrackVersionString[];


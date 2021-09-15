//
//  UIImage+ImageLoad.h
//  IGImageCropper
//
//  Created by arshad tp on 15/09/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ImageLoad)
+ (UIImage *) bundledImageNamed: (NSString *) name bundleId: (NSString *) bundleId;
@end

NS_ASSUME_NONNULL_END

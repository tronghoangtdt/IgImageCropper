//
//  IGCropViewController.h
//  IGImageCropper
//
//  Created by arshad tp on 15/09/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGCropViewController : UIViewController <UIScrollViewDelegate>

- (instancetype) initWithImage: (UIImage *) image minimumPortraitZoomScale: (CGFloat) minimumPortraitZoomScale minimumLandScapeZoomScale: (CGFloat) minimumLandScapeZoomScale;
@end

NS_ASSUME_NONNULL_END

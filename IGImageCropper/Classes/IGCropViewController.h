//
//  IGCropViewController.h
//  IGImageCropper
//
//  Created by arshad tp on 15/09/21.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class IGCropViewController;
@protocol IGCropViewControllerDelegate <NSObject>

- (void)cropViewController:(IGCropViewController *)cropViewController didCropToImage:(UIImage *)image withRect:(CGRect)cropRect;
- (void)cropViewController:(IGCropViewController *)cropViewController didFinishCancelled:(BOOL)cancelled;

@end

@interface IGCropViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) NSString *_Nullable chooseButtonTitle;
@property (nonatomic, strong) NSString *_Nullable cancelButtonTitle;
@property (nullable, nonatomic, weak) id<IGCropViewControllerDelegate> delegate;


- (instancetype) initWithImage: (UIImage *) image minimumPortraitZoomScale: (CGFloat) minimumPortraitZoomScale minimumLandScapeZoomScale: (CGFloat) minimumLandScapeZoomScale;
@end



NS_ASSUME_NONNULL_END

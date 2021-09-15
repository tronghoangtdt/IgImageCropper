//
//  UIImage+ImageLoad.m
//  IGImageCropper
//
//  Created by arshad tp on 15/09/21.
//

#import "UIImage+ImageLoad.h"

@implementation UIImage (ImageLoad)

+ (UIImage *) bundledImageNamed: (NSString *) name bundleId: (NSString *) bundleId {
    
    UIImage *image = [UIImage imageNamed:name];
    if (!image) {
        NSBundle *bundle = [NSBundle bundleWithIdentifier:bundleId];
        if (@available(iOS 13.0, *)) {
            return [UIImage imageNamed:name inBundle:bundle withConfiguration:nil];
        } else {
            // Fallback on earlier versions
        }
    }
    return image;
    
}
//class func bundledImage(named: String) -> UIImage? {
//    let image = UIImage(named: named)
//    if image == nil {
//        let bundle = Bundle(identifier: "org.cocoapods.IGImageCropper")
//
//        return UIImage(named: named, in: bundle, compatibleWith: nil)
//    } // Replace MyBasePodClass with yours
//    return image
//}
@end

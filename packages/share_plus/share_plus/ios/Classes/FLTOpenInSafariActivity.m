//
//  FLTOpenInSafariActivity.m
//  share_plus
//
//  Created by Ha Hung on 04/01/2022.
//

#import <Foundation/Foundation.h>
#import "FLTSharePlusPlugin.h"

@interface FLTOpenInSafariActivity : UIActivity

@end

@implementation FLTOpenInSafariActivity {
    NSURL* _url;
}

- (NSString *) activityType {
    return @"io.flutter.OpenInSafariActivity";
}

- (NSString *) activityTitle {
    return @"Open in Safari";
}

- (UIImage *) activityImage {
    if (@available(iOS 13.0, *)) {
        UIImageSymbolConfiguration * configuration = [UIImageSymbolConfiguration configurationWithPointSize:24 weight:UIImageSymbolWeightRegular scale:UIImageSymbolScaleDefault];
        return [UIImage systemImageNamed:@"safari" withConfiguration:configuration];
    } else {
        return [self imageWithImage:[UIImage imageNamed:@"icon_my_safari" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil] scaledToSize:CGSizeMake(31, 31)];
    }
}

- (BOOL) canPerformWithActivityItems:(NSArray *)activityItems {
    BOOL isUrl = activityItems.count == 1
        && [activityItems[0] isKindOfClass:[NSURL class]];
    return isUrl;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    _url = activityItems[0];
}

- (void) performActivity {
    [[UIApplication sharedApplication] openURL:_url];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

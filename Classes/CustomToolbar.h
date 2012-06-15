

#import <UIKit/UIKit.h>


@interface CustomToolbar : UIToolbar {

	UIImageView *img;
}

@property(nonatomic, retain) UIImageView *img;
-(CustomToolbar*)initWithImage:(UIImage *)image;
@end

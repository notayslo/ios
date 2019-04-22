//
//  MainViewController.h
//  RSSchool_T4
//
//  Created by Anton Sipaylo on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController

- (void)viewDidLoad;
- (void) createNumberTextField:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
- (void) deleteImageFromNumberTextField;
- (void) setImageToNumberTextField:(NSString*)country;
- (NSString*) deleteUnnessesarySymbolsInNumber:(NSString*)string;

@end

NS_ASSUME_NONNULL_END

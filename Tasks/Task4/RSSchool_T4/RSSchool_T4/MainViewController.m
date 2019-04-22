//
//  MainViewController.m
//  RSSchool_T4
//
//  Created by Anton Sipaylo on 4/22/19.
//  Copyright © 2019 iOSLab. All rights reserved.
//

#import "MainViewController.h"
#import "TelephoneNumber.h"

@interface MainViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *numberTextField;
@property (nonatomic, strong) UITapGestureRecognizer *numbertapGeastureRecognizer;
@property (nonatomic, retain) TelephoneNumber *telephoneNumber;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    const CGFloat x = 50.0;
    const CGFloat y = 50.0;
    const CGFloat width = 200.0;
    const CGFloat height = 50;
    [self createNumberTextField:x y:y width:width height:height];
//    [self initNumberTapGeastureRecognizer];
}

- (void) initNumberTapGeastureRecognizer {
    self.numbertapGeastureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processTapOnNumberTextField:)];
    [self.numberTextField addGestureRecognizer:self.numbertapGeastureRecognizer];
}

- (void) processTapOnNumberTextField:(UITapGestureRecognizer*)tapGeastureRecognizer {
    CGPoint point = [tapGeastureRecognizer locationInView:self.numberTextField];
    if (tapGeastureRecognizer.state == UIGestureRecognizerStateEnded &&
        CGRectContainsPoint(self.numberTextField.frame, point)) {
        NSLog(@"processTapOnNumberTextField worked!");
        [self.numberTextField becomeFirstResponder];
    }
}

- (void) createNumberTextField:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    CGRect textFieldFrame = CGRectMake(x, y, width, height);
    self.numberTextField = [[UITextField alloc] initWithFrame:textFieldFrame];
    self.numberTextField.borderStyle = UITextBorderStyleLine;
    self.numberTextField.delegate = self;
    self.numberTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.numberTextField];
}

- (void) setImageToNumberTextField:(NSString*)country {
    NSString *countryAbbreviate = [NSString stringWithFormat:@"flag_%@", country];
    UIImage *image = [UIImage imageNamed:countryAbbreviate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.numberTextField.leftView = imageView;
    self.numberTextField.leftViewMode = UITextFieldViewModeAlways;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.numberTextField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (finalString.length > 12)
        return NO;
    if (finalString.length == 1 && [finalString characterAtIndex:0] != '+') {
        textField.text = [NSString stringWithFormat:@"+%@", finalString];
    
    return YES;
}

@end


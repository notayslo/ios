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
@property (nonatomic, retain) TelephoneNumber *telephoneNumber;
@property (nonatomic, retain) NSString *presentUserNumber;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    const CGFloat x = 50.0;
    const CGFloat y = 50.0;
    const CGFloat width = 200.0;
    const CGFloat height = 50;
    [self createNumberTextField:x y:y width:width height:height];
    self.presentUserNumber = [NSString new];
}

- (void) createNumberTextField:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    CGRect textFieldFrame = CGRectMake(x, y, width, height);
    self.numberTextField = [[UITextField alloc] initWithFrame:textFieldFrame];
    self.numberTextField.borderStyle = UITextBorderStyleLine;
    self.numberTextField.delegate = self;
    self.numberTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.numberTextField];
}

- (void) deleteImageFromNumberTextField {
    self.numberTextField.leftViewMode = UITextFieldViewModeNever;
}

- (void) setImageToNumberTextField:(NSString*)country {
    NSString *countryFlagName = [NSString stringWithFormat:@"flag_%@", country];
    UIImage *image = [UIImage imageNamed:countryFlagName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.numberTextField.leftView = imageView;
    self.numberTextField.leftViewMode = UITextFieldViewModeAlways;
}


- (NSString*) deleteUnnessesarySymbolsInNumber:(NSString*)string {
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"+() -"];
    return [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.numberTextField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length == 0 && string.length == 1 && [string characterAtIndex:0] == '+') {
        return YES;
    }
    NSString *replacedString = [textField.text substringWithRange:range];
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (replacedString.length == 1 && [replacedString characterAtIndex:0] == ' ') {
        NSRange range = NSMakeRange(0, finalString.length - 2);
        finalString = [finalString substringWithRange:range];
    }
    NSString *telephone = [self deleteUnnessesarySymbolsInNumber:finalString];
    if (telephone.length > 12) {
        return NO;
    }
    TelephoneNumber *validNumber = [TelephoneNumber processNumber:telephone];
    self.numberTextField.text = [NSString stringWithString:validNumber.telephone];
    if (validNumber.country != nil) {
        [self setImageToNumberTextField:validNumber.country];
    } else {
        [self deleteImageFromNumberTextField];
    }
    return NO;
}

@end


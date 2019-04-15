#import "DateMachine.h"

@interface DateMachine() <UITextFieldDelegate>

@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;
@property (nonatomic, retain) NSArray<NSString*> *dateUnitValues;
@property (nonatomic, retain) NSNumber *step;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, assign) NSString *dateUnit;

@property (nonatomic, strong) UILabel *currentDateLabel;

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *subButton;

@property (nonatomic, strong) UITextField *startDateTextField;
@property (nonatomic, strong) UITextField *stepTextField;
@property (nonatomic, strong) UITextField *dateUnitTextField;

@end

@implementation DateMachine

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initFormatters];
  self.dateUnitValues = @[@"year", @"month", @"week", @"day", @"hour", @"minute"];
  [self initCurrentDateLabel];
  [self initAddButton];
  [self initSubButton];
  [self initStartDateTextField];
  [self initStepTextField];
  [self initDateUnitTextField];
  self.startDateTextField.text = [self.dateFormatter stringFromDate:[self.dateFormatter dateFromString:self.currentDateLabel.text]];
}

- (void) initFormatters {
  [self initDateFormatter];
  [self initNumberFormatter];
}

- (void)initDateFormatter {
  self.dateFormatter = [NSDateFormatter new];
  [self.dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
  NSLog(@"date format = %@", [self.dateFormatter dateFormat]);
}

- (void)initNumberFormatter {
  self.numberFormatter = [NSNumberFormatter new];
  self.numberFormatter.locale = [NSLocale currentLocale];
  self.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
}

- (NSString*)getCurrentDate {
  return [self.dateFormatter stringFromDate:[NSDate date]];
}

- (void)initCurrentDateLabel {
  CGFloat xLabel = 100;
  CGFloat yLabel = 40;
  CGFloat widthLabel = 200;
  CGFloat heightLabel = 50;
  NSInteger numberOfLinesLabel = 0;
  CGRect frame = CGRectMake(xLabel, yLabel, widthLabel, heightLabel);
  self.currentDateLabel = [[UILabel alloc] initWithFrame:frame];
  self.currentDateLabel.textAlignment = NSTextAlignmentCenter;
  self.currentDateLabel.textColor = [UIColor blackColor];
  self.currentDateLabel.numberOfLines = numberOfLinesLabel;
  self.currentDateLabel.text = [self getCurrentDate];
  [self.currentDateLabel sizeToFit];
  [self.view addSubview:self.currentDateLabel];
}

- (void)initButton:(UIButton*)button X:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height TitleColor:(UIColor*) color Title:(NSString*)title {
  CGRect frame = CGRectMake(x, y, width, height);
  button.frame = frame;
  button.layer.borderColor = [UIColor blackColor].CGColor;
  button.layer.borderWidth = 1.f;
  button.layer.cornerRadius = height / 2.0;
  [button setTitleColor:color forState:UIControlStateNormal];
  [button setTitle:title forState:UIControlStateNormal];
}

- (void)initAddButton {
  CGFloat x = 100;
  CGFloat y = 400;
  CGFloat width = 200;
  CGFloat height = 50;
  NSString *normalTitle = @"add";
  self.addButton = [[UIButton alloc] init];
  [self initButton:self.addButton X:x Y:y Width:width Height:height TitleColor:[UIColor blackColor] Title:normalTitle];
  self.addButton.accessibilityIdentifier = @"Add";
  [self addTargetToAddButton];
  [self.view addSubview:self.addButton];
}

- (void)initSubButton {
  CGFloat x = 100;
  CGFloat y = 500;
  CGFloat width = 200;
  CGFloat height = 50;
  NSString *normalTitle = @"sub";
  self.subButton = [[UIButton alloc] init];
  [self initButton:self.subButton X:x Y:y Width:width Height:height TitleColor:[UIColor blackColor] Title:normalTitle];
  self.subButton.accessibilityIdentifier = @"Sub";
  [self.subButton setTitle:normalTitle forState:UIControlStateNormal];
  [self addTargetToSubButton];
  [self.view addSubview:self.subButton];
}

- (bool)getValuesFromTextFields {
  self.step = [self checkStepTextField];
  self.startDate = [self checkStartDateTextField];
  self.dateUnit = [self checkDateUnitTextField];
  if (self.startDate == nil) {
    NSLog(@"Start date is nil");
    self.startDate = [self.dateFormatter dateFromString:self.currentDateLabel.text];
    NSLog(@"Start date = %@", [self.dateFormatter stringFromDate:self.startDate]);
  }
  return self.step != nil && self.dateUnit != nil;
}

- (void)setCurrentDate:(bool)add {
  NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
  NSInteger step = [self.step integerValue];
  if ([self.dateUnit isEqualToString:@"year"]) {
    NSLog(@"1");
    
    dateComponents.year = (add? step : -step);
//    [dateComponents setYear:(add? step : -step)];
  } else if ([self.dateUnit isEqualToString:@"month"]) {
    NSLog(@"2");
    dateComponents.month = (add? step : -step);
//    [dateComponents setMonth:(add? step : -step)];
  } else if ([self.dateUnit isEqualToString:@"week"]) {
    NSLog(@"3");
    dateComponents.day = 7 * (add? step : -step);
//    [dateComponents setWeekday:(add? step : -step)];
  } else if ([self.dateUnit isEqualToString:@"day"]) {
    NSLog(@"4");
    dateComponents.day = (add? step : -step);
//    [dateComponents setDay:(add? step : -step)];
  } else if ([self.dateUnit isEqualToString:@"hour"]) {
    NSLog(@"5");
    dateComponents.hour = (add? step : -step);
//    [dateComponents setHour:(add? step : -step)];
  } if ([self.dateUnit isEqualToString:@"minute"]) {
    NSLog(@"6");
    dateComponents.minute = (add? step : -step);
//    [dateComponents setMinute:(add? step : -step)];
  }
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSLog(@"Start date = %@", [self.dateFormatter stringFromDate:self.startDate]);
  NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:self.startDate options:0];
  self.currentDateLabel.text = [self.dateFormatter stringFromDate:newDate];
  self.startDateTextField.text = [NSString stringWithString:[self.dateFormatter stringFromDate:newDate]];
  [dateComponents release];
  [newDate release];
}

- (void)addTargetToAddButton {
  [self.addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addButtonPressed:(id)sender {
  if ([self getValuesFromTextFields]) {
    [self setCurrentDate: YES];
  }
}

- (void)addTargetToSubButton {
  [self.subButton addTarget:self action:@selector(subButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)subButtonPressed:(id)sender {
  if ([self getValuesFromTextFields]) {
    [self setCurrentDate: NO];
  }
}

- (void)initTextField:(UITextField*)textField X:(CGFloat)x Y:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height Placeholder:(NSString*)placeholder {
  CGRect frame = CGRectMake(x, y, width, height);
  textField.frame = frame;
  textField.layer.borderColor = [UIColor blackColor].CGColor;
  textField.layer.borderWidth = 1.f;
  textField.textColor = [UIColor blackColor];
  textField.textAlignment = NSTextAlignmentCenter;
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textField.text = @"";
  textField.placeholder = placeholder;
  textField.delegate = self;
}

- (void)initStartDateTextField {
  CGFloat x = 100;
  CGFloat y = 100;
  CGFloat width = 200;
  CGFloat height = 50;
  NSString *placeholder = @"Start date";
  self.startDateTextField = [[UITextField alloc] init];
  self.startDateTextField.accessibilityIdentifier = @"Start date";
  [self initTextField:self.startDateTextField X:x Y:y Width:width Height:height Placeholder:placeholder];
  [self.view addSubview:self.startDateTextField];
}

- (void)initStepTextField {
  CGFloat x = 100;
  CGFloat y = 200;
  CGFloat width = 200;
  CGFloat height = 50;
  NSString *placeholder = @"Step";
  self.stepTextField = [[UITextField alloc] init];
  [self initTextField:self.stepTextField X:x Y:y Width:width Height:height Placeholder:placeholder];
  self.stepTextField.accessibilityIdentifier = @"Step";
  [self.view addSubview:self.stepTextField];
}

- (void)initDateUnitTextField {
  CGFloat x = 100;
  CGFloat y = 300;
  CGFloat width = 200;
  CGFloat height = 50;
  NSString *placeholder = @"Date unit";
  self.dateUnitTextField = [[UITextField alloc] init];
  [self initTextField:self.dateUnitTextField X:x Y:y Width:width Height:height Placeholder:placeholder];
  self.dateUnitTextField.accessibilityIdentifier = @"Date unit";
  [self.view addSubview:self.dateUnitTextField];
}

- (NSNumber*)checkStepTextField {
  NSNumber *number = [self.numberFormatter numberFromString:self.stepTextField.text];
  if (number == nil) {
    self.stepTextField.textColor = [UIColor redColor];
    self.stepTextField.text = @"Step";
  }
  return number;
}

- (NSDate*)checkStartDateTextField {
  NSDate *date = [self.dateFormatter dateFromString:self.startDateTextField.text];
  if (date == nil) {
    self.startDateTextField.textColor = [UIColor redColor];
    self.startDateTextField.text = @"Start date";
  }
  return date;
}

- (NSString*)checkDateUnitTextField {
  if (![self.dateUnitValues containsObject:self.dateUnitTextField.text]) {
    self.dateUnitTextField.textColor = [UIColor redColor];
    self.dateUnitTextField.text = @"Date unit";
    return nil;
  }
  return self.dateUnitTextField.text;
}

#pragma MARK UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField {
  textField.textColor = [UIColor blackColor];
  textField.text = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  if (textField == self.stepTextField) {
    [self checkStepTextField];
  } else if (textField == self.startDateTextField) {
    [self checkStartDateTextField];
  } else if (textField == self.dateUnitTextField) {
    [self checkDateUnitTextField];
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  return YES;
}

- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
  NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
  if (finalString.length == 0) return YES;
  if (textField == self.stepTextField) {
    return [self.numberFormatter numberFromString:finalString] != nil;
  } else if (textField == self.startDateTextField) {
    NSDate *newDate = [self.dateFormatter dateFromString:finalString];
    if(newDate != nil) {
      self.currentDateLabel.text = [self.dateFormatter stringFromDate:newDate];
    }
    return YES;
  } else if (textField == self.dateUnitTextField) {
    for (NSString *value in self.dateUnitValues) {
      if([value hasPrefix:finalString]) return YES;
    }
  }
  return NO;
}

@end

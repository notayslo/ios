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
}

- (void) initFormatters {
  [self initDateFormatter];
  [self initNumberFormatter];
}

- (void)initDateFormatter {
  self.dateFormatter = [NSDateFormatter new];
  [self.dateFormatter setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
}

- (void)initNumberFormatter {
  self.numberFormatter = [NSNumberFormatter new];
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
  [self.subButton setTitle:normalTitle forState:UIControlStateNormal];
  [self addTargetToSubButton];
  [self.view addSubview:self.subButton];
}

- (bool)getValuesFromTextFields {
  self.step = [self checkStepTextField];
  self.startDate = [self checkStartDateTextField];
  self.dateUnit = [self checkDateUnitTextField];
  if (self.startDate == nil) {
    self.startDate = [self.dateFormatter dateFromString:self.currentDateLabel.text];
  }
  return self.step != nil && self.dateUnit != nil;
}

- (void)setCurrentDate:(bool)add {
  NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
  if ([self.dateUnit isEqualToString:@"year"]) {
    [dateComponents setYear:add? 1 : -1];
  } else if ([self.dateUnit isEqualToString:@"month"]) {
    [dateComponents setMonth:add? 1 : -1];
  } else if ([self.dateUnit isEqualToString:@"week"]) {
    [dateComponents setWeekday:add? 1 : -1];
  } else if ([self.dateUnit isEqualToString:@"day"]) {
    [dateComponents setDay:add? 1 : -1];
  } else if ([self.dateUnit isEqualToString:@"hour"]) {
    [dateComponents setHour:add? 1 : -1];
  } if ([self.dateUnit isEqualToString:@"minute"]) {
    [dateComponents setMinute:add? 1 : -1];
  }
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:self.startDate options:0];
  self.currentDateLabel.text = [self.dateFormatter stringFromDate:newDate];
  self.startDateTextField.text = [self.dateFormatter stringFromDate:newDate];
  [dateComponents release];
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
  [self.view addSubview:self.dateUnitTextField];
}

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

- (NSNumber*)checkStepTextField {
  NSNumber *number = [self.numberFormatter numberFromString:self.stepTextField.text];
  if (number == nil) {
    self.stepTextField.textColor = [UIColor redColor];
    self.stepTextField.text = @"Invalid step number";
  }
  return number;
}

- (NSDate*)checkStartDateTextField {
  NSDate *date = [self.dateFormatter dateFromString:self.startDateTextField.text];
  if (date == nil) {
    self.startDateTextField.textColor = [UIColor redColor];
    self.startDateTextField.text = @"Invalid date";
  }
  return date;
}

- (NSString*)checkDateUnitTextField {
  if (![self.dateUnitValues containsObject:self.dateUnitTextField.text]) {
    self.dateUnitTextField.textColor = [UIColor redColor];
    self.dateUnitTextField.text = @"Invalid date unit";
    return nil;
  }
  return self.dateUnitTextField.text;
}

@end

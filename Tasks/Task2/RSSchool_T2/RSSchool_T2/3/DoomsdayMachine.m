#import "DoomsdayMachine.h"

@implementation DoomsdayMachine

@synthesize days;

@synthesize minutes;

@synthesize months;

@synthesize seconds;

@synthesize hours;

@synthesize weeks;

@synthesize years;

- (void)correctFormat:(NSInteger*)first :(NSInteger*)second :(NSInteger)value {
    if (*first < 0 && *second > 0) {
        (*first)++;
        *second -= value;
    } else if (*first > 0 && *second < 0) {
        (*first)--;
        *second += value;
    }
}

- (id<AssimilationInfo>)assimilationInfoForCurrentDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yy:MM:dd@ss\\mm/HH";
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSString *assimilationString = @"2208:08:14@37\\13/03";
    NSDate *assimilationDate = [dateFormatter dateFromString: assimilationString];
    NSCalendarUnit calendarUnit = NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *assimilationComponents = [[NSCalendar currentCalendar] components: calendarUnit fromDate:assimilationDate];
    NSDateComponents *components = [[NSCalendar currentCalendar] components: calendarUnit fromDate:date];
    seconds = [assimilationComponents second] - [components second];
    minutes = [assimilationComponents minute] - [components minute];
    hours = [assimilationComponents hour] - [components hour];
    days = [assimilationComponents day] - [components day];
    months = [assimilationComponents month] - [components month];
    years = [assimilationComponents year] - [components year];
    [self correctFormat:&years :&months :12];
    [self correctFormat:&months :&days :31];
    [self correctFormat:&days :&hours :24];
    [self correctFormat:&hours :&minutes :60];
    [self correctFormat:&minutes :&seconds :60];
    id<AssimilationInfo> result = self;
    [dateFormatter release];
    [date release];
    [assimilationString release];
    [assimilationDate release];
    return result;
}

/*
 In case doomsdatString method needs to be implemented in general, we can use NSCalendarUnit (with NSCalendarUnitMonth and NSCalendarUnitWeekday) to determine the day of the week and the month (using switch, for instance)
 */

- (NSString*)doomsdayString {
    return @"Sunday, August 14, 2208";
}

@end

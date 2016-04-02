//
//  ViewController.m
//  AlarmClock
//
//  Created by badman on 16/4/2.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIDatePicker *dPicker;
@property (nonatomic, strong) UITextField *EventText;
@property (nonatomic, strong) UITableView *mTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.dPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 20, screenWidth, 200)];
    self.dPicker.minimumDate = [NSDate date];
    [self.view addSubview:self.dPicker];
    
    self.EventText = [[UITextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.dPicker.frame), screenWidth, 40)];
    self.EventText.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.EventText];
    
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,100, 40)];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    self.EventText.rightView = saveButton;
    self.EventText.rightViewMode = UITextFieldViewModeAlways;
    
    self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.EventText.frame), screenWidth, screenHeight - CGRectGetMaxY(self.EventText.frame)) style:UITableViewStylePlain];
    self.mTableView.dataSource = self;
    self.mTableView.delegate = self;
    [self.view addSubview:self.mTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save:(UIButton *)sender
{
    [self.EventText resignFirstResponder];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSDate *pickerDate = [self.dPicker date];
    
    NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:pickerDate];
    
    NSDateComponents *timeComponents = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:pickerDate];
    
    // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
    
    // Notification will fire in one minute
    [dateComps setMinute:[timeComponents minute]];
    [dateComps setSecond:[timeComponents second]];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
    {
        return;
    }
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone localTimeZone];
    
    localNotif.alertBody = [self.EventText text];
    localNotif.alertAction = @"View";
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
    // Specify custom data for the notification
    NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
    [infoDic setObject:[self.EventText text] forKey:@"msg"];
    [infoDic setObject:@"alarmclock" forKey:@"sender"];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
    
    // Schedule the ontification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    [self.mTableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[UIApplication sharedApplication] scheduledLocalNotifications] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSArray *notificationArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    UILocalNotification *notification = [notificationArray objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:notification.alertBody];
    [cell.detailTextLabel setText:[notification.fireDate description]];
    return cell;
}

@end

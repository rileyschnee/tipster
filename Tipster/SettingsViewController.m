//
//  SettingsViewController.m
//  Tipster
//
//  Created by Riley Schnee on 6/26/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defControl;

@end



@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Load default percentage set by user
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double initTipPercent = [defaults doubleForKey:@"default_tip_percentage"];
    if(initTipPercent == 0.15){
        self.defControl.selectedSegmentIndex = 0;
    } else if (initTipPercent == 0.20){
        self.defControl.selectedSegmentIndex = 1;
    } else{
        self.defControl.selectedSegmentIndex = 2;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleDefControl:(id)sender {
    // Note: *, like C++, means this is a pointer
    NSArray *percentagesSetting = @[@(0.15), @(0.2), @(0.22)];
    
    double tipDefPercent = [percentagesSetting[self.defControl.selectedSegmentIndex] doubleValue];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setDouble:tipDefPercent forKey:@"default_tip_percentage"];
    [defaults synchronize];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  Tipster
//
//  Created by Riley Schnee on 6/26/18.
//  Copyright © 2018 Riley Schnee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic, assign) BOOL initEditDone;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tipster";
    // Do any additional setup after loading the view, typically from a nib.
    
    // Change color of placeholder in textbox
    [self.billField setValue:[UIColor colorWithRed:1.00 green:0.89 blue:0.03 alpha:1.0] forKeyPath:@"placeholderLabel.textColor"];
    
    // Set boolean for being the first time to edit textbox to false
    self.initEditDone = NO;
    
    // Load default percentage set by user
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double initTipPercent = [defaults doubleForKey:@"default_tip_percentage"];
    if(initTipPercent == 0.15){
        self.tipControl.selectedSegmentIndex = 0;
    } else if (initTipPercent == 0.20){
        self.tipControl.selectedSegmentIndex = 1;
    } else{
        self.tipControl.selectedSegmentIndex = 2;
    }
    [defaults synchronize];
    [self.billField becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"View will appear");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double initTipPercent = [defaults doubleForKey:@"default_tip_percentage"];
    if(initTipPercent == 0.15){
        self.tipControl.selectedSegmentIndex = 0;
    } else if (initTipPercent == 0.20){
        self.tipControl.selectedSegmentIndex = 1;
    } else{
        self.tipControl.selectedSegmentIndex = 2;
    }
    [defaults synchronize];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"View did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"View will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NSLog(@"View did disappear");
}


- (IBAction)onTap:(id)sender {
    NSLog(@"Hello");
    [self.view endEditing:YES];
}

- (IBAction)onEdit:(id)sender {
    [self calculate];
}

- (void)calculate {
    double bill = [self.billField.text doubleValue];
    
    // Note: *, like C++, means this is a pointer
    NSArray *percentages = @[@(0.15), @(0.2), @(0.22)];
    
    double tipPercentage = [percentages[self.tipControl.selectedSegmentIndex] doubleValue];
    
    double tip = tipPercentage * bill;
    double total = bill + tip;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tip];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f", total];
    
}

- (IBAction)onEditingEnd:(id)sender {
    CGRect newFrame = self.billField.frame;
    newFrame.origin.y -= 100;
    
    if (self.initEditDone == NO) {
        [UIView animateWithDuration:0.2 animations:^{
            self.billField.frame = newFrame;
            self.billField.font = [UIFont fontWithName:@"Helvetica-Light" size:70];
        }];
        self.initEditDone = YES;
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.plusLabel.alpha = 1;
        self.tipLabel.alpha = 1;
        self.totalLabel.alpha = 1;
        self.lineView.alpha = 1;
    }];
    [self calculate];

}


@end

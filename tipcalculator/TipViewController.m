//
//  TipViewController.m
//  tipcalculator
//
//  Created by Joanna Chan on 1/19/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billtextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentage;

- (IBAction)onTap:(id)sender;
- (void) updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"view did load");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self changeTip];
    [self updateValues];
}

- (void)changeTip {
    NSArray *tipValues = @[@(10), @(15), @(20)];
    if(self.tipControl.selectedSegmentIndex != 3){
        int newTip = [tipValues[self.tipControl.selectedSegmentIndex] intValue];
        self.tipPercentage.text = [NSString stringWithFormat:@"%i", newTip];
    }else{
        [self updateDefaultTip];
    }
}

- (void)updateValues {
    float billAmount = [self.billtextField.text floatValue];
    
    float defaultTip = [self.tipPercentage.text floatValue]/100;
    float tipAmount = billAmount * defaultTip;
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)updateDefaultTip {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipPercent = [defaults integerForKey:@"defaultTip"];
    
    self.tipPercentage.text = [NSString stringWithFormat:@"%i", defaultTipPercent];
    self.tipControl.selectedSegmentIndex = 3;
}

- (void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    [self updateDefaultTip];
    [self updateValues];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

@end

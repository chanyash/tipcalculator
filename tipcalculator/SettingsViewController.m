//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Joanna Chan on 1/20/15.
//  Copyright (c) 2015 yahoo. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *defaultTip;
@property (weak, nonatomic) IBOutlet UIButton *saveDefaultBtn;

- (IBAction)onTap:(id)sender;
- (void)saveDefault;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipPercent = [defaults integerForKey:@"defaultTip"];
    
    self.defaultTip.text = [NSString stringWithFormat:@"%i", defaultTipPercent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self saveDefault];
}

- (void)saveDefault {
    int newDefaultTip = [self.defaultTip.text intValue];
    self.defaultTip.text = [NSString stringWithFormat:@"%i", newDefaultTip];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:newDefaultTip forKey:@"defaultTip"];
    [defaults synchronize];
}

@end

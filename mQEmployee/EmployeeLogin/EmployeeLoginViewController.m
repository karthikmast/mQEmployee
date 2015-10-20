//
//  EmployeeLoginViewController.m
//  mQEmployee
//
//  Created by Samuha on 10/18/15.
//  Copyright © 2015 Samuha. All rights reserved.
//

#import "EmployeeLoginViewController.h"
#import <Parse/Parse.h>
#import "CashierViewController.h"
#import "OperationsViewController.h"
#import "DeliveryHomeViewController.h"

@interface EmployeeLoginViewController ()

@end

@implementation EmployeeLoginViewController

#pragma mark - VIEW LIFE CYCLE METHODS
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) viewWillAppear:(BOOL)animated
{
    self.txtUsername.text = @"";
    self.txtPassword.text = @"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - LOGIN BUTTON ACTION
- (IBAction)loginButtonAction:(id)sender
{
    [self.txtPassword resignFirstResponder];
    [self.txtUsername resignFirstResponder];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
    _HUD.delegate = self;
    _HUD.labelText = @"Loading";
    _HUD.square = YES;
    
    [_HUD show:YES];
    
    
    [PFUser logInWithUsernameInBackground:self.txtUsername.text password:self.txtPassword.text block:^(PFUser *user, NSError *error) {
        if (user)
        {
            //Open the wall
            
            PFQuery *query = [PFUser query];
            //2
            [query whereKey:@"username" equalTo:self.txtUsername.text];
            //  [query whereKey:@"CashierKey" equalTo:@"cashier"];
            [query orderByDescending:@"createdAt"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error1) {
                //3
                if (!error1)
                {
                    //Everything was correct, put the new objects and load
                    
                    
                    objectsArray = nil;
                    objectsArray = [[NSMutableArray alloc] initWithArray:objects];
                    
                    [self authenticateCashier];
                    
                }
                else
                {
                    NSString *errorString = [[error userInfo] objectForKey:@"error"];
                    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [errorAlertView show];
                    self.txtUsername.text = @"";
                    self.txtPassword.text = @"";
                    //4
                    [_HUD hide:YES];
                    
                }
            }];
        }
        else
        {
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
            self.txtUsername.text = @"";
            self.txtPassword.text = @"";
            [_HUD hide:YES];
            
            
        }
        
    }];
    
}

#pragma mark - TEXTFIELD DELEGATE METHODS

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    // [self.view setFrame:CGRectMake(0,-110,320,460)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
    
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.view.frame  = CGRectMake(0, 0, 320,460);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.view.frame  = CGRectMake(0, -110, 320,460);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.view.frame  = CGRectMake(0, -110, 320,460);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:.1 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.view.frame  = CGRectMake(0,0,320,460);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
    //[self.view setFrame:CGRectMake(0,0,320,460)];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - AUTHENTICATE USER METHOD
-(void) authenticateCashier
{
    [_HUD show:YES];
    
    if([[[objectsArray objectAtIndex:0] valueForKey:@"EmployeeKey"] isEqualToString:@"cashier"])
    {
        CashierViewController *cashierHomeVC = [[CashierViewController alloc]initWithNibName:@"CashierViewController" bundle:nil];
        [self.navigationController pushViewController:cashierHomeVC animated:YES];
        [_HUD hide:YES];
    }
    else if([[[objectsArray objectAtIndex:0] valueForKey:@"EmployeeKey"] isEqualToString:@"operations"])
    {
        
        OperationsViewController *operationsView = [[OperationsViewController alloc]initWithNibName:@"OperationsViewController" bundle:nil];
        [self.navigationController pushViewController:operationsView animated:YES];
         [_HUD hide:YES];
        
    }
    else if([[[objectsArray objectAtIndex:0] valueForKey:@"EmployeeKey"] isEqualToString:@"delivery"])
    {
        DeliveryHomeViewController *deliveryView = [[DeliveryHomeViewController alloc]initWithNibName:@"DeliveryHomeViewController" bundle:nil];
        [self.navigationController pushViewController:deliveryView animated:YES];
         [_HUD hide:YES];
    }
    else
    {
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid User!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [errorAlertView show];
        self.txtUsername.text = @"";
        self.txtPassword.text = @"";
        [_HUD hide:YES];

    
    }
    
    
}

@end

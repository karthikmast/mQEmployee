//
//  DeliveryDetailsViewController.m
//  MqEmployee
//
//  Created by Samuha on 18/10/15.
//  Copyright (c) 2015 Samuha. All rights reserved.
//

#import "DeliveryDetailsViewController.h"
#import <Parse/Parse.h>

@interface DeliveryDetailsViewController ()

@end

@implementation DeliveryDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userName:(NSString*)userName
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.userId = userName;
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self cartCheckforUser:self.userId];
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



#pragma mark - DONE BUTTON ACTION
- (IBAction)doneButtonAction:(id)sender {
}

#pragma mark - BACK BUTTON ACTION
- (IBAction)backButtonAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) cartCheckforUser:(NSString*)userID
{
    PFQuery *query = [PFQuery queryWithClassName:@"DeliverProducts"];
    [query whereKey:@"UserId" equalTo:userID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            self.cartProducts = [[NSArray alloc]initWithArray:objects];
            [self billCheckforUser:userID];
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

-(void) billCheckforUser:(NSString*)userID
{
    PFQuery *query = [PFQuery queryWithClassName:@"BillsPaid"];
    [query whereKey:@"User" equalTo:userID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            self.billProducts = [[NSArray alloc]initWithArray:objects];
            [self compareBillAndCart];
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

-(void) compareBillAndCart
{
    _cartProducts=[_cartProducts sortedArrayUsingSelector:@selector(compare:)];
    _billProducts=[_billProducts sortedArrayUsingSelector:@selector(compare:)];
    
    if ([_cartProducts isEqualToArray:_billProducts])
    {
        self.lblKartID.text = @"";
        self.lblUserID.text = @"";
        [self.viewNoKart addSubview:self.viewKartData];
        
    }
    else{
        NSLog(@"both are differnt");
    }
}
@end

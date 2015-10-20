//
//  OperationsViewController.m
//  MqEmployee
//
//  Created by Samuha on 17/10/15.
//  Copyright (c) 2015 Samuha. All rights reserved.
//

#import "OperationsViewController.h"
#include <Parse/Parse.h>

@interface OperationsViewController ()

@end

@implementation OperationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self operationsLoginUpdate];
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

#pragma mark - Done Button Action
- (IBAction)doneButtonAction:(id)sender
{
    PFQuery *query = [PFQuery queryWithClassName:@"ProductsQueue"];
    [query whereKey:@"objectId" equalTo:self.queueObjectID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
        if (!error)
        {
            [self.viewProducts removeFromSuperview];
            _lblNoProduct.hidden = NO;

            [PFObject deleteAllInBackground:objects block:^(BOOL result, NSError *error)
            {
                if(result)
                {
                    [self startTimedTask];
                }
            }];
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}
- (IBAction)logoutButtonAction:(id)sender
{
    PFQuery *query = [PFUser query];
     NSLog(@"%@",self.objectID);
    [query getObjectInBackgroundWithId:self.objectID
                                 block:^(PFObject *object, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     
                                     [object setObject:@"" forKey:@"LoginKey"];
                                     // object[@"LoginKey"] = @"LoggedIn";
                                     [object saveInBackground];
                                 }
     
     ];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void) operationsLoginUpdate
{
    PFQuery *query = [PFUser query];
   // PFObject *object = [PFUser object];
    self.objectID = [[PFUser currentUser] objectId];
    
    NSLog(@"%@",self.objectID);
    
    [query getObjectInBackgroundWithId:self.objectID
                                 block:^(PFObject *object, NSError *error) {
                                     // Now let's update it with some new data. In this case, only cheatMode and score
                                     // will get sent to the cloud. playerName hasn't changed.
                                     [self startTimedTask];
                                     [object setObject:@"LoggedIn" forKey:@"LoginKey"];
                                     // object[@"LoginKey"] = @"LoggedIn";
                                     [object saveInBackground];
                                 }
     
     ];
}

- (void)startTimedTask
{
   if(![self.viewProducts isDescendantOfView:self.viewNoProduct])
   {
       NSTimer *fiveSecondTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:YES];
   }
}

- (void)performBackgroundTask
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        PFQuery *query = [PFQuery queryWithClassName:@"ProductsQueue"];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *objects, NSError *error){
        //[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error)
            {
                // The find succeeded.
                    self.queueObjectID = [objects objectId];
                self.lblCart.text = [objects objectForKey:@"CartID"];
                self.lblQty.text = [objects objectForKey:@"ProductsQuantity"];
                self.lblProductName.text = [objects objectForKey:@"ProductDescription"] ;

                   // self.lblCart.text = [[objects objectForKey:@"CartID"] stringValue];
                   // self.lblQty.text = [[objects objectForKey:@"ProductsQuantity"] stringValue];
                    //self.lblProductName.text = [[objects objectForKey:@"ProductDescription"] stringValue];
                //Athith
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.viewNoProduct addSubview:self.viewProducts];
//                });
                _lblNoProduct.hidden = YES;
                    [self.viewNoProduct addSubview:self.viewProducts];
                
            }
            else
            {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
        
        //Do background work
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //Update UI
//        });
    });
}

@end

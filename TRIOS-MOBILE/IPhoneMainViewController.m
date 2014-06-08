//
//  IPhoneMainViewController.m
//  TRIOS-MOBILE
//
//  Created by stephen eshelman on 6/8/14.
//  Copyright (c) 2014 objectthink.com. All rights reserved.
//

#import "AppDelegate.h"
#import "IPhoneMainViewController.h"
#import "MercuryInstrument.h"

@interface IPhoneMainViewController ()
{
   MercuryInstrument* _instrument;
   MercuryAccess access;
}
@end

@implementation IPhoneMainViewController

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   return 2;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField
{
   if(self.ipAddressText == theTextField)
   {
      [self.usernameText becomeFirstResponder];
   }
   else
      [theTextField resignFirstResponder];
   
   return YES;
}

-(void)response:(NSData *)message withSequenceNumber:(uint)sequenceNumber subcommand:(uint)subcommand status:(uint)status
{
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{
   switch (row)
   {
      case 0:
         return @"Viewer";
         break;
      case 1:
         return @"Master";
         break;
   }
   return @"Viewer";
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
   switch (row) {
      case 0:
         access = Viewer;
         break;
      case 1:
         access = Master;
         break;
      default:
         access = Viewer;
         break;
   }
}

-(void)error:(NSError *)error
{
   self.errorLabel.text = [error description];
}

-(void)connected
{
   NSLog(@"connected");
   
   [_instrument
    loginWithUsername:self.usernameText.text
    machineName:@"SUPER-SECRET-IPAD"
    ipAddress:self.ipAddressText.text
    access:access];
}

-(void)accept:(MercuryAccess)accessIn
{
   NSLog(@"accept:%d",accessIn);
   
   [self performSegueWithIdentifier:@"IPhoneMainToTabSegue" sender:self];
}

-(void)stat:(NSData*)message withSubcommand:(uint)subcommand
{
   NSLog(@"stat:%d",subcommand);
}

-(void)ackWithSequenceNumber:(uint)sequencenumber
{
   NSLog(@"ack:%d",sequencenumber);
}

-(void)nakWithSequenceNumber:(uint)sequencenumber andError:(uint)errorcode
{
   NSLog(@"nak:%d [%d]",sequencenumber,errorcode);
}

-(void)response:(NSData*)message withSubcommand:(uint)subcommand
{
   NSLog(@"response:%d",subcommand);
}

- (IBAction)connectTapped:(UIButton *)sender
{
   [_instrument connectToHost:self.ipAddressText.text andPort:8080];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self)
   {
      // Custom initialization
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   // Do any additional setup after loading the view.
   
   AppDelegate* app = [[UIApplication sharedApplication] delegate];
   
   _instrument = [app instrument];
   _instrument.instrumentDelegate = self;
   
   access = Viewer;
   
   self.title = @"Main";
}

-(void)viewWillAppear:(BOOL)animated
{
   _instrument.instrumentDelegate = self;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

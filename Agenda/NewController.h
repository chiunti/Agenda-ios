//
//  NewController.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewController : UIViewController
//Navigator
@property (strong, nonatomic) IBOutlet UINavigationItem *navNew;

//Images
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;

// textEdit
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtStatus;
@property (strong, nonatomic) IBOutlet UITextField *txtSong;

// Actions
- (IBAction)bntSavePressed:(id)sender;

@end

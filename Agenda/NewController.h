//
//  NewController.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewController : UIViewController<UITextFieldDelegate>
//Navigator
@property (strong, nonatomic) IBOutlet UINavigationItem *navNew;
//ScrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//Images
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;

// textEdit
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtStatus;
@property (strong, nonatomic) IBOutlet UITextField *txtSong;
// buttons
@property (strong, nonatomic) IBOutlet UIButton *btnImage;
// Actions
- (IBAction)bntSavePressed:(id)sender;
- (IBAction)textFieldDidBeginEditing:(UITextField *)sender;

@end

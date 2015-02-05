//
//  AdquireController.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdquireController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

// Actions
- (IBAction)btnCameraPressed:(id)sender;
- (IBAction)btnReelPressed:(id)sender;

@end

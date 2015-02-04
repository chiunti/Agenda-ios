//
//  ShowMoreController.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowMoreController : UIViewController

// WebViews
@property (strong, nonatomic) IBOutlet UIWebView *wvwVideo;

//Images
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;

//Labels
@property (strong, nonatomic) IBOutlet UILabel *lblNombre;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;

@end

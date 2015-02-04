//
//  ShowController.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowController : UIViewController
// tableViews
@property (strong, nonatomic) IBOutlet UITableView *tblShow;

// Actions
- (IBAction)btnShare:(id)sender;
- (IBAction)btnMore:(id)sender;

@end

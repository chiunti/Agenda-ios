//
//  EditController.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditController : UIViewController<UITableViewDataSource,UITableViewDelegate>


// tableviews
@property (strong, nonatomic) IBOutlet UITableView *tblEdit;

//Buttons
@property (strong, nonatomic) IBOutlet UIButton *btnEliminar;
@property (strong, nonatomic) IBOutlet UIButton *btnEditar;

//Navigators
@property (strong, nonatomic) IBOutlet UINavigationItem *navEdit;

//Actions
- (IBAction)btnEliminarPressed:(id)sender;

@end

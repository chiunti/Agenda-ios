//
//  NewController.m
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "NewController.h"
#import "Defaults.h"

@implementation NewController

-(void)viewDidLoad{
    self.navNew.title = currentState==Insert?@"Alta Usuario":@"Editar Usuario";
}

@end

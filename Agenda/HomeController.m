//
//  ViewController.m
//  Agenda
//
//  Created by Chiunti on 01/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "HomeController.h"
#import "Defaults.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    currentState = Idle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAdd:(id)sender {
    currentState = Insert;
}

- (IBAction)btnDelete:(id)sender {
    currentState = Delete;
}

- (IBAction)btnEdit:(id)sender {
    currentState = Edit;
}

- (IBAction)btnShow:(id)sender {
    currentState = Show;
}
@end

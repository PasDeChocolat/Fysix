//
//  PDCViewController.m
//  Fysix
//
//  Created by Kyle Oba on 3/1/14.
//  Copyright (c) 2014 Pas de Chocolat. All rights reserved.
//

#import "PDCViewController.h"

@interface PDCViewController ()
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) IBOutlet UIView *snapView;
@property (strong, nonatomic) IBOutlet UIView *rightTargetView;
@property (strong, nonatomic) IBOutlet UIView *leftTargetView;
@property (strong, nonatomic) UISnapBehavior *rightSnapBehavior;
@property (strong, nonatomic) UISnapBehavior *leftSnapBehavior;
@end

@implementation PDCViewController

- (UISnapBehavior *)rightSnapBehavior
{
    if (!_rightSnapBehavior) {
        _rightSnapBehavior = [[UISnapBehavior alloc] initWithItem:self.snapView
                                                      snapToPoint:self.rightTargetView.center];
        _rightSnapBehavior.damping = 0.25;
    }
    return _rightSnapBehavior;
}

- (UISnapBehavior *)leftSnapBehavior
{
    if (!_leftSnapBehavior) {
        _leftSnapBehavior = [[UISnapBehavior alloc] initWithItem:self.snapView
                                                     snapToPoint:self.leftTargetView.center];
        _leftSnapBehavior.damping = 0.95;
    }
    return _leftSnapBehavior;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Add animator:
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Add snap behavior:
    [self.animator addBehavior:self.rightSnapBehavior];
}

- (IBAction)handleTapGesture:(id)sender
{
    if ([[self.animator behaviors] containsObject:self.rightSnapBehavior]) {
        [self.animator removeBehavior:self.rightSnapBehavior];
        [self.animator addBehavior:self.leftSnapBehavior];
    } else {
        [self.animator removeBehavior:self.leftSnapBehavior];
        [self.animator addBehavior:self.rightSnapBehavior];
    }
}
@end

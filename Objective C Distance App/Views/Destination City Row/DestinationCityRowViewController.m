//
//  DestinationCityRowViewController.m
//  Objective C Distance App
//
//  Created by Ari He on 8/11/21.
//

#import "DestinationCityRowViewController.h"

@implementation DestinationCityRowViewController

UITextField *destinationCityInput;
UILabel *destinationDistanceLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubviews];
    [self setUpConstraints];
}

- (void)setUpSubviews {
    destinationCityInput = [UITextField new];
    [destinationCityInput setPlaceholder:@"Enter destination city"];
    [destinationCityInput setDelegate:self];
    
    destinationDistanceLabel = [UILabel new];
    
    [self.view addSubview:destinationCityInput];
    [self.view addSubview:destinationDistanceLabel];
}

- (void)setUpConstraints {
    [destinationCityInput setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    [destinationDistanceLabel setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    
    // Input
    NSLayoutConstraint *inputLeading = [NSLayoutConstraint constraintWithItem:destinationCityInput attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *inputWidth = [NSLayoutConstraint constraintWithItem:destinationCityInput attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    NSLayoutConstraint *inputTop = [NSLayoutConstraint constraintWithItem:destinationCityInput attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *inputBottom = [NSLayoutConstraint constraintWithItem:destinationCityInput attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSArray *inputConstraints = [NSArray arrayWithObjects:inputLeading, inputWidth, inputTop, inputBottom, nil];
    [self.view addConstraints: inputConstraints];
    
    // Label
    NSLayoutConstraint *labelLeading = [NSLayoutConstraint constraintWithItem:destinationDistanceLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:destinationCityInput attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:20];
    NSLayoutConstraint *labelTrailing = [NSLayoutConstraint constraintWithItem:destinationDistanceLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:destinationDistanceLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *labelBottom = [NSLayoutConstraint constraintWithItem:destinationDistanceLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSArray *labelConstraints = [NSArray arrayWithObjects:labelLeading, labelTrailing, labelTop, labelBottom, nil];
    [self.view addConstraints: labelConstraints];
}

@end

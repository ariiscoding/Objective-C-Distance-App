//
//  DestinationCityRowViewController.m
//  Objective C Distance App
//
//  Created by Ari He on 8/11/21.
//

#import "DestinationCityRowViewController.h"

@interface DestinationCityRowViewController ()

// MARK: These are private instance variables.

@property (nonatomic) UITextField *destinationCityInput;
@property (nonatomic) UILabel *destinationDistanceLabel;

@end

@implementation DestinationCityRowViewController

// MARK: This is a class variable, NOT an instance variable.
NSObject *object;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpSubviews];
    [self setUpConstraints];
    
    if (object == nil) {
        object = [NSObject new];
    }
    
    [self report];
}


- (void)report {
    NSLog(@"This is object %@, property 1: %@, property 2: %@, object: %@", self, _destinationCityInput, _destinationDistanceLabel, object);
}

- (void)setUpSubviews {
    _destinationCityInput = [UITextField new];
    [_destinationCityInput setPlaceholder:@"Enter destination city"];
    [_destinationCityInput setDelegate:self];
    
    _destinationDistanceLabel = [UILabel new];
    
    [self.view addSubview:_destinationCityInput];
    [self.view addSubview:_destinationDistanceLabel];
}

- (void)setUpConstraints {
    [_destinationCityInput setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    [_destinationDistanceLabel setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    
    // Input
    NSLayoutConstraint *inputLeading = [NSLayoutConstraint constraintWithItem:_destinationCityInput attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *inputWidth = [NSLayoutConstraint constraintWithItem:_destinationCityInput attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    NSLayoutConstraint *inputTop = [NSLayoutConstraint constraintWithItem:_destinationCityInput attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *inputBottom = [NSLayoutConstraint constraintWithItem:_destinationCityInput attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSArray *inputConstraints = [NSArray arrayWithObjects:inputLeading, inputWidth, inputTop, inputBottom, nil];
    [self.view addConstraints: inputConstraints];
    
    // Label
    NSLayoutConstraint *labelLeading = [NSLayoutConstraint constraintWithItem:_destinationDistanceLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:_destinationCityInput attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:20];
    NSLayoutConstraint *labelTrailing = [NSLayoutConstraint constraintWithItem:_destinationDistanceLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:_destinationDistanceLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *labelBottom = [NSLayoutConstraint constraintWithItem:_destinationDistanceLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    NSArray *labelConstraints = [NSArray arrayWithObjects:labelLeading, labelTrailing, labelTop, labelBottom, nil];
    [self.view addConstraints: labelConstraints];
}

- (NSString*)getDestinationCity {
    return _destinationCityInput.text;
}

- (BOOL)isDestinationCityEmpty {
    return [[self getDestinationCity] isEqualToString:@""];
}

- (void)setDistanceLabel:(NSString *)text {
    [_destinationDistanceLabel setText:text];
}

@end

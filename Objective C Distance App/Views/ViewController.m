//
//  ViewController.m
//  Objective C Distance App
//
//  Created by Ari He on 8/11/21.
//

#import "ViewController.h"
#import "DestinationCityRowViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// MARK: Properties

UITextField *originCityInput;
UIButton *updateButton;
UIStackView *inputStack;

DestinationCityRowViewController *destination1;
DestinationCityRowViewController *destination2;


// MARK: Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    [self setUpViews];
    [self setUpConstraints];
}


// MARK: View Setup

- (void)setUpViews {
    [self setUpInputStack];
    [self setUpDestinationRows];
}

- (void)setUpInputStack {
    originCityInput = [UITextField new];
    [originCityInput setPlaceholder:@"Enter origin city"];
    
    updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [updateButton setTitle:@"Update" forState:UIControlStateNormal];
    
    inputStack = [UIStackView new];
    [inputStack setAxis:UILayoutConstraintAxisHorizontal];
    [inputStack setUserInteractionEnabled:TRUE];
    [inputStack setDistribution:UIStackViewDistributionFill];
    
    [inputStack addArrangedSubview:originCityInput];
    [inputStack addArrangedSubview:updateButton];
    
    [updateButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.view addSubview:inputStack];
}

- (void)setUpDestinationRows {
    destination1 = [DestinationCityRowViewController new];
    destination2 = [DestinationCityRowViewController new];
    
    [self.view addSubview:destination1.view];
    [self.view addSubview:destination2.view];
}


// MARK: Constraints

- (void)setUpConstraints {
    [self setUpInputStackConstraint];
    [self setUpDestinationRowConstraints];
}

- (void)setUpInputStackConstraint {
    [inputStack setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    
    // Top
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:inputStack attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.00 constant:100];
    
    // Leading
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:inputStack attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30];
    
    // Trailing
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:inputStack attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-30];
    
    // Activation
    NSArray *constraints = [NSArray arrayWithObjects:top, leading, trailing, nil];
    [self.view addConstraints: constraints];
}

- (void)setUpConstraintForDestinationRow: (DestinationCityRowViewController*)row top: (UIView*)topView {
    [row.view setTranslatesAutoresizingMaskIntoConstraints:FALSE];
    
    // Top
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:row.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:30];
    
    // Height
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:row.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
    
    // Leading
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:row.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:30];
    
    // Trailing
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:row.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-30];
    
    // Activation
    NSArray *constraints = [NSArray arrayWithObjects:top, leading, trailing, height, nil];
    [self.view addConstraints: constraints];
    
}

- (void)setUpDestinationRowConstraints {
    [self setUpConstraintForDestinationRow:destination1 top:inputStack];
    [self setUpConstraintForDestinationRow:destination2 top:destination1.view];
}


@end

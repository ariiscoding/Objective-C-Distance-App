//
//  DestinationCityRowViewController.h
//  Objective C Distance App
//
//  Created by Ari He on 8/11/21.
//

#ifndef DestinationCityRowViewController_h
#define DestinationCityRowViewController_h

#import <UIKit/UIKit.h>

@interface DestinationCityRowViewController : UIViewController <UITextFieldDelegate>

- (NSString*)getDestinationCity;

- (BOOL)isDestinationCityEmpty;

- (void)setDistanceLabel:(NSString*)text;

@end


#endif /* DestinationCityRowViewController_h */

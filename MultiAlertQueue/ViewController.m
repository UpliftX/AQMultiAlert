/* Copyright 2016 UpliftX
 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 
 * http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "ViewController.h"
#import "AQAlertAction.h"
#import "AQAlertQueue.h"

@interface ViewController ()

@end

@implementation ViewController

static int alertNumber = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(showAlert)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)showAlert {
    UIAlertController *alertController = [ViewController createAlertControllerWithTitle:[NSString stringWithFormat:@"Alert %d", alertNumber++]
                                                                                message:@"Test message"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
    [[AQAlertQueue sharedAlertQueue] showAlert:alertController animated:YES completion:nil onViewController:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIAlertController *)createAlertControllerWithTitle:(NSString *)title
                                              message:(NSString *)message
                                       preferredStyle:(UIAlertControllerStyle)preferredStyle {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:title
                                          message:message
                                          preferredStyle:preferredStyle];
    
    AQAlertAction *okAction = [AQAlertAction
                                  actionWithTitleForQueued:@"OK"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action)
                                  {
                                      // add action code here
                                  }];
    
    [alertController addAction:okAction];
    return alertController;
}

@end

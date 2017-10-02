//
//  ViewController.m
//  HockeyLeague
//
//  Created by Larivière, Maxime on 17-09-14.
//  Copyright © 2017 Larivière, Maxime, Croteau, Samuel, Laroche, Samuel, Pérami, Kian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)NewGameButton:(UIButton *)sender;
- (IBAction)ChangePeriod:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *teamA;
@property (weak, nonatomic) IBOutlet UILabel *teamB;

@property (weak, nonatomic) IBOutlet UILabel *playerA1;
@property (weak, nonatomic) IBOutlet UILabel *playerA2;
@property (weak, nonatomic) IBOutlet UILabel *playerA3;
@property (weak, nonatomic) IBOutlet UILabel *playerA4;
@property (weak, nonatomic) IBOutlet UILabel *playerA5;
@property (weak, nonatomic) IBOutlet UILabel *playerB1;
@property (weak, nonatomic) IBOutlet UILabel *playerB2;
@property (weak, nonatomic) IBOutlet UILabel *playerB3;
@property (weak, nonatomic) IBOutlet UILabel *playerB4;
@property (weak, nonatomic) IBOutlet UILabel *playerB5;

@property (weak, nonatomic) IBOutlet UILabel *period;

@end

@implementation ViewController

int periodCounter = 1;

NSMutableArray<NSString *> *teamAarray;
NSMutableArray<NSString *> *teamBarray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)NewGameButton:(UIButton *)sender {
    NSString *title = @"Équipe Maison";
    NSString *message = @"Veuillez entrer le nom et numéro des joueur de l'équipe\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
    UIAlertController *setTeamA = [UIAlertController
                                alertControllerWithTitle: title
                                message: message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    UITextField *teamNameATextField = [[UITextField alloc] init];;
    NSMutableArray<UITextField *> *numberATextFields = [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
    NSMutableArray<UITextField *> *firstNameATextFields = [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
    NSMutableArray<UITextField *> *lastNameATextFields= [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
    
    [self addTeam:setTeamA :teamNameATextField :numberATextFields :firstNameATextFields :lastNameATextFields];
    
    [setTeamA addAction:
     [UIAlertAction actionWithTitle:@"OK"
      style:UIAlertActionStyleDefault
      handler:^(UIAlertAction *action) {
          
          NSMutableArray<UILabel *> *playerALabels = [[NSMutableArray<UILabel *> alloc] initWithCapacity:5];
          playerALabels[0] = _playerA1;
          playerALabels[1] = _playerA2;
          playerALabels[2] = _playerA3;
          playerALabels[3] = _playerA4;
          playerALabels[4] = _playerA5;
          
          for (int i = 0 ; i < 5; i++) {
              teamAarray[i] = [NSString stringWithFormat:@"%@, %@, %@", numberATextFields[i].text, firstNameATextFields[i].text, lastNameATextFields[i].text];
              playerALabels[i].text = [NSString stringWithFormat:@"%@, %@, %@", numberATextFields[i].text, firstNameATextFields[i].text, lastNameATextFields[i].text];
          }
          
          _teamA.text = [NSString stringWithFormat:@"Équipe %@", teamNameATextField.text];
          
          NSString *title = @"Équipe Visiteur";
          NSString *message = @"Veuillez entrer le nom et numéro des joueur de l'équipe\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
          UIAlertController *setTeamB = [UIAlertController
                                         alertControllerWithTitle: title
                                         message: message
                                         preferredStyle:UIAlertControllerStyleAlert];
          
          UITextField *teamNameBTextField = [[UITextField alloc] init];;
          NSMutableArray<UITextField *> *numberBTextFields = [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
          NSMutableArray<UITextField *> *firstNameBTextFields = [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
          NSMutableArray<UITextField *> *lastNameBTextFields= [[NSMutableArray<UITextField *> alloc] initWithCapacity:5];
          
          [self addTeam:setTeamB :teamNameBTextField :numberBTextFields :firstNameBTextFields :lastNameBTextFields];
          
          [setTeamB addAction:
           [UIAlertAction actionWithTitle:@"OK"
            style:UIAlertActionStyleDefault
            handler:^(UIAlertAction *action) {
                NSMutableArray<UILabel *> *playerBLabels = [[NSMutableArray<UILabel *> alloc] initWithCapacity:5];
                playerBLabels[0] = _playerB1;
                playerBLabels[1] = _playerB2;
                playerBLabels[2] = _playerB3;
                playerBLabels[3] = _playerB4;
                playerBLabels[4] = _playerB5;
                
                for (int i = 0 ; i < 5; i++) {
                    teamBarray[i] = [NSString stringWithFormat:@"%@, %@, %@", numberBTextFields[i].text, firstNameBTextFields[i].text, lastNameBTextFields[i].text];
                    playerBLabels[i].text = [NSString stringWithFormat:@"%@, %@, %@", numberBTextFields[i].text, firstNameBTextFields[i].text, lastNameBTextFields[i].text];
                }
                
                _teamB.text = [NSString stringWithFormat:@"Équipe %@", teamNameBTextField.text];
                
          }]];
          [self presentViewController:setTeamB animated:YES completion:nil];
      }]];
    [self presentViewController:setTeamA animated:YES completion:nil];
}

- (IBAction)ChangePeriod:(UIButton *)sender {
    int nextPeriod = periodCounter + 1;
    int scoreA = 2;
    int scoreB = 1;
    NSString *message = @"";
    if (nextPeriod >= 4) {
        message = @"finir la partie";
    } else {
        message = [NSString stringWithFormat:@"passer à la période %i", nextPeriod];
    }
    UIAlertController *areYouSure = [UIAlertController
                                     alertControllerWithTitle: @"Changer de période"
                                     message: [NSString stringWithFormat:@"Êtes-vous sûr de vouloir %@", message]
                                     preferredStyle:UIAlertControllerStyleAlert];
    [areYouSure addAction:[UIAlertAction
                         actionWithTitle:@"Oui"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction *action) {
                             periodCounter ++;
                             _period.text = [NSString stringWithFormat:@"Période : %i", periodCounter];
                             if (nextPeriod + 1 >= 4) {
                                 [sender setTitle:@"fin de partie" forState:UIControlStateNormal];
                             }
                             if (nextPeriod == 4) {
                                 _ChangerPeriodButton.enabled = NO;
                                 NSString *endGameMessage = @"";
                                 if (scoreA < scoreB) {
                                     endGameMessage = [NSString stringWithFormat:@"%@ a gagné!", _teamB.text];
                                 } else if (scoreA > scoreB) {
                                     endGameMessage = [NSString stringWithFormat:@"%@ a gagné!", _teamA.text];
                                 } else {
                                     endGameMessage = @"C'est une partie null!";
                                 }
                                 UIAlertController *endGame = [UIAlertController
                                                               alertControllerWithTitle: @"Fin de partie"
                                                               message: endGameMessage
                                                               preferredStyle:UIAlertControllerStyleAlert];
                                 [endGame addAction:[UIAlertAction
                                                      actionWithTitle:@"OK"
                                                      style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {}]];
                                 [self presentViewController:endGame animated:YES completion:nil];
                             }

    }]];
    
    [areYouSure addAction:[UIAlertAction
                           actionWithTitle:@"Non"
                           style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action) {
                               
    }]];
    
    [self presentViewController:areYouSure animated:YES completion:nil];
    
}

- (void)resetGame {
    _teamA.text = @"ÉquiepA";
    _teamA.text = @"ÉquiepB";
    
    _playerA1.text = @"";
    _playerA2.text = @"";
    _playerA3.text = @"";
    _playerA4.text = @"";
    _playerA5.text = @"";
    
    _playerB1.text = @"";
    _playerB2.text = @"";
    _playerB3.text = @"";
    _playerB4.text = @"";
    _playerB5.text = @"";
}

- (void) addTeam:(UIAlertController *) controller
                :(UITextField *) teamNameTextField
                :(NSMutableArray<UITextField *> *) numberTextFields
                :(NSMutableArray<UITextField *> *) firstNameTextFields
                :(NSMutableArray<UITextField *> *) lastNameTextFields {
    controller.modalInPopover = true;
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, 300, 300)];
    
    UILabel *teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 200, 25)];
    teamLabel.text = @"Équipe";
    
    teamNameTextField.frame = CGRectMake(6, 25, 256, 25);
    teamNameTextField.placeholder = @"Nom de l'équipe";
    teamNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    teamNameTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    [inputView addSubview:teamLabel];
    [inputView addSubview:teamNameTextField];
    
    for (int i = 0; i < 5; i++) {
        UILabel *playerLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 50+i*50, 200, 25)];
        playerLabel.text = [NSString stringWithFormat:@"Joueur %i", (i+1)];
        
        UITextField *numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(6, 75+i*50, 50, 25)];
        numberTextField.placeholder = @"#";
        numberTextField.borderStyle = UITextBorderStyleRoundedRect;
        numberTextField.keyboardType = UIKeyboardTypeDecimalPad;
        numberTextFields[i] = numberTextField;
        
        UITextField *firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(62, 75+i*50, 97, 25)];
        firstNameTextField.placeholder = @"Prénom";
        firstNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        firstNameTextField.keyboardType = UIKeyboardTypeDecimalPad;
        firstNameTextFields[i] = firstNameTextField;
        
        UITextField *lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(165, 75+i*50, 97, 25)];
        lastNameTextField.placeholder = @"Nom";
        lastNameTextField.borderStyle = UITextBorderStyleRoundedRect;
        lastNameTextField.keyboardType = UIKeyboardTypeDecimalPad;
        lastNameTextFields[i] = lastNameTextField;
        
        [inputView addSubview:playerLabel];
        [inputView addSubview:numberTextFields[i]];
        [inputView addSubview:firstNameTextFields[i]];
        [inputView addSubview:lastNameTextFields[i]];
    }
    
    [controller.view addSubview:inputView];
}
@end


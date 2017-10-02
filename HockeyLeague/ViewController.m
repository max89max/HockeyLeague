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
- (IBAction)AddGoalButton:(UIButton *)sender;

- (IBAction)ChangeÉquipeGoal:(UITextField *)sender;
- (IBAction)ChangeMarqueurGoal:(UITextField *)sender;
- (IBAction)ChangePasse1Goal:(UITextField *)sender;
- (IBAction)ChangePasse2Goal:(UITextField *)sender;

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


@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *ÉquipeGoalField;
@property (weak, nonatomic) IBOutlet UITextField *MarqueurGoalField;
@property (weak, nonatomic) IBOutlet UITextField *Passe1GoalField;
@property (weak, nonatomic) IBOutlet UITextField *Passe2GoalField;
@property (weak, nonatomic) IBOutlet UITableView *LogTableView;

@end

@implementation ViewController

int periodCounter = 1;

NSMutableArray<NSString *> *teamAarray;
NSMutableArray<NSString *> *teamBarray;

NSMutableArray<NSString*>* addGoalArray;
NSMutableArray<NSMutableString*>* goalLogArray;
UITextField* currentSelectedTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    teamAarray = [[NSMutableArray alloc] init];
    teamBarray = [[NSMutableArray alloc] init];
    addGoalArray = [[NSMutableArray alloc] init];
    goalLogArray = [[NSMutableArray alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)NewGameButton:(UIButton *)sender {
    teamAarray = [[NSMutableArray alloc] init];
    teamBarray = [[NSMutableArray alloc] init];
    addGoalArray = [[NSMutableArray alloc] init];
    goalLogArray = [[NSMutableArray alloc] init];
    
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
              [teamAarray addObject: [NSString stringWithFormat:@"%@, %@, %@", numberATextFields[i].text, firstNameATextFields[i].text, lastNameATextFields[i].text]];
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
                    [teamBarray addObject: [NSString stringWithFormat:@"%@, %@, %@", numberBTextFields[i].text, firstNameBTextFields[i].text, lastNameBTextFields[i].text]];
                    playerBLabels[i].text = [NSString stringWithFormat:@"%@, %@, %@", numberBTextFields[i].text, firstNameBTextFields[i].text, lastNameBTextFields[i].text];
                }
                
                _teamB.text = [NSString stringWithFormat:@"Équipe %@", teamNameBTextField.text];
                
          }]];
          [self presentViewController:setTeamB animated:YES completion:nil];
      }]];
    [self presentViewController:setTeamA animated:YES completion:nil];
    
    _ÉquipeGoalField.enabled = YES;
    _MarqueurGoalField.enabled = YES;
    _Passe1GoalField.enabled = YES;
    _Passe2GoalField.enabled = YES;
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
    
    _ÉquipeGoalField.text = @"";
    _MarqueurGoalField.text = @"";
    _Passe1GoalField.text = @"";
    _Passe2GoalField.text = @"";
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

- (void)showPickerView{
    _picker.delegate = self;
    _picker.dataSource = self;
    _pickerView.alpha = 1;
    currentSelectedTextField.userInteractionEnabled = NO;
    [currentSelectedTextField resignFirstResponder];
    [_picker reloadAllComponents];
}
- (void)hidePickerView{
    _pickerView.alpha = 0;
    currentSelectedTextField.userInteractionEnabled = YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;  // Or return whatever as you intend
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return [addGoalArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return addGoalArray[row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    currentSelectedTextField.text = addGoalArray[row];
    [self hidePickerView];
    
}

- (IBAction)ChangeÉquipeGoal:(UITextField *)sender {
    currentSelectedTextField = sender;
    [addGoalArray addObject:_teamA.text];
    [addGoalArray addObject:_teamB.text];
    [self showPickerView];
 }
 
- (IBAction)ChangeMarqueurGoal:(UITextField *)sender {
     currentSelectedTextField = sender;
     if(_ÉquipeGoalField.text == _teamA.text)
     {
         addGoalArray = teamAarray;
     }
     else
     {
         addGoalArray = teamBarray;
     }
     [self showPickerView];
}
 
- (IBAction)ChangePasse1Goal:(UITextField *)sender {
     currentSelectedTextField = sender;
     if(_ÉquipeGoalField.text == _teamA.text)
     {
         addGoalArray = teamAarray;
     }
     else
     {
         addGoalArray = teamBarray;
     }
     [self showPickerView];
}
 
- (IBAction)ChangePasse2Goal:(UITextField *)sender {
     currentSelectedTextField = sender;
     if(_ÉquipeGoalField.text == _teamA.text)
     {
         addGoalArray = teamAarray;
     }
     else
     {
         addGoalArray = teamBarray;
     }
     [self showPickerView];
}


- (IBAction)AddGoalButton:(UIButton *)sender {
    NSMutableString *goalLog = [NSMutableString stringWithString:@""];
    
    NSString* periode = [NSString stringWithFormat:@"%i", periodCounter];
    [goalLog appendString:periode];
    NSString* team = _ÉquipeGoalField.text;
    [goalLog appendString:team];
    NSString* scorer = [_MarqueurGoalField.text componentsSeparatedByString:@" "][0];
    [goalLog appendString:scorer];
    NSString* assist1 = [_Passe1GoalField.text componentsSeparatedByString:@" "][0];
    [goalLog appendString:assist1];
    NSString* assist2 = [_Passe2GoalField.text componentsSeparatedByString:@" "][0];
    [goalLog appendString:assist2];
    [goalLogArray addObject:goalLog];
    
    _ÉquipeGoalField.text = @"";
    _MarqueurGoalField.text = @"";
    _Passe1GoalField.text = @"";
    _Passe2GoalField.text = @"";
    
    [_LogTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [_LogTableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [goalLogArray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"TableView";
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    cell.goalLogLabel.text = [goalLogArray objectAtIndex:(NSUInteger)indexPath];
    return cell;
}
@end


Class {
	#name : #GtPharoTemplateParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoTemplateParser class >> ambiguousTransitions [
^#(
#[ 0 42 1 21] 
#[ 1 14 1 21] 
#[ 1 21 1 130] 
#[ 0 206 1 222] 
#[ 0 206 1 234]
	).
]

{ #category : #'generated-accessing' }
GtPharoTemplateParser class >> cacheId [
	^'2021-04-13T11:22:29.29752+02:00'
]

{ #category : #generated }
GtPharoTemplateParser class >> definitionComment [
"%glr;
%prefix GtPharo;
%suffix Node;
%root Program;
%start Method MethodSequence Statement MethodPattern Template;
%id <bar> <binary>;
%hierarchy Value (
	Array
	Assignment
	Block
	Cascade
	Error
	Literal
	MessageSend
	Variable
	Template
);
%hierarchy Literal (StringLiteral NumberLiteral CharacterLiteral SymbolLiteral ArrayLiteral BooleanLiteral NilLiteral);
%hierarchy ArrayLiteral (ByteArrayLiteral);
%hierarchy Message (UnaryMessage BinaryMessage KeywordMessage);
%hierarchy Sequence (MethodSequence);
%hierarchy Pragma (PragmaError);
%hierarchy Block (BlockError);
%hierarchy MethodPattern (ErrorPattern);
%ignore_variables leftParen rightParen leftBar rightBar leftBracket rightBracket semicolon colon period ;


%id <number> <negativeNumber> <binary> <bar> <name> <keyword> <nameAssignment>;
%hierarchy Variable (SelfVariable SuperVariable ThisContextVariable NamedVariable);

default literalArray <true>
	: true
	;
default literalArray <false>
	: false
	;
default literalArray <nil>
	: nil
	;
default literalArray <name>
	:  (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;
default <nameAssignment>
	: <name> \:\=
	;
default <bar>
	: \|
	;
default literalArray <string>
	: ( \' [^\']* \' )+
	;
default literalArray <symbol>
	: \#{1,2} ( <name> (\:\: <name>)* | <binary> | <keyword>+ | <string> )
	;
default literalArray <character>
	: \$ .
	;
default literalArray <number>
	: \d+
	;
default literalArray <negativeNumber>
	: \- <number>
	;
literalArray <literalArrayKeyword>
	: <keyword>+
	;
default <return>
	: \^
	;
default <lt>
	: \<
	;
default <gt>
	: \>
	;
default <leftBrace>
	: \{
	;
default literalArray <leftBracket>
	: \[
	;
default <colon>
	: \:
	;
default literalArray <leftParen>
	: \(
	;
default literalArray <literalArrayStart>
	: \#\(
	;
default literalArray <byteArrayStart>
	: \#\[
	;
default literalArray <rightParen>
	: \)
	;
default literalArray <rightBracket>
	: \]
	;
default <rightBrace>
	: \}
	;
literalArray <selector>
	: (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	| ((<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) * \:)+
	;
default <keyword>
	: <name> \:
	;
default literalArray <binary>
	: [\~\-\!\@\%\&\*\+\=\\\|\?\/\>\<\,] +
	;
default literalArray <semicolon>
	: \;
	;
default <assign>
	: \: \=
	;
default literalArray <period>
	: \.
	;
default literalArray <comment>
	: \"" [^\""]* \""
	;
default literalArray <whitespace>
	: (\s | \x0)+
	;
<patternToken>
	: (\`  [^\`]* \`)+
	;
default literalArray <self>
	: self
	;
default literalArray <super>
	: super
	;
default literalArray <thisContext>
	: thisContext
	;
default <doubleLeftBrace>
	: \{\{
	;
default <doubleRightBrace>
	: \}\}
	;
Method
	: MethodPattern 'pattern' MethodSequence 'body' {{}}
	;
MethodPattern
	: <name> 'selectorPart' {{}}
	| <binary> 'selectorPart' Variable 'variable' {{}}
	| KeywordPattern {{}}
	| <binary> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| <keyword> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| (<keyword> 'selectorPart' Variable 'variable')+ <keyword> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	;
Pragmas
	: Pragma 'pragma'+
	;
Pragma
	:  <lt> 'lessThan' <name> 'selectorPart' <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' (<keyword> 'selectorPart' (Literal 'value' | Variable 'value'))+ <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' error 'smaccError' {{PragmaError}}
	| <lt> 'lessThan' error 'smaccError' <gt> 'greaterThan' {{PragmaError}}
	;
KeywordPattern
	: (<keyword> 'selectorPart' Variable 'variable')+
	;
MethodSequence
	: Pragmas Temporaries Pragmas <period> 'period'* Statements? {{}}
	| Temporaries Pragmas <period> 'period'* Statements? {{}}
	| Pragmas Temporaries? <period> 'period'* Statements? {{}}
	| Sequence
	;
Sequence
	: Temporaries? <period> 'period'* Statements? {{}}
	;
Temporaries
	:  <bar> 'leftBar' Variable 'variable'* <bar> 'rightBar'
	;
Statements
	: StatementList <period> 'period'+?
	;
StatementList
	: Statement 'statement'
	| StatementList <period> 'period'+ Statement 'statement'
	;
Statement
	: <return> 'upArrow' Assignment 'value' {{Return}}
	| Assignment
	;
Assignment
	: Variable 'variable' <assign> 'assignmentToken' Assignment 'value' {{}}
	| Template 'variable' <assign> 'assignmentToken' Assignment 'value' {{}}
	| Variable 'variable' <assign> 'assignmentToken' Template 'value' {{}}
	| Template 'variable' <assign> 'assignmentToken' Template 'value' {{}}
	| Template
	| Cascade
	;
Cascade
	: KeywordMessageSendVars CascadedMessages {{}}
	| BinaryMessageSendVars CascadedMessages {{}}
	| UnaryMessageSendVars CascadedMessages {{}}
	| KeywordMessageSend
	;
CascadedMessages
	: (<semicolon> 'semicolon' CascadedMessage 'message')+
	;
CascadedMessage
	: KeywordMessage
	| BinaryMessage
	| UnaryMessage
	;
KeywordMessageSend
	: KeywordMessageSendVars {{MessageSend}}
	| BinaryMessageSend
	;
KeywordMessageSendVars
	: BinaryMessageSend 'receiver' KeywordMessage 'message' 
	;
KeywordMessage
	: (<keyword> 'selectorPart' BinaryMessageSend 'value')+ {{}}
	;
BinaryMessageSend
	: BinaryMessageSendVars {{MessageSend}}
	| UnaryMessageSend
	;
BinaryMessageSendVars
	: BinaryMessageSend 'receiver' BinaryMessage 'message' 
	;
BinaryMessage
	: <binary> 'selectorPart' UnaryMessageSend 'value' {{}}
	;
UnaryMessageSend
	: UnaryMessageSendVars {{MessageSend}}
	| Value
	;
UnaryMessageSendVars
	: UnaryMessageSend 'receiver' UnaryMessage 'message' 
	;
UnaryMessage
	: <name> 'selectorPart' {{}}
	;
Variable
	: SelfVariable
	| SuperVariable
	| ThisContextVariable
	| NamedVariable
	;
Value
	: Variable
	| Literal
	| Array
	| Block
	| <leftParen> 'leftParen' Assignment <rightParen> 'rightParen' {{Value}}
	| error 'smaccError' {{Error}}
	;
Array
	: <leftBrace> 'leftBrace' (Assignment 'value' (<period> 'period' Assignment 'value')*)? <period> 'period'? <rightBrace> 'rightBrace' {{}}
	;
Block
	: <leftBracket> 'leftBracket' BlockArgs Sequence 'body' <rightBracket> 'rightBracket' {{}}
	| <leftBracket> 'leftBracket' (<colon> 'colon' Variable 'variable')+ <rightBracket> 'rightBracket' {{}}
	| <leftBracket> 'leftBracket' BlockArgs Sequence 'body' error 'smaccError' {{BlockError}}
	;
BlockArgs
	: 
	| (<colon> 'colon' Variable 'variable')+ <bar> 'bar'
	;
Literal
	: StringLiteral
	| NumberLiteral
	| ArrayLiteral
	| ByteArrayLiteral
	| CharacterLiteral
	| SymbolLiteral
	| BooleanLiteral
	| NilLiteral
	;
StringLiteral
	: <string> 'value' {{}}
	;
NumberLiteral
	: <number> 'value' {{}}
	| <negativeNumber> 'value' {{}}
	;
ArrayLiteral
	: SwitchToLiteralArray <literalArrayStart> 'arrayStart' ArrayLiteralValue 'value'* EndLiteralArray <rightParen> 'arrayStop' {{}}
	;
ArrayLiteralValue
	: Literal
	| <literalArrayKeyword> 'value' {{SymbolLiteral}}
	| <name> 'value' {{SymbolLiteral}}
	| <binary> 'value' {{SymbolLiteral}}
	| <period> 'value' {{SymbolLiteral}}
	| <semicolon> 'value' {{SymbolLiteral}}
	| <leftParen> 'arrayStart' ArrayLiteralValue 'value'* <rightParen> 'arrayStop' {{ArrayLiteral}}
	| error 'smaccError' {{Error}}
	;
ByteArrayLiteral
	: <byteArrayStart> 'arrayStart' ByteArrayLiteralValue 'value'* <rightBracket> 'arrayStop' {{}}
	;
ByteArrayLiteralValue
	: NumberLiteral
	| error 'smaccError' {{Error}}
	;
CharacterLiteral
	: <character> 'value' {{}}
	;
SymbolLiteral
	: <symbol> 'value' {{}}
	;
BooleanLiteral
	: <true> 'value' {{}}
	| <false> 'value' {{}}
	;
NilLiteral
	: <nil> 'value' {{}}
	;
SwitchToLiteralArray
	: {self scope: #literalArray. #array}
	;
EndLiteralArray
	: {self endLiteralArray. nil}
	;
SelfVariable
	: <self> 'name' {{}}
	;
SuperVariable
	: <super> 'name' {{}}
	;
NamedVariable
	: <name> 'name' {{}}
	;
ThisContextVariable
	: <thisContext> 'name' {{}}
	;
Template
	: <doubleLeftBrace> 'leftBraces' Assignment 'expression' <doubleRightBrace>'rightBraces' {{}}
	;"
]

{ #category : #generated }
GtPharoTemplateParser class >> reduceTable [
^#(
	#(50 0 #reduceActionFor_period___period__1: 3607553 false ) 
	#(97 0 #reduceActionForSwitchToLiteralArray1: 7481345 false ) 
	#(40 1 #reduceActionForMethodPattern1: 2769921 false ) 
	#(42 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3024897 false ) 
	#(48 1 #reduceActionForKeywordPattern1: 3489793 false ) 
	#(40 1 #reduceActionForMethodPattern3: 2769923 false ) 
	#(53 0 #reduceActionFor_period___period__1: 3879937 false ) 
	#(43 1 #reduceActionForKeywordPattern1: 3139585 false ) 
	#(44 1 #reduceActionForPragma__pragma__1: 3150849 false ) 
	#(51 1 #reduceActionForSequence1: 3781633 false ) 
	#(49 1 #liftFirstValue: 3560457 false ) 
	#(95 1 #reduceActionForBooleanLiteral1: 7377921 false ) 
	#(95 1 #reduceActionForBooleanLiteral1: 7377922 false ) 
	#(96 1 #reduceActionForNilLiteral1: 7444481 false ) 
	#(101 1 #reduceActionForNamedVariable1: 7676929 false ) 
	#(85 1 #reduceActionForStringLiteral1: 6448129 false ) 
	#(94 1 #reduceActionForSymbolLiteral1: 7334913 false ) 
	#(93 1 #reduceActionForCharacterLiteral1: 7285761 false ) 
	#(86 1 #reduceActionForNumberLiteral1: 6491137 false ) 
	#(86 1 #reduceActionForNumberLiteral1: 6491138 false ) 
	#(83 0 #reduceActionForBlockArgs1: 6221825 false ) 
	#(91 0 #reduceActionFor_period___period__1: 7142401 false ) 
	#(99 1 #reduceActionForSelfVariable1: 7597057 false ) 
	#(100 1 #reduceActionForSuperVariable1: 7635969 false ) 
	#(102 1 #reduceActionForThisContextVariable1: 7716865 false ) 
	#(57 1 #liftFirstValue: 4076546 false ) 
	#(58 1 #liftFirstValue: 4157446 false ) 
	#(59 1 #liftFirstValue: 4494340 false ) 
	#(64 1 #reduceActionForKeywordMessageSend1: 4822017 false ) 
	#(64 1 #liftFirstValue: 4822018 false ) 
	#(69 1 #reduceActionForKeywordMessageSend1: 5076993 false ) 
	#(69 1 #liftFirstValue: 5076994 false ) 
	#(72 1 #reduceActionForKeywordMessageSend1: 5320705 false ) 
	#(76 1 #liftFirstValue: 5606401 false ) 
	#(72 1 #liftFirstValue: 5320706 false ) 
	#(76 1 #liftFirstValue: 5606403 false ) 
	#(76 1 #liftFirstValue: 5606404 false ) 
	#(76 1 #liftFirstValue: 5606402 false ) 
	#(84 1 #liftFirstValue: 6294529 false ) 
	#(84 1 #liftFirstValue: 6294530 false ) 
	#(84 1 #liftFirstValue: 6294531 false ) 
	#(84 1 #liftFirstValue: 6294532 false ) 
	#(84 1 #liftFirstValue: 6294533 false ) 
	#(84 1 #liftFirstValue: 6294534 false ) 
	#(84 1 #liftFirstValue: 6294535 false ) 
	#(84 1 #liftFirstValue: 6294536 false ) 
	#(75 1 #liftFirstValue: 5519361 false ) 
	#(75 1 #liftFirstValue: 5519362 false ) 
	#(75 1 #liftFirstValue: 5519364 false ) 
	#(75 1 #liftFirstValue: 5519363 false ) 
	#(58 1 #liftFirstValue: 4157445 false ) 
	#(76 1 #reduceActionForValue6: 5606406 false ) 
	#(41 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3024897 false ) 
	#(40 2 #reduceActionForMethodPattern5: 2769925 false ) 
	#(40 2 #reduceActionForMethodPattern2: 2769922 false ) 
	#(40 2 #reduceActionForMethodPattern5: 2769924 false ) 
	#(39 2 #reduceActionForMethod1: 2704385 false ) 
	#(42 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3024898 false ) 
	#(47 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3265537 false ) 
	#(45 2 #reduceActionForPragma3: 3171331 false ) 
	#(49 2 #reduceActionForMethodSequence5: 3560453 false ) 
	#(44 2 #reduceActionForPragma__pragma__2: 3150850 false ) 
	#(50 2 #reduceActionForPragma__pragma__2: 3607554 false ) 
	#(51 2 #reduceActionForSequence2: 3781634 false ) 
	#(54 1 #reduceActionForKeywordPattern1: 3921921 false ) 
	#(56 1 #reduceActionForStatementList1: 3974145 false ) 
	#(51 2 #reduceActionForSequence3: 3781635 false ) 
	#(57 2 #reduceActionForStatement1: 4076545 false ) 
	#(77 2 #reduceActionForArray1: 5766145 false ) 
	#(79 0 #reduceActionFor__period___period__Assignment__value___1: 5820417 false ) 
	#(82 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 6049793 false ) 
	#(59 2 #reduceActionForCascade1: 4494337 false ) 
	#(62 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4692993 false ) 
	#(60 1 #reduceActionForKeywordPattern1: 4672513 false ) 
	#(65 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4909057 false ) 
	#(68 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5013505 false ) 
	#(66 1 #reduceActionForKeywordMessage1: 4995073 false ) 
	#(70 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5160961 false ) 
	#(59 2 #reduceActionForCascade1: 4494338 false ) 
	#(74 1 #reduceActionForUnaryMessage1: 5472257 false ) 
	#(73 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5391361 false ) 
	#(59 2 #reduceActionForCascade1: 4494339 false ) 
	#(88 0 #reduceActionFor_period___period__1: 6639617 false ) 
	#(40 3 #reduceActionForMethodPattern6: 2769926 false ) 
	#(52 3 #reduceActionForTemporaries1: 3847169 false ) 
	#(53 2 #reduceActionForPragma__pragma__2: 3879938 false ) 
	#(45 3 #reduceActionForPragma1: 3171329 false ) 
	#(46 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3265538 false ) 
	#(46 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3265537 false ) 
	#(45 3 #reduceActionForPragma2: 3171330 false ) 
	#(47 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3265538 false ) 
	#(45 3 #reduceActionForPragma4: 3171332 false ) 
	#(49 3 #reduceActionForMethodSequence6: 3560454 false ) 
	#(49 3 #reduceActionForMethodSequence7: 3560455 false ) 
	#(55 1 #reduceActionForPragma__pragma__1: 3950593 false ) 
	#(54 2 #reduceActionForStatements2: 3921922 false ) 
	#(49 3 #reduceActionForMethodSequence3: 3560451 false ) 
	#(51 3 #reduceActionForSequence4: 3781636 false ) 
	#(77 3 #reduceActionForArray2: 5766146 false ) 
	#(81 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 6049793 false ) 
	#(83 2 #reduceActionForBlockArgs2: 6221826 false ) 
	#(80 3 #reduceActionForBlock2: 5917698 false ) 
	#(82 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 6049794 false ) 
	#(76 3 #reduceActionForValue5: 5606405 false ) 
	#(90 3 #reduceActionForByteArrayLiteral1: 7091201 false ) 
	#(92 1 #liftFirstValue: 7209985 false ) 
	#(91 2 #reduceActionForPragma__pragma__2: 7142402 false ) 
	#(92 1 #reduceActionForValue6: 7209986 false ) 
	#(103 3 #reduceActionForTemplate1: 7770113 false ) 
	#(61 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4692993 false ) 
	#(63 1 #liftFirstValue: 4750337 false ) 
	#(63 1 #liftFirstValue: 4750338 false ) 
	#(63 1 #liftFirstValue: 4750339 false ) 
	#(62 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4692994 false ) 
	#(67 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5013505 false ) 
	#(71 2 #reduceActionForBinaryMessage1: 5244929 false ) 
	#(68 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5013506 false ) 
	#(58 3 #reduceActionForAssignment1: 4157441 false ) 
	#(58 3 #reduceActionForAssignment1: 4157443 false ) 
	#(98 0 #reduceActionForEndLiteralArray1: 7545857 false ) 
	#(58 3 #reduceActionForAssignment1: 4157442 false ) 
	#(58 3 #reduceActionForAssignment1: 4157444 false ) 
	#(49 4 #reduceActionForMethodSequence1: 3560449 false ) 
	#(49 4 #reduceActionForMethodSequence8: 3560456 false ) 
	#(55 2 #reduceActionForPragma__pragma__2: 3950594 false ) 
	#(56 3 #reduceActionForStatementList2: 3974146 false ) 
	#(49 4 #reduceActionForMethodSequence4: 3560452 false ) 
	#(77 4 #reduceActionForArray3: 5766147 false ) 
	#(79 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5820418 false ) 
	#(80 4 #reduceActionForBlock1: 5917697 false ) 
	#(80 4 #reduceActionForBlock3: 5917699 false ) 
	#(89 1 #reduceActionForSymbolLiteral1: 6717443 false ) 
	#(89 1 #reduceActionForSymbolLiteral1: 6717442 false ) 
	#(89 1 #reduceActionForSymbolLiteral1: 6717444 false ) 
	#(89 1 #reduceActionForSymbolLiteral1: 6717446 false ) 
	#(89 1 #reduceActionForSymbolLiteral1: 6717445 false ) 
	#(89 1 #liftFirstValue: 6717441 false ) 
	#(88 2 #reduceActionForPragma__pragma__2: 6639618 false ) 
	#(89 1 #reduceActionForValue6: 6717448 false ) 
	#(49 5 #reduceActionForMethodSequence2: 3560450 false ) 
	#(77 5 #reduceActionForArray4: 5766148 false ) 
	#(78 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5820417 false ) 
	#(87 5 #reduceActionForArrayLiteral1: 6567937 false ) 
	#(89 3 #reduceActionForArrayLiteralValue7: 6717447 false )
	).
]

{ #category : #generated }
GtPharoTemplateParser class >> scannerClass [
	^GtPharoTemplateScanner
]

{ #category : #generated }
GtPharoTemplateParser class >> startingStateForMethod [
	^ 1
]

{ #category : #generated }
GtPharoTemplateParser class >> startingStateForMethodPattern [
	^ 4
]

{ #category : #generated }
GtPharoTemplateParser class >> startingStateForMethodSequence [
	^ 2
]

{ #category : #generated }
GtPharoTemplateParser class >> startingStateForStatement [
	^ 3
]

{ #category : #generated }
GtPharoTemplateParser class >> startingStateForTemplate [
	^ 5
]

{ #category : #generated }
GtPharoTemplateParser class >> symbolNames [
	^ #('<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<symbol>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' '<self>' '<super>' '<thisContext>' '<doubleLeftBrace>' '<doubleRightBrace>' 'B e g i n' 'Method' 'MethodPattern' '(<keyword> ''selectorPart'' Variable ''variable'')' '(<keyword> ''selectorPart'' Variable ''variable'')+' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(<keyword> ''selectorPart'' (Literal ''value'' | Variable ''value''))' '(<keyword> ''selectorPart'' (Literal ''value'' | Variable ''value''))+' 'KeywordPattern' 'MethodSequence' '<period> ''period''*' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' '<period> ''period''+' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'Variable' 'Value' 'Array' '(<period> ''period'' Assignment ''value'')' '(<period> ''period'' Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' 'SelfVariable' 'SuperVariable' 'NamedVariable' 'ThisContextVariable' 'Template' 'E O F' 'error')
]

{ #category : #generated }
GtPharoTemplateParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoVariableNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #GtPharoSelfVariableNode #GtPharoSuperVariableNode #GtPharoNamedVariableNode #GtPharoThisContextVariableNode #GtPharoTemplateNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoTemplateParser class >> transitionTable [
^#(
#[1 0 25 0 4 0 29 0 25 0 33 0 26 0 37 0 39 0 41 0 40 0 45 0 41 0 49 0 42 0 53 0 48] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 57 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 61 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 0 65 0 43 0 69 0 44 0 73 0 45 0 77 0 49 0 81 0 50 0 77 0 51 0 89 0 52 0 6 0 104 0 6 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 129 0 13 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 165 0 57 0 165 0 58 0 165 0 59 0 165 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 21 0 105] 
#[1 0 25 0 4 0 29 0 25 0 33 0 26 1 25 0 40 0 45 0 41 0 49 0 42 0 53 0 48] 
#[1 0 161 0 36 1 29 0 103] 
#[0 0 14 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[1 0 105 0 4 0 149 0 33 0 153 0 34 0 157 0 35 1 33 0 75 1 33 0 99 1 33 0 100 1 33 0 101 1 33 0 102 1 37 0 105] 
#[1 0 105 0 4 0 149 0 33 0 153 0 34 0 157 0 35 1 41 0 75 1 41 0 99 1 41 0 100 1 41 0 101 1 41 0 102 1 45 0 105] 
#[0 0 0 0 104] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 57 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 61 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 0 65 0 43 0 69 0 44 0 73 0 45 1 49 0 49 0 81 0 50 1 49 0 51 0 89 0 52 0 6 0 104 0 6 0 105] 
#[0 0 18 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[1 0 22 0 1 0 22 0 2 0 22 0 3 0 22 0 4 0 22 0 6 0 22 0 7 0 22 0 8 0 22 0 9 0 22 0 10 0 22 0 11 0 22 0 13 0 22 0 14 0 22 0 16 0 22 0 17 0 22 0 19 0 22 0 20 0 22 0 21 1 53 0 25 0 22 0 29 0 22 0 33 0 22 0 34 0 22 0 35 0 22 0 36 1 57 0 41 0 22 0 104 0 22 0 105] 
#[0 0 26 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[1 0 30 0 4 0 30 0 6 0 30 0 33 0 30 0 34 0 30 0 35 1 61 0 53] 
#[1 1 65 0 4 1 69 0 25 1 73 0 46 1 77 0 47 1 81 0 105] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 57 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 1 85 0 50 1 89 0 52 0 6 0 104 0 6 0 105] 
#[1 0 34 0 1 0 34 0 2 0 34 0 3 0 34 0 4 0 34 0 6 0 34 0 7 0 34 0 8 0 34 0 9 0 34 0 10 0 34 0 11 0 34 0 13 0 61 0 14 0 34 0 16 0 34 0 17 0 34 0 19 0 34 0 20 0 34 0 21 0 34 0 29 0 34 0 33 0 34 0 34 0 34 0 35 0 34 0 36 1 93 0 45 0 34 0 104 0 34 0 105] 
#[0 0 38 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 0 0 0 104] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 129 0 13 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 42 0 23 1 97 0 29 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 1 101 0 54 1 105 0 56 1 109 0 57 1 109 0 58 1 109 0 59 1 109 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 0 42 0 104 0 7 0 105] 
#[0 0 46 0 104] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 61 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 1 113 0 43 0 69 0 44 0 73 0 45 1 117 0 50 0 6 0 104 0 6 0 105] 
#[0 0 50 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 54 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 58 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 62 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 36 0 37 0 104 0 105] 
#[0 0 66 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 70 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 74 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 78 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 82 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 1 121 0 58 1 121 0 59 1 121 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 21 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 1 125 0 24 1 129 0 29 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 1 133 0 58 1 133 0 59 1 133 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 21 0 105] 
#[1 0 86 0 1 0 86 0 2 0 86 0 3 0 86 0 4 0 86 0 6 0 86 0 7 0 86 0 8 0 86 0 9 0 86 0 10 0 86 0 11 0 86 0 13 0 86 0 16 0 86 0 17 1 137 0 18 0 86 0 19 0 86 0 20 0 86 0 21 0 86 0 23 0 86 0 29 0 86 0 33 0 86 0 34 0 86 0 35 0 86 0 36 1 141 0 81 1 145 0 82 1 149 0 83 0 86 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 1 153 0 58 1 153 0 59 1 153 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 21 0 105] 
#[1 0 90 0 10 0 90 0 11 0 90 0 23 1 157 0 91 0 90 0 105] 
#[0 0 94 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 36 0 37 0 104 0 105] 
#[0 0 98 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 36 0 37 0 104 0 105] 
#[0 0 102 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 36 0 37 0 104 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 1 161 0 58 1 161 0 59 1 161 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 21 0 105] 
#[0 0 0 0 104] 
#[0 0 106 0 23 0 29 0 104 0 105] 
#[0 0 110 0 22 0 23 0 24 0 29 0 37 0 104 0 105] 
#[0 0 114 0 22 0 23 0 24 0 29 0 37 0 104 0 105] 
#[1 0 118 0 22 0 118 0 23 0 118 0 24 1 165 0 27 0 118 0 29 0 118 0 37 1 169 0 60 1 173 0 61 1 177 0 62 0 118 0 104 0 118 0 105] 
#[1 0 122 0 22 0 122 0 23 0 122 0 24 1 181 0 25 1 185 0 26 0 122 0 29 0 122 0 37 1 189 0 66 1 193 0 67 1 197 0 68 1 201 0 71 0 122 0 104 0 122 0 105] 
#[1 0 126 0 22 0 126 0 23 0 126 0 24 0 126 0 25 0 126 0 26 1 165 0 27 0 126 0 29 0 126 0 37 1 205 0 60 1 173 0 61 1 177 0 62 0 126 0 104 0 126 0 105] 
#[1 1 209 0 4 0 130 0 22 0 130 0 23 0 130 0 24 0 130 0 25 0 130 0 26 0 130 0 27 0 130 0 29 0 130 0 37 1 213 0 74 0 130 0 104 0 130 0 105] 
#[1 0 134 0 4 0 134 0 22 0 134 0 23 0 134 0 24 0 134 0 25 0 134 0 26 1 165 0 27 0 134 0 29 0 134 0 37 1 217 0 60 1 173 0 61 1 177 0 62 0 134 0 104 0 134 0 105] 
#[1 0 138 0 4 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 25 0 138 0 26 1 221 0 28 0 138 0 29 0 138 0 37 0 138 0 104 0 138 0 105] 
#[0 0 142 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 146 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 150 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 154 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 158 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 162 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 166 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 170 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 174 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 178 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 182 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 186 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 1 225 0 20] 
#[0 0 190 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 36 0 37 0 104 0 105] 
#[0 0 194 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 36 0 37 0 104 0 105] 
#[0 0 198 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 36 0 37 0 104 0 105] 
#[0 0 202 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 33 0 34 0 35 0 36 0 37 0 104 0 105] 
#[1 0 206 0 22 0 206 0 23 0 206 0 24 1 229 0 28 0 206 0 29 0 206 0 37 0 206 0 104 0 206 0 105] 
#[0 0 210 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 0 0 104] 
#[0 0 0 0 104] 
#[0 0 214 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 0 218 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 0 222 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 0 226 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 0 230 0 104] 
#[1 0 105 0 4 0 149 0 33 0 153 0 34 0 157 0 35 1 33 0 75 1 33 0 99 1 33 0 100 1 33 0 101 1 33 0 102 1 233 0 105] 
#[0 0 234 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[1 0 105 0 4 1 237 0 6 0 149 0 33 0 153 0 34 0 157 0 35 1 241 0 75 1 241 0 99 1 241 0 100 1 241 0 101 1 241 0 102] 
#[0 1 245 0 15] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 1 249 0 75 1 253 0 84 1 253 0 85 1 253 0 86 1 253 0 87 1 253 0 90 1 253 0 93 1 253 0 94 1 253 0 95 1 253 0 96 0 253 0 97 1 249 0 99 1 249 0 100 1 249 0 101 1 249 0 102] 
#[0 0 238 0 15 0 25] 
#[1 2 1 0 15 1 69 0 25 2 5 0 46] 
#[1 0 242 0 1 0 242 0 2 0 242 0 3 0 242 0 4 0 242 0 6 0 242 0 7 0 242 0 8 0 242 0 9 0 242 0 10 0 242 0 11 0 242 0 13 0 242 0 14 2 9 0 15 0 242 0 16 0 242 0 17 0 242 0 19 0 242 0 20 0 242 0 21 0 242 0 29 0 242 0 33 0 242 0 34 0 242 0 35 0 242 0 36 0 242 0 104 0 242 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 129 0 13 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 1 97 0 29 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 13 0 54 1 105 0 56 1 109 0 57 1 109 0 58 1 109 0 59 1 109 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 0 246 0 104 1 21 0 105] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 61 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 2 17 0 43 0 69 0 44 0 73 0 45 2 21 0 50 0 6 0 104 0 6 0 105] 
#[0 0 250 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 0 254 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 1 2 0 23 0 104 0 105] 
#[1 1 6 0 23 2 25 0 29 2 29 0 55 1 6 0 104 1 6 0 105] 
#[0 1 10 0 23 0 29 0 104 0 105] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 2 33 0 50 0 6 0 104 0 6 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 129 0 13 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 1 14 0 23 1 97 0 29 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 37 0 54 1 105 0 56 1 109 0 57 1 109 0 58 1 109 0 59 1 109 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 14 0 104 0 11 0 105] 
#[0 1 18 0 23 0 29 0 104 0 105] 
#[0 1 22 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 2 41 0 24] 
#[1 1 26 0 24 1 26 0 29 2 45 0 79] 
#[1 0 105 0 4 0 149 0 33 0 153 0 34 0 157 0 35 2 49 0 75 2 49 0 99 2 49 0 100 2 49 0 101 2 49 0 102] 
#[0 1 30 0 6 0 18 0 23] 
#[1 2 53 0 6 1 137 0 18 2 57 0 23 2 61 0 81] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 57 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 0 81 0 50 2 65 0 51 2 69 0 52 0 6 0 105] 
#[0 2 73 0 22] 
#[1 0 121 0 10 0 125 0 11 2 77 0 23 2 85 0 86 2 85 0 92 2 89 0 105] 
#[0 2 93 0 37] 
#[1 1 209 0 4 1 181 0 25 1 185 0 26 2 97 0 63 2 97 0 66 1 193 0 67 1 197 0 68 2 97 0 71 2 97 0 74] 
#[0 1 34 0 22 0 23 0 24 0 29 0 37 0 104 0 105] 
#[0 1 38 0 22 0 23 0 24 0 27 0 29 0 37 0 104 0 105] 
#[1 1 42 0 22 1 42 0 23 1 42 0 24 1 165 0 27 1 42 0 29 1 42 0 37 2 113 0 61 1 42 0 104 1 42 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 2 117 0 69 2 121 0 70 0 193 0 72 2 125 0 73 0 193 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 193 0 99 0 193 0 100 0 193 0 101 0 193 0 102 1 21 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 2 133 0 72 2 125 0 73 2 133 0 75 2 133 0 76 2 133 0 77 2 133 0 80 2 133 0 84 2 133 0 85 2 133 0 86 2 133 0 87 2 133 0 90 2 133 0 93 2 133 0 94 2 133 0 95 2 133 0 96 0 253 0 97 2 133 0 99 2 133 0 100 2 133 0 101 2 133 0 102 1 21 0 105] 
#[0 1 46 0 22 0 23 0 24 0 27 0 29 0 37 0 104 0 105] 
#[0 1 50 0 22 0 23 0 24 0 25 0 27 0 29 0 37 0 104 0 105] 
#[1 1 54 0 22 1 54 0 23 1 54 0 24 1 181 0 25 1 54 0 27 1 54 0 29 1 54 0 37 2 137 0 67 1 54 0 104 1 54 0 105] 
#[0 1 58 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 1 62 0 22 0 23 0 24 0 29 0 37 0 104 0 105] 
#[0 1 66 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 1 70 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 1 74 0 22 0 23 0 24 0 29 0 37 0 104 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 141 0 58 2 141 0 59 2 141 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 2 145 0 103 1 21 0 105] 
#[1 1 78 0 1 1 78 0 2 1 78 0 3 1 78 0 4 1 78 0 7 1 78 0 8 1 78 0 9 1 78 0 10 1 78 0 11 1 78 0 12 1 78 0 19 1 78 0 20 1 78 0 21 1 78 0 22 1 78 0 26 1 78 0 27 1 78 0 29 2 149 0 88 1 78 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 153 0 58 2 153 0 59 2 153 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 2 157 0 103 1 21 0 105] 
#[0 1 82 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 1 86 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 1 90 0 4 0 6 0 33 0 34 0 35] 
#[0 1 94 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 1 98 0 15 0 25] 
#[0 1 102 0 15 0 25] 
#[0 1 106 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 1 110 0 15 0 25] 
#[0 1 114 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 1 118 0 104] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 2 161 0 50 0 6 0 104 0 6 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 129 0 13 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 1 97 0 29 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 165 0 54 1 105 0 56 1 109 0 57 1 109 0 58 1 109 0 59 1 109 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 122 0 104 1 21 0 105] 
#[0 1 126 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 129 0 13 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 1 130 0 23 2 169 0 29 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 173 0 57 2 173 0 58 2 173 0 59 2 173 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 130 0 104 0 15 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 129 0 13 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 1 97 0 29 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 177 0 54 1 105 0 56 1 109 0 57 1 109 0 58 1 109 0 59 1 109 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 134 0 104 1 21 0 105] 
#[0 1 138 0 23 0 104 0 105] 
#[0 1 142 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[1 2 181 0 24 2 185 0 29 2 189 0 78] 
#[0 1 146 0 6 0 18 0 23] 
#[0 1 150 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 36 0 105] 
#[0 1 154 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 1 158 0 6 0 18 0 23] 
#[1 2 193 0 23 2 197 0 105] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 29 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 36 1 117 0 50 0 6 0 105] 
#[0 1 162 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 1 166 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 1 170 0 10 0 11 0 23 0 105] 
#[0 1 174 0 10 0 11 0 23 0 105] 
#[0 1 178 0 10 0 11 0 23 0 105] 
#[0 1 182 0 22 0 23 0 24 0 28 0 29 0 37 0 104 0 105] 
#[0 1 186 0 22 0 23 0 24 0 27 0 29 0 37 0 104 0 105] 
#[0 1 190 0 22 0 23 0 24 0 27 0 29 0 37 0 104 0 105] 
#[0 1 194 0 22 0 23 0 24 0 27 0 29 0 37 0 104 0 105] 
#[0 1 198 0 22 0 23 0 24 0 27 0 29 0 37 0 104 0 105] 
#[0 1 202 0 22 0 23 0 24 0 27 0 29 0 37 0 104 0 105] 
#[1 1 206 0 22 1 206 0 23 1 206 0 24 1 206 0 25 1 185 0 26 1 206 0 27 1 206 0 29 1 206 0 37 1 201 0 71 1 206 0 104 1 206 0 105] 
#[0 0 126 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 134 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 0 138 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[1 1 209 0 4 1 210 0 22 1 210 0 23 1 210 0 24 1 210 0 25 1 210 0 26 1 210 0 27 1 210 0 29 1 210 0 37 1 213 0 74 1 210 0 104 1 210 0 105] 
#[0 1 214 0 22 0 23 0 24 0 25 0 27 0 29 0 37 0 104 0 105] 
#[0 1 218 0 22 0 23 0 24 0 29 0 37 0 104 0 105] 
#[1 0 19 0 22 0 19 0 23 0 19 0 24 1 229 0 28 0 19 0 29 0 19 0 37 0 19 0 104 0 19 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 2 201 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 2 205 0 12 2 209 0 19 0 10 0 20 0 145 0 21 1 226 0 22 2 213 0 26 2 217 0 27 2 221 0 29 2 229 0 84 2 229 0 85 2 229 0 86 2 229 0 87 2 229 0 89 2 229 0 90 2 229 0 93 2 229 0 94 2 229 0 95 2 229 0 96 0 253 0 97 2 233 0 98 2 237 0 105] 
#[0 1 230 0 22 0 23 0 24 0 29 0 37 0 104 0 105] 
#[1 0 23 0 22 0 23 0 23 0 23 0 24 1 229 0 28 0 23 0 29 0 23 0 37 0 23 0 104 0 23 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 129 0 13 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 1 97 0 29 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 241 0 54 1 105 0 56 1 109 0 57 1 109 0 58 1 109 0 59 1 109 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 238 0 104 1 21 0 105] 
#[0 1 242 0 104] 
#[0 1 246 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 33 0 34 0 35 0 36 0 104 0 105] 
#[0 1 250 0 23 0 29 0 104 0 105] 
#[0 1 254 0 104] 
#[0 2 2 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 0 133 0 16 0 137 0 17 0 141 0 19 0 10 0 20 0 145 0 21 2 245 0 24 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 2 249 0 58 2 249 0 59 2 249 0 64 0 181 0 65 0 185 0 69 0 189 0 70 0 193 0 72 0 197 0 73 0 201 0 75 0 193 0 76 0 193 0 77 0 193 0 80 0 193 0 84 0 193 0 85 0 193 0 86 0 193 0 87 0 193 0 90 0 193 0 93 0 193 0 94 0 193 0 95 0 193 0 96 0 253 0 97 0 201 0 99 0 201 0 100 0 201 0 101 0 201 0 102 1 17 0 103 1 21 0 105] 
#[0 2 6 0 24 0 29] 
#[0 2 10 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 2 14 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 2 18 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105] 
#[0 2 22 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105] 
#[1 1 78 0 1 1 78 0 2 1 78 0 3 1 78 0 4 1 78 0 7 1 78 0 8 1 78 0 9 1 78 0 10 1 78 0 11 1 78 0 12 1 78 0 19 1 78 0 20 1 78 0 21 1 78 0 22 1 78 0 26 1 78 0 27 1 78 0 29 2 253 0 88 1 78 0 105] 
#[0 2 26 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105] 
#[0 2 30 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105] 
#[0 2 34 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105] 
#[0 2 38 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105] 
#[0 2 42 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105] 
#[0 3 1 0 22] 
#[0 2 46 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105] 
#[0 2 50 0 104] 
#[0 2 54 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 2 58 0 24 0 29] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 2 201 0 4 0 109 0 7 0 113 0 8 0 117 0 9 0 121 0 10 0 125 0 11 2 205 0 12 2 209 0 19 0 10 0 20 0 145 0 21 3 5 0 22 2 213 0 26 2 217 0 27 2 221 0 29 2 229 0 84 2 229 0 85 2 229 0 86 2 229 0 87 2 229 0 89 2 229 0 90 2 229 0 93 2 229 0 94 2 229 0 95 2 229 0 96 0 253 0 97 2 237 0 105] 
#[0 2 62 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 37 0 104 0 105] 
#[0 2 66 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 105]
	).
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArray1: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result rightBrace: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArray2: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addToken: (nodes at: 2) to: result periods.
	result rightBrace: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArray3: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addNode: (nodes at: 2) to: result values.
	result addTokens: ((nodes at: 3) at: 1) to: result periods.
	result addNodes: ((nodes at: 3) at: 2) to: result values.
	result rightBrace: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArray4: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addNode: (nodes at: 2) to: result values.
	result addTokens: ((nodes at: 3) at: 1) to: result periods.
	result addNodes: ((nodes at: 3) at: 2) to: result values.
	result addToken: (nodes at: 4) to: result periods.
	result rightBrace: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArrayLiteral1: nodes [
	| result |
	result := GtPharoArrayLiteralNode new.
	result arrayStart: (nodes at: 2).
	result addNodes: (nodes at: 3) to: result values.
	result arrayStop: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArrayLiteralValue7: nodes [
	| result |
	result := GtPharoArrayLiteralNode new.
	result arrayStart: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result values.
	result arrayStop: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForAssignment1: nodes [
	| result |
	result := GtPharoAssignmentNode new.
	result variable: (nodes at: 1).
	result assignmentToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBinaryMessage1: nodes [
	| result |
	result := GtPharoBinaryMessageNode new.
	result selectorPart: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock1: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 3).
	result rightBracket: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock2: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBracket: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock3: nodes [
	| result |
	result := GtPharoBlockErrorNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 3).
	result smaccError: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlockArgs1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlockArgs2: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 1) at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBooleanLiteral1: nodes [
	| result |
	result := GtPharoBooleanLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForByteArrayLiteral1: nodes [
	| result |
	result := GtPharoByteArrayLiteralNode new.
	result arrayStart: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result values.
	result arrayStop: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForCascade1: nodes [
	| result |
	result := GtPharoCascadeNode new.
	result receiver: ((nodes at: 1) at: 1).
	result addNode: ((nodes at: 1) at: 2) to: result messages.
	result addTokens: ((nodes at: 2) at: 1) to: result semicolons.
	result addNodes: ((nodes at: 2) at: 2) to: result messages.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForCharacterLiteral1: nodes [
	| result |
	result := GtPharoCharacterLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForEndLiteralArray1: nodes [
	self endLiteralArray.
	^ nil
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForKeywordMessage1: nodes [
	| result |
	result := GtPharoKeywordMessageNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result values.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForKeywordMessageSend1: nodes [
	| result |
	result := GtPharoMessageSendNode new.
	result receiver: ((nodes at: 1) at: 1).
	result message: ((nodes at: 1) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForKeywordPattern1: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethod1: nodes [
	| result |
	result := GtPharoMethodNode new.
	result pattern: (nodes at: 1).
	result body: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern1: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern2: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern3: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern5: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern6: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addToken: (nodes at: 2) to: result selectorParts.
	result smaccError: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence1: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	result addTokens: (nodes at: 4) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence2: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	result addTokens: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addTokens: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence3: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	result addTokens: (nodes at: 3) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence4: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	result addTokens: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addTokens: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence5: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addTokens: (nodes at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence6: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addTokens: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addTokens: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence7: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addTokens: (nodes at: 3) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence8: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addTokens: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addTokens: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForNamedVariable1: nodes [
	| result |
	result := GtPharoNamedVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForNilLiteral1: nodes [
	| result |
	result := GtPharoNilLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForNumberLiteral1: nodes [
	| result |
	result := GtPharoNumberLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma1: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addToken: (nodes at: 2) to: result selectorParts.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma2: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 2) to: result values.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma3: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma4: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma__pragma__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma__pragma__2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSelfVariable1: nodes [
	| result |
	result := GtPharoSelfVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence1: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addTokens: (nodes at: 1) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence2: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addTokens: (nodes at: 1) to: result periods.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addTokens: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence3: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addTokens: (nodes at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence4: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addTokens: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addTokens: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatement1: nodes [
	| result |
	result := GtPharoReturnNode new.
	result upArrow: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatementList1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatementList2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatements2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStringLiteral1: nodes [
	| result |
	result := GtPharoStringLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSuperVariable1: nodes [
	| result |
	result := GtPharoSuperVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSwitchToLiteralArray1: nodes [
	self scope: #literalArray.
	^ #array
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSymbolLiteral1: nodes [
	| result |
	result := GtPharoSymbolLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForTemplate1: nodes [
	| result |
	result := GtPharoTemplateNode new.
	result leftBraces: (nodes at: 1).
	result expression: (nodes at: 2).
	result rightBraces: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForTemporaries1: nodes [
	| result |
	result := Array new: 3.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self addAll: (nodes at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForThisContextVariable1: nodes [
	| result |
	result := GtPharoThisContextVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForUnaryMessage1: nodes [
	| result |
	result := GtPharoUnaryMessageNode new.
	result selectorPart: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForValue5: nodes [
	| result |
	result := nodes at: 2.
	result addFirstToken: (nodes at: 1) to: result leftParens.
	result addToken: (nodes at: 3) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForValue6: nodes [
	| result |
	result := GtPharoErrorNode new.
	result smaccError: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__keyword___selectorPart__Variable__variable__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__keyword___selectorPart__Variable__variable___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__keyword___selectorPart__Variable__variable___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__period___period__Assignment__value___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor_period___period__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

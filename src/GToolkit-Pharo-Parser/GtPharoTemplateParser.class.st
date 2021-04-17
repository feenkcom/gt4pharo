Class {
	#name : #GtPharoTemplateParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoTemplateParser class >> ambiguousTransitions [
^#(
#[ 0 14 0 18] 
#[ 0 22 0 133] 
#[ 0 22 0 177] 
#[ 0 22 0 181] 
#[ 0 22 0 185] 
#[ 0 22 0 37] 
#[ 0 38 1 109] 
#[ 0 37 0 38] 
#[ 0 42 0 46] 
#[ 0 66 1 57] 
#[ 0 37 0 146] 
#[ 0 37 0 154] 
#[ 0 230 0 234 0 238] 
#[ 0 230 0 234 0 238 0 242] 
#[ 0 230 2 77] 
#[ 0 230 1 14] 
#[ 0 86 2 101] 
#[ 0 6 2 149] 
#[ 1 57 1 78] 
#[ 0 37 1 130] 
#[ 0 230 0 234] 
#[ 0 246 1 198] 
#[ 1 57 1 230] 
#[ 1 138 1 154] 
#[ 0 37 2 50] 
#[ 0 230 0 234 0 238 0 242 2 74] 
#[ 0 230 0 234 0 238 0 242 2 86] 
#[ 0 6 2 98]
	).
]

{ #category : #'generated-accessing' }
GtPharoTemplateParser class >> cacheId [
	^'2021-04-17T18:44:50.415416+02:00'
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
default literalArray <space>
	: (\s | \x0)+
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
<symbolHash>
	: \#{1,2}
	;
Method
	: MethodPattern 'pattern' MethodSequence 'body' {{}}
	;
MethodPattern
	: <name> 'selectorPart' {{}}
	| Template 'selectorPart' {{}}
	| <binary>'selectorPart' Variable 'variable' {{}}
	| <binary>'selectorPart' Template 'variable' {{}}
	| KeywordPattern {{}}
	| <binary> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| <keyword> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| (<keyword> 'selectorPart' Variable 'variable')+ <keyword> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	;
Pragmas
	: Pragma 'pragma'+
	;
Pragma
	:  <lt> 'lessThan' (<name> 'selectorPart' | TemplateName 'selectorPart') <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' (<keyword> 'selectorPart' (Literal 'value' | Variable 'value' | TemplateName 'value'))+ <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' error 'smaccError' {{PragmaError}}
	| <lt> 'lessThan' error 'smaccError' <gt> 'greaterThan' {{PragmaError}}
	;
KeywordPattern
	: (TemplateKeyword 'selectorPart' <space>? Variable 'variable')+
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
	| StatementList <period> 'period'* Template 'statement'
	| StatementList <period> 'period'* Template 'statement' <period> 'period'* Statement 'statement'
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
	| (TemplatePattern 'selectorPart' BinaryMessageSend 'value')+ {{}}
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
	| Template
	;
UnaryMessageSendVars
	: UnaryMessageSend 'receiver' UnaryMessage 'message' 
	;
UnaryMessage
	: <name> 'selectorPart' {{}}
	| Template 'selectorPart'
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
	: TemplateSymbol 'value' {{}}
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
	: TemplateName 'name' {{}}
	;
ThisContextVariable
	: <thisContext> 'name' {{}}
	;
Template
	: <doubleLeftBrace> 'leftBraces' Assignment 'expression' <doubleRightBrace>'rightBraces' {{}}
	;
TemplatePattern
	: Template <colon>
	| Template
	;
TemplateName
	: <name>
	| Template
	;
TemplateSymbol
	: <symbol>
	| Template
	| <symbolHash>Template
	;
TemplateKeyword
	# TemplateKeyword should be used implace of <keyword> in the normal pharo parser
	: <keyword>
	| (<name> | Template)+<colon>
	;"
]

{ #category : #generated }
GtPharoTemplateParser class >> reduceTable [
^#(
	#(52 0 #reduceActionFor_period___period__1: 3746817 false ) 
	#(101 0 #reduceActionForSwitchToLiteralArray1: 7895041 false ) 
	#(40 1 #reduceActionForMethodPattern1: 2753537 false ) 
	#(112 1 #liftFirstValue: 8574977 false ) 
	#(111 1 #liftFirstValue: 8458241 false ) 
	#(42 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3092481 false ) 
	#(40 1 #reduceActionForMethodPattern5: 2753541 false ) 
	#(50 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3632129 false ) 
	#(48 1 #reduceActionForKeywordPattern1: 3613697 false ) 
	#(40 1 #reduceActionForMethodPattern1: 2753538 false ) 
	#(112 1 #liftFirstValue: 8574978 false ) 
	#(113 1 #liftFirstValue: 8574977 false ) 
	#(55 0 #reduceActionFor_period___period__1: 4019201 false ) 
	#(43 1 #reduceActionForKeywordPattern1: 3207169 false ) 
	#(44 1 #reduceActionForPragma__pragma__1: 3218433 false ) 
	#(53 1 #reduceActionForSequence1: 3920897 false ) 
	#(51 1 #liftFirstValue: 3699721 false ) 
	#(99 1 #reduceActionForBooleanLiteral1: 7791617 false ) 
	#(99 1 #reduceActionForBooleanLiteral1: 7791618 false ) 
	#(100 1 #reduceActionForNilLiteral1: 7858177 false ) 
	#(109 1 #liftFirstValue: 8351745 false ) 
	#(89 1 #reduceActionForStringLiteral1: 6855681 false ) 
	#(110 1 #liftFirstValue: 8390657 false ) 
	#(97 1 #reduceActionForCharacterLiteral1: 7693313 false ) 
	#(90 1 #reduceActionForNumberLiteral1: 6898689 false ) 
	#(90 1 #reduceActionForNumberLiteral1: 6898690 false ) 
	#(87 0 #reduceActionForBlockArgs1: 6629377 false ) 
	#(95 0 #reduceActionFor_period___period__1: 7549953 false ) 
	#(103 1 #reduceActionForSelfVariable1: 8010753 false ) 
	#(104 1 #reduceActionForSuperVariable1: 8049665 false ) 
	#(106 1 #reduceActionForThisContextVariable1: 8136705 false ) 
	#(59 1 #liftFirstValue: 4374530 false ) 
	#(60 1 #liftFirstValue: 4455430 false ) 
	#(61 1 #liftFirstValue: 4792324 false ) 
	#(66 1 #reduceActionForKeywordMessageSend1: 5120001 false ) 
	#(66 1 #liftFirstValue: 5120002 false ) 
	#(73 1 #reduceActionForKeywordMessageSend1: 5444609 false ) 
	#(73 1 #liftFirstValue: 5444610 false ) 
	#(76 1 #reduceActionForKeywordMessageSend1: 5688321 false ) 
	#(80 1 #liftFirstValue: 6013953 false ) 
	#(76 1 #liftFirstValue: 5688322 false ) 
	#(80 1 #liftFirstValue: 6013955 false ) 
	#(80 1 #liftFirstValue: 6013956 false ) 
	#(80 1 #liftFirstValue: 6013954 false ) 
	#(88 1 #liftFirstValue: 6702081 false ) 
	#(88 1 #liftFirstValue: 6702082 false ) 
	#(88 1 #liftFirstValue: 6702083 false ) 
	#(88 1 #liftFirstValue: 6702084 false ) 
	#(88 1 #liftFirstValue: 6702085 false ) 
	#(88 1 #liftFirstValue: 6702086 false ) 
	#(88 1 #liftFirstValue: 6702087 false ) 
	#(88 1 #liftFirstValue: 6702088 false ) 
	#(79 1 #liftFirstValue: 5926913 false ) 
	#(79 1 #liftFirstValue: 5926914 false ) 
	#(79 1 #liftFirstValue: 5926916 false ) 
	#(79 1 #liftFirstValue: 5926915 false ) 
	#(109 1 #liftFirstValue: 8351746 false ) 
	#(110 1 #liftFirstValue: 8390658 false ) 
	#(76 1 #liftFirstValue: 5688323 false ) 
	#(60 1 #liftFirstValue: 4455429 false ) 
	#(105 1 #reduceActionForNamedVariable1: 8090625 false ) 
	#(98 1 #reduceActionForSymbolLiteral1: 7742465 false ) 
	#(80 1 #reduceActionForValue6: 6013958 false ) 
	#(41 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3092481 false ) 
	#(40 2 #reduceActionForMethodPattern7: 2753543 false ) 
	#(40 2 #reduceActionForMethodPattern3: 2753539 false ) 
	#(40 2 #reduceActionForMethodPattern3: 2753540 false ) 
	#(40 2 #reduceActionForMethodPattern7: 2753542 false ) 
	#(39 2 #reduceActionForMethod1: 2688001 false ) 
	#(42 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3092482 false ) 
	#(50 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3632130 false ) 
	#(49 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3632129 false ) 
	#(111 2 #liftFirstValue: 8458242 false ) 
	#(113 2 #liftFirstValue: 8574978 false ) 
	#(47 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3365889 false ) 
	#(45 2 #reduceActionForPragma4: 3238916 false ) 
	#(51 2 #reduceActionForMethodSequence5: 3699717 false ) 
	#(44 2 #reduceActionForPragma__pragma__2: 3218434 false ) 
	#(52 2 #reduceActionForPragma__pragma__2: 3746818 false ) 
	#(53 2 #reduceActionForSequence2: 3920898 false ) 
	#(56 1 #reduceActionForKeywordPattern1: 4061185 false ) 
	#(58 1 #reduceActionForStatementList1: 4113409 false ) 
	#(53 2 #reduceActionForSequence3: 3920899 false ) 
	#(59 2 #reduceActionForStatement1: 4374529 false ) 
	#(81 2 #reduceActionForArray1: 6173697 false ) 
	#(83 0 #reduceActionFor__period___period__Assignment__value___1: 6227969 false ) 
	#(86 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 6457345 false ) 
	#(110 2 #liftSecondValue: 8390659 false ) 
	#(61 2 #reduceActionForCascade1: 4792321 false ) 
	#(64 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4990977 false ) 
	#(62 1 #reduceActionForKeywordPattern1: 4970497 false ) 
	#(67 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5207041 false ) 
	#(70 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5311489 false ) 
	#(68 1 #reduceActionForKeywordMessage1: 5293057 false ) 
	#(72 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5374977 false ) 
	#(68 1 #reduceActionForKeywordMessage1: 5293058 false ) 
	#(74 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5528577 false ) 
	#(108 1 #liftFirstValue: 8299522 false ) 
	#(61 2 #reduceActionForCascade1: 4792322 false ) 
	#(78 1 #reduceActionForUnaryMessage1: 5852161 false ) 
	#(77 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5771265 false ) 
	#(78 1 #liftFirstValue: 5852162 false ) 
	#(61 2 #reduceActionForCascade1: 4792323 false ) 
	#(92 0 #reduceActionFor_period___period__1: 7047169 false ) 
	#(107 3 #reduceActionForTemplate1: 8189953 false ) 
	#(40 3 #reduceActionForMethodPattern8: 2753544 false ) 
	#(49 3 #reduceActionFor_TemplateKeyword__selectorPart___space___Variable__variable__2: 3632130 false ) 
	#(54 3 #reduceActionForTemporaries1: 3986433 false ) 
	#(55 2 #reduceActionForPragma__pragma__2: 4019202 false ) 
	#(45 3 #reduceActionForPragma1: 3238913 false ) 
	#(46 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3365890 false ) 
	#(46 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3365889 false ) 
	#(46 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3365891 false ) 
	#(45 3 #reduceActionForPragma3: 3238915 false ) 
	#(47 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3365890 false ) 
	#(45 3 #reduceActionForPragma1: 3238914 false ) 
	#(45 3 #reduceActionForPragma5: 3238917 false ) 
	#(51 3 #reduceActionForMethodSequence6: 3699718 false ) 
	#(51 3 #reduceActionForMethodSequence7: 3699719 false ) 
	#(57 1 #reduceActionForPragma__pragma__1: 4089857 false ) 
	#(56 2 #reduceActionForStatements2: 4061186 false ) 
	#(51 3 #reduceActionForMethodSequence3: 3699715 false ) 
	#(53 3 #reduceActionForSequence4: 3920900 false ) 
	#(81 3 #reduceActionForArray2: 6173698 false ) 
	#(85 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 6457345 false ) 
	#(87 2 #reduceActionForBlockArgs2: 6629378 false ) 
	#(84 3 #reduceActionForBlock2: 6325250 false ) 
	#(86 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 6457346 false ) 
	#(80 3 #reduceActionForValue5: 6013957 false ) 
	#(94 3 #reduceActionForByteArrayLiteral1: 7498753 false ) 
	#(96 1 #liftFirstValue: 7617537 false ) 
	#(95 2 #reduceActionForPragma__pragma__2: 7549954 false ) 
	#(96 1 #reduceActionForValue6: 7617538 false ) 
	#(63 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4990977 false ) 
	#(65 1 #liftFirstValue: 5048321 false ) 
	#(65 1 #liftFirstValue: 5048322 false ) 
	#(65 1 #liftFirstValue: 5048323 false ) 
	#(64 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4990978 false ) 
	#(69 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5311489 false ) 
	#(75 2 #reduceActionForBinaryMessage1: 5612545 false ) 
	#(70 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5311490 false ) 
	#(72 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5374978 false ) 
	#(108 2 #liftFirstValue: 8299521 false ) 
	#(71 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5374977 false ) 
	#(60 3 #reduceActionForAssignment1: 4455425 false ) 
	#(60 3 #reduceActionForAssignment1: 4455427 false ) 
	#(102 0 #reduceActionForEndLiteralArray1: 7959553 false ) 
	#(60 3 #reduceActionForAssignment1: 4455426 false ) 
	#(60 3 #reduceActionForAssignment1: 4455428 false ) 
	#(51 4 #reduceActionForMethodSequence1: 3699713 false ) 
	#(51 4 #reduceActionForMethodSequence8: 3699720 false ) 
	#(58 3 #reduceActionForStatementList3: 4113411 false ) 
	#(57 2 #reduceActionForPragma__pragma__2: 4089858 false ) 
	#(58 3 #reduceActionForStatementList3: 4113410 false ) 
	#(51 4 #reduceActionForMethodSequence4: 3699716 false ) 
	#(81 4 #reduceActionForArray3: 6173699 false ) 
	#(83 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 6227970 false ) 
	#(84 4 #reduceActionForBlock1: 6325249 false ) 
	#(84 4 #reduceActionForBlock3: 6325251 false ) 
	#(93 1 #reduceActionForSymbolLiteral1: 7124995 false ) 
	#(93 1 #reduceActionForSymbolLiteral1: 7124994 false ) 
	#(93 1 #reduceActionForSymbolLiteral1: 7124996 false ) 
	#(93 1 #reduceActionForSymbolLiteral1: 7124998 false ) 
	#(93 1 #reduceActionForSymbolLiteral1: 7124997 false ) 
	#(93 1 #liftFirstValue: 7124993 false ) 
	#(92 2 #reduceActionForPragma__pragma__2: 7047170 false ) 
	#(93 1 #reduceActionForValue6: 7125000 false ) 
	#(51 5 #reduceActionForMethodSequence2: 3699714 false ) 
	#(81 5 #reduceActionForArray4: 6173700 false ) 
	#(82 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 6227969 false ) 
	#(91 5 #reduceActionForArrayLiteral1: 6975489 false ) 
	#(58 5 #reduceActionForStatementList4: 4113412 false ) 
	#(93 3 #reduceActionForArrayLiteralValue7: 7124999 false )
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
	^ #('<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<symbol>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<space>' '<self>' '<super>' '<thisContext>' '<doubleLeftBrace>' '<doubleRightBrace>' '<symbolHash>' 'B e g i n' 'Method' 'MethodPattern' '(<keyword> ''selectorPart'' Variable ''variable'')' '(<keyword> ''selectorPart'' Variable ''variable'')+' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(<keyword> ''selectorPart'' (Literal ''value'' | Variable ''value'' | TemplateName ''value''))' '(<keyword> ''selectorPart'' (Literal ''value'' | Variable ''value'' | TemplateName ''value''))+' 'KeywordPattern' '(TemplateKeyword ''selectorPart'' <space>? Variable ''variable'')' '(TemplateKeyword ''selectorPart'' <space>? Variable ''variable'')+' 'MethodSequence' '<period> ''period''*' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' '<period> ''period''+' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')+' '(TemplatePattern ''selectorPart'' BinaryMessageSend ''value'')' '(TemplatePattern ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'Variable' 'Value' 'Array' '(<period> ''period'' Assignment ''value'')' '(<period> ''period'' Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' 'SelfVariable' 'SuperVariable' 'NamedVariable' 'ThisContextVariable' 'Template' 'TemplatePattern' 'TemplateName' 'TemplateSymbol' 'TemplateKeyword' '(<name> | Template)' '(<name> | Template)+' 'E O F' 'error')
]

{ #category : #generated }
GtPharoTemplateParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoProgramNode #GtPharoVariableNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #GtPharoSelfVariableNode #GtPharoSuperVariableNode #GtPharoNamedVariableNode #GtPharoThisContextVariableNode #GtPharoTemplateNode #GtPharoTemplateNode #Object #Object #Object #Object #Object #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoTemplateParser class >> transitionTable [
^#(
#[1 0 25 0 4 0 29 0 25 0 33 0 26 0 37 0 35 0 41 0 39 0 45 0 40 0 49 0 41 0 53 0 42 0 57 0 48 0 61 0 49 0 65 0 50 0 69 0 107 0 73 0 111 0 81 0 112 0 81 0 113] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 85 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 89 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 0 93 0 43 0 97 0 44 0 101 0 45 0 105 0 51 0 109 0 52 0 105 0 53 0 117 0 54 0 6 0 114 0 6 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 0 193 0 59 0 193 0 60 0 193 0 61 0 193 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[1 0 25 0 4 0 29 0 25 0 33 0 26 0 37 0 35 1 61 0 40 0 49 0 41 0 53 0 42 0 57 0 48 0 61 0 49 0 65 0 50 0 69 0 107 0 73 0 111 0 81 0 112 0 81 0 113] 
#[1 0 37 0 35 1 65 0 107] 
#[1 0 14 0 1 0 14 0 2 0 14 0 3 0 7 0 4 0 14 0 6 0 14 0 7 0 14 0 8 0 14 0 9 0 14 0 10 0 14 0 11 0 14 0 13 0 14 0 14 0 14 0 16 0 14 0 17 0 18 0 18 0 14 0 19 0 14 0 20 0 14 0 21 0 14 0 29 0 14 0 32 0 14 0 33 0 14 0 34 0 7 0 35 0 14 0 37 0 14 0 114 0 14 0 115] 
#[1 0 11 0 4 0 22 0 31 0 15 0 32 0 19 0 33 0 23 0 34 0 27 0 35 1 69 0 79 1 69 0 103 1 69 0 104 1 69 0 105 1 69 0 106 1 49 0 107 1 49 0 109 1 77 0 115] 
#[1 1 49 0 4 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 1 81 0 79 1 81 0 103 1 81 0 104 1 81 0 105 1 81 0 106 1 85 0 107 1 49 0 109 1 89 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 1 93 0 60 1 93 0 61 1 93 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[0 0 0 0 114] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 85 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 89 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 0 93 0 43 0 97 0 44 0 101 0 45 1 97 0 51 0 109 0 52 1 97 0 53 0 117 0 54 0 6 0 114 0 6 0 115] 
#[0 0 26 0 25] 
#[1 1 101 0 25 1 105 0 41] 
#[0 0 30 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 0 34 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[1 0 38 0 1 0 38 0 2 0 38 0 3 0 31 0 4 0 38 0 6 0 38 0 7 0 38 0 8 0 38 0 9 0 38 0 10 0 38 0 11 0 38 0 13 0 38 0 14 0 38 0 16 0 38 0 17 0 38 0 19 0 38 0 20 0 38 0 21 0 73 0 25 0 38 0 29 0 38 0 32 0 38 0 33 0 38 0 34 0 35 0 35 0 38 0 37 1 117 0 49 0 81 0 107 0 73 0 111 0 81 0 112 0 81 0 113 0 38 0 114 0 38 0 115] 
#[1 0 42 0 1 0 42 0 2 0 42 0 3 0 39 0 4 0 42 0 6 0 42 0 7 0 42 0 8 0 42 0 9 0 42 0 10 0 42 0 11 0 42 0 13 0 42 0 14 0 42 0 16 0 42 0 17 0 46 0 18 0 42 0 19 0 42 0 20 0 42 0 21 0 42 0 29 0 42 0 32 0 42 0 33 0 42 0 34 0 39 0 35 0 42 0 37 0 42 0 114 0 42 0 115] 
#[1 1 49 0 4 1 125 0 31 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 1 129 0 79 1 129 0 103 1 129 0 104 1 129 0 105 1 129 0 106 1 49 0 107 1 49 0 109] 
#[0 0 50 0 4 0 18 0 35] 
#[1 1 137 0 4 1 133 0 18 0 37 0 35 1 137 0 107 1 137 0 112] 
#[1 0 54 0 4 0 54 0 6 0 54 0 32 0 54 0 33 0 54 0 34 0 54 0 35 1 141 0 55] 
#[1 1 145 0 4 1 149 0 25 0 37 0 35 1 153 0 46 1 157 0 47 1 161 0 107 1 161 0 109 1 165 0 115] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 85 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 1 169 0 52 1 173 0 54 0 6 0 114 0 6 0 115] 
#[1 0 58 0 1 0 58 0 2 0 58 0 3 0 58 0 4 0 58 0 6 0 58 0 7 0 58 0 8 0 58 0 9 0 58 0 10 0 58 0 11 0 58 0 13 0 89 0 14 0 58 0 16 0 58 0 17 0 58 0 19 0 58 0 20 0 58 0 21 0 58 0 29 0 58 0 32 0 58 0 33 0 58 0 34 0 58 0 35 0 58 0 37 1 177 0 45 0 58 0 114 0 58 0 115] 
#[0 0 62 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 0 0 0 114] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 66 0 23 1 181 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 1 185 0 56 1 189 0 58 1 193 0 59 1 193 0 60 1 193 0 61 1 193 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 0 66 0 114 0 43 0 115] 
#[0 0 70 0 114] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 89 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 1 197 0 43 0 97 0 44 0 101 0 45 1 201 0 52 0 6 0 114 0 6 0 115] 
#[0 0 74 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 78 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 82 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 86 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[0 0 90 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 94 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 98 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 102 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 106 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 1 205 0 60 1 205 0 61 1 205 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 1 209 0 24 1 213 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 1 217 0 60 1 217 0 61 1 217 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[1 0 110 0 1 0 110 0 2 0 110 0 3 0 110 0 4 0 110 0 6 0 110 0 7 0 110 0 8 0 110 0 9 0 110 0 10 0 110 0 11 0 110 0 13 0 110 0 16 0 110 0 17 1 221 0 18 0 110 0 19 0 110 0 20 0 110 0 21 0 110 0 23 0 110 0 29 0 110 0 32 0 110 0 33 0 110 0 34 0 110 0 35 0 110 0 37 1 225 0 85 1 229 0 86 1 233 0 87 0 110 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 1 237 0 60 1 237 0 61 1 237 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[1 0 114 0 10 0 114 0 11 0 114 0 23 1 241 0 95 0 114 0 115] 
#[0 0 118 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[0 0 122 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[0 0 126 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[1 0 37 0 35 1 245 0 107] 
#[0 0 0 0 114] 
#[0 0 130 0 23 0 29 0 35 0 114 0 115] 
#[0 0 134 0 22 0 23 0 24 0 29 0 35 0 36 0 114 0 115] 
#[0 0 138 0 22 0 23 0 24 0 29 0 35 0 36 0 114 0 115] 
#[1 0 142 0 22 0 142 0 23 0 142 0 24 1 249 0 27 0 142 0 29 0 142 0 35 0 142 0 36 1 253 0 62 2 1 0 63 2 5 0 64 0 142 0 114 0 142 0 115] 
#[1 0 146 0 22 0 146 0 23 0 146 0 24 2 9 0 25 2 13 0 26 0 146 0 29 0 47 0 35 0 146 0 36 2 17 0 68 2 21 0 69 2 25 0 70 2 29 0 71 2 33 0 72 2 37 0 75 2 41 0 107 2 45 0 108 0 146 0 114 0 146 0 115] 
#[1 0 150 0 22 0 150 0 23 0 150 0 24 0 150 0 25 0 150 0 26 1 249 0 27 0 150 0 29 0 150 0 35 0 150 0 36 2 49 0 62 2 1 0 63 2 5 0 64 0 150 0 114 0 150 0 115] 
#[1 2 53 0 4 0 154 0 22 0 154 0 23 0 154 0 24 0 154 0 25 0 154 0 26 0 154 0 27 0 154 0 29 0 51 0 35 0 154 0 36 2 57 0 78 2 57 0 107 0 154 0 114 0 154 0 115] 
#[1 0 158 0 4 0 158 0 22 0 158 0 23 0 158 0 24 0 158 0 25 0 158 0 26 1 249 0 27 0 158 0 29 0 158 0 35 0 158 0 36 2 65 0 62 2 1 0 63 2 5 0 64 0 158 0 114 0 158 0 115] 
#[1 0 162 0 4 0 162 0 22 0 162 0 23 0 162 0 24 0 162 0 25 0 162 0 26 2 69 0 28 0 162 0 29 0 162 0 35 0 162 0 36 0 162 0 114 0 162 0 115] 
#[0 0 166 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 0 170 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 0 174 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 0 178 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 0 182 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 186 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 190 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 194 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 198 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 202 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 206 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 210 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 2 73 0 20] 
#[0 0 214 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[0 0 218 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[0 0 222 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[0 0 226 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[1 0 55 0 4 0 59 0 22 0 59 0 23 0 59 0 24 0 55 0 25 0 55 0 26 0 63 0 28 0 59 0 29 0 59 0 35 0 59 0 36 0 59 0 114 0 59 0 115] 
#[0 0 246 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[0 0 250 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 0 254 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 0 0 0 114] 
#[0 0 0 0 114] 
#[0 1 2 0 25] 
#[0 0 230 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 6 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 10 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 0 67 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 18 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 2 81 0 36] 
#[0 1 22 0 114] 
#[1 1 49 0 4 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 1 69 0 79 1 69 0 103 1 69 0 104 1 69 0 105 1 69 0 106 1 49 0 107 1 49 0 109 2 85 0 115] 
#[0 1 26 0 25] 
#[0 0 18 0 4 0 18 0 35] 
#[0 0 22 0 4 0 31 0 32 0 33 0 34 0 35] 
#[0 1 30 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 0 46 0 4 0 18 0 35] 
#[1 1 49 0 4 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 2 89 0 79 2 89 0 103 2 89 0 104 2 89 0 105 2 89 0 106 1 49 0 107 1 49 0 109] 
#[0 1 34 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 38 0 4 0 31 0 32 0 33 0 34 0 35] 
#[0 1 42 0 4 0 18 0 35] 
#[1 1 49 0 4 2 93 0 6 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 2 97 0 79 2 97 0 103 2 97 0 104 2 97 0 105 2 97 0 106 1 49 0 107 1 49 0 109] 
#[0 0 71 0 15] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 2 117 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 2 105 0 79 2 109 0 88 2 109 0 89 2 109 0 90 2 109 0 91 2 109 0 94 2 109 0 97 2 109 0 98 2 109 0 99 2 109 0 100 1 25 0 101 2 105 0 103 2 105 0 104 2 105 0 105 2 105 0 106 2 113 0 107 2 117 0 109 1 53 0 110] 
#[0 1 46 0 15 0 25] 
#[1 2 121 0 15 1 149 0 25 2 125 0 46] 
#[0 2 129 0 15] 
#[1 1 50 0 1 1 50 0 2 1 50 0 3 1 50 0 4 1 50 0 6 1 50 0 7 1 50 0 8 1 50 0 9 1 50 0 10 1 50 0 11 1 50 0 13 1 50 0 14 2 133 0 15 1 50 0 16 1 50 0 17 1 50 0 19 1 50 0 20 1 50 0 21 1 50 0 29 1 50 0 32 1 50 0 33 1 50 0 34 1 50 0 35 1 50 0 37 1 50 0 114 1 50 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 1 181 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 2 137 0 56 1 189 0 58 1 193 0 59 1 193 0 60 1 193 0 61 1 193 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 54 0 114 1 57 0 115] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 89 0 14 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 2 141 0 43 0 97 0 44 0 101 0 45 2 145 0 52 0 6 0 114 0 6 0 115] 
#[0 1 58 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 62 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 66 0 23 0 114 0 115] 
#[1 1 70 0 23 0 75 0 29 0 6 0 35 2 153 0 52 2 157 0 57 1 70 0 114 1 70 0 115] 
#[0 1 74 0 23 0 29 0 35 0 114 0 115] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 2 161 0 52 0 6 0 114 0 6 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 1 78 0 23 1 181 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 2 165 0 56 1 189 0 58 1 193 0 59 1 193 0 60 1 193 0 61 1 193 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 78 0 114 0 79 0 115] 
#[0 1 82 0 23 0 29 0 35 0 114 0 115] 
#[0 1 86 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 169 0 24] 
#[1 1 90 0 24 1 90 0 29 2 173 0 83] 
#[1 1 49 0 4 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 2 177 0 79 2 177 0 103 2 177 0 104 2 177 0 105 2 177 0 106 1 49 0 107 1 49 0 109] 
#[0 1 94 0 6 0 18 0 23] 
#[1 2 181 0 6 1 221 0 18 2 185 0 23 2 189 0 85] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 85 0 6 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 0 109 0 52 2 193 0 53 2 197 0 54 0 6 0 115] 
#[0 2 201 0 22] 
#[1 0 149 0 10 0 153 0 11 2 205 0 23 2 213 0 90 2 213 0 96 2 217 0 115] 
#[0 1 98 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[1 2 53 0 4 2 9 0 25 2 13 0 26 0 37 0 35 2 221 0 65 2 221 0 68 2 21 0 69 2 25 0 70 2 29 0 71 2 33 0 72 2 221 0 75 2 221 0 78 2 237 0 107 2 45 0 108] 
#[0 1 102 0 22 0 23 0 24 0 29 0 35 0 36 0 114 0 115] 
#[0 1 106 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 1 110 0 22 1 110 0 23 1 110 0 24 1 249 0 27 1 110 0 29 1 110 0 35 1 110 0 36 2 241 0 63 1 110 0 114 1 110 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 2 245 0 73 2 249 0 74 0 221 0 76 2 253 0 77 0 221 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 221 0 103 0 221 0 104 0 221 0 105 0 221 0 106 3 5 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 9 0 76 2 253 0 77 3 9 0 79 3 9 0 80 3 9 0 81 3 9 0 84 3 9 0 88 3 9 0 89 3 9 0 90 3 9 0 91 3 9 0 94 3 9 0 97 3 9 0 98 3 9 0 99 3 9 0 100 1 25 0 101 3 9 0 103 3 9 0 104 3 9 0 105 3 9 0 106 3 5 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[0 1 114 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 1 118 0 22 0 23 0 24 0 25 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 1 122 0 22 1 122 0 23 1 122 0 24 2 9 0 25 1 122 0 27 1 122 0 29 1 122 0 35 1 122 0 36 3 13 0 69 1 122 0 114 1 122 0 115] 
#[0 1 126 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 1 130 0 22 1 130 0 23 1 130 0 24 1 130 0 27 1 130 0 29 0 83 0 35 1 130 0 36 3 17 0 71 2 41 0 107 2 45 0 108 1 130 0 114 1 130 0 115] 
#[0 1 134 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 1 138 0 1 1 138 0 2 1 138 0 3 1 138 0 4 1 138 0 7 1 138 0 8 1 138 0 9 1 138 0 10 1 138 0 11 1 138 0 16 1 138 0 17 3 21 0 18 1 138 0 19 1 138 0 20 1 138 0 21 1 138 0 32 1 138 0 33 1 138 0 34 1 138 0 35 1 138 0 37 1 138 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 25 0 73 2 249 0 74 0 221 0 76 2 253 0 77 0 221 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 221 0 103 0 221 0 104 0 221 0 105 0 221 0 106 3 5 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[0 1 142 0 22 0 23 0 24 0 29 0 35 0 36 0 114 0 115] 
#[0 1 146 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 1 150 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 1 154 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 1 158 0 22 0 23 0 24 0 29 0 35 0 36 0 114 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 29 0 60 3 29 0 61 3 29 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 3 33 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[1 1 162 0 1 1 162 0 2 1 162 0 3 1 162 0 4 1 162 0 7 1 162 0 8 1 162 0 9 1 162 0 10 1 162 0 11 1 162 0 12 1 162 0 19 1 162 0 20 1 162 0 21 1 162 0 22 1 162 0 26 1 162 0 27 1 162 0 29 1 162 0 35 1 162 0 37 3 37 0 92 1 162 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 41 0 60 3 41 0 61 3 41 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 3 45 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[0 1 166 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 32 0 33 0 34 0 35 0 36 0 37 0 114 0 115] 
#[0 1 170 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 174 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 25 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 178 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 182 0 4 0 6 0 32 0 33 0 34 0 35] 
#[0 1 186 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 190 0 15 0 25] 
#[0 1 194 0 15 0 25] 
#[0 0 87 0 15 0 25] 
#[0 0 91 0 15 0 25] 
#[0 1 202 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 206 0 15 0 25] 
#[0 1 210 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 214 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 14 0 16 0 17 0 19 0 20 0 21 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 1 218 0 114] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 3 49 0 52 0 6 0 114 0 6 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 1 181 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 53 0 56 1 189 0 58 1 193 0 59 1 193 0 60 1 193 0 61 1 193 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 222 0 114 1 57 0 115] 
#[0 1 226 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[1 1 181 0 29 0 37 0 35 3 57 0 107] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 1 230 0 23 3 61 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 65 0 59 3 65 0 60 3 65 0 61 3 65 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 230 0 114 0 95 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 1 181 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 69 0 56 1 189 0 58 1 193 0 59 1 193 0 60 1 193 0 61 1 193 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 234 0 114 1 57 0 115] 
#[0 1 238 0 23 0 114 0 115] 
#[0 1 242 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 3 73 0 24 3 77 0 29 3 81 0 82] 
#[0 1 246 0 6 0 18 0 23] 
#[0 1 250 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 32 0 33 0 34 0 35 0 37 0 115] 
#[0 1 254 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 2 0 6 0 18 0 23] 
#[1 3 85 0 23 3 89 0 115] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 6 0 35 0 6 0 37 1 201 0 52 0 6 0 115] 
#[0 2 6 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 10 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 2 14 0 10 0 11 0 23 0 115] 
#[0 2 18 0 10 0 11 0 23 0 115] 
#[0 2 22 0 10 0 11 0 23 0 115] 
#[0 2 26 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 30 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 34 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 38 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 1 138 0 1 1 138 0 2 1 138 0 3 1 138 0 4 1 138 0 7 1 138 0 8 1 138 0 9 1 138 0 10 1 138 0 11 1 138 0 16 1 138 0 17 3 21 0 18 1 138 0 19 1 138 0 20 1 138 0 21 1 154 0 22 1 154 0 23 1 154 0 24 1 154 0 27 1 154 0 29 1 138 0 32 1 138 0 33 1 138 0 34 0 99 0 35 1 154 0 36 1 138 0 37 1 154 0 114 0 99 0 115] 
#[0 2 42 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 2 46 0 22 2 46 0 23 2 46 0 24 2 46 0 25 2 13 0 26 2 46 0 27 2 46 0 29 2 46 0 35 2 46 0 36 2 37 0 75 2 46 0 114 2 46 0 115] 
#[0 0 150 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 0 158 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 0 162 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 0 55 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 2 53 0 4 2 50 0 22 2 50 0 23 2 50 0 24 2 50 0 25 2 50 0 26 2 50 0 27 2 50 0 29 0 103 0 35 2 50 0 36 2 57 0 78 2 57 0 107 2 50 0 114 2 50 0 115] 
#[0 2 54 0 22 0 23 0 24 0 25 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 58 0 22 0 23 0 24 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 62 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 16 0 17 0 19 0 20 0 21 0 32 0 33 0 34 0 35 0 37 0 115] 
#[1 2 66 0 22 2 66 0 23 2 66 0 24 2 13 0 26 2 66 0 27 2 66 0 29 2 66 0 35 2 66 0 36 2 37 0 75 2 66 0 114 2 66 0 115] 
#[0 2 70 0 22 0 23 0 24 0 29 0 35 0 36 0 114 0 115] 
#[1 0 55 0 4 0 107 0 22 0 107 0 23 0 107 0 24 0 55 0 25 0 55 0 26 0 63 0 28 0 107 0 29 0 107 0 35 0 107 0 36 0 107 0 114 0 107 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 3 93 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 3 97 0 12 3 101 0 19 0 10 0 20 0 173 0 21 2 78 0 22 3 105 0 26 3 109 0 27 3 113 0 29 0 37 0 35 0 189 0 37 3 121 0 88 3 121 0 89 3 121 0 90 3 121 0 91 3 121 0 93 3 121 0 94 3 121 0 97 3 121 0 98 3 121 0 99 3 121 0 100 1 25 0 101 3 125 0 102 1 53 0 107 1 53 0 110 3 133 0 115] 
#[0 2 82 0 22 0 23 0 24 0 29 0 35 0 36 0 114 0 115] 
#[1 0 55 0 4 0 111 0 22 0 111 0 23 0 111 0 24 0 55 0 25 0 55 0 26 0 63 0 28 0 111 0 29 0 111 0 35 0 111 0 36 0 111 0 114 0 111 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 1 181 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 137 0 56 1 189 0 58 1 193 0 59 1 193 0 60 1 193 0 61 1 193 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 2 90 0 114 1 57 0 115] 
#[0 2 94 0 114] 
#[1 0 6 0 1 0 6 0 2 0 6 0 3 0 6 0 4 0 6 0 7 0 6 0 8 0 6 0 9 0 6 0 10 0 6 0 11 0 6 0 13 0 6 0 16 0 6 0 17 0 6 0 19 0 6 0 20 0 6 0 21 2 98 0 23 0 115 0 29 0 6 0 32 0 6 0 33 0 6 0 34 0 115 0 35 0 6 0 37 3 141 0 52 2 98 0 114 0 115 0 115] 
#[0 2 102 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 13 0 16 0 17 0 19 0 20 0 21 0 23 0 29 0 32 0 33 0 34 0 35 0 37 0 114 0 115] 
#[0 2 106 0 23 0 29 0 35 0 114 0 115] 
#[0 2 110 0 114] 
#[0 2 114 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 3 145 0 24 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 149 0 60 3 149 0 61 3 149 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[0 2 118 0 24 0 29] 
#[0 2 122 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 126 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 130 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[0 2 134 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[1 1 162 0 1 1 162 0 2 1 162 0 3 1 162 0 4 1 162 0 7 1 162 0 8 1 162 0 9 1 162 0 10 1 162 0 11 1 162 0 12 1 162 0 19 1 162 0 20 1 162 0 21 1 162 0 22 1 162 0 26 1 162 0 27 1 162 0 29 1 162 0 35 1 162 0 37 3 153 0 92 1 162 0 115] 
#[0 2 138 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[0 2 142 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[0 2 146 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[0 2 150 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[0 2 154 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[0 3 157 0 22] 
#[0 0 234 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[0 2 158 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115] 
#[0 2 162 0 114] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 1 49 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 13 0 161 0 16 0 165 0 17 0 169 0 19 0 10 0 20 0 173 0 21 1 181 0 29 0 177 0 32 0 181 0 33 0 185 0 34 0 37 0 35 0 189 0 37 3 161 0 59 3 161 0 60 3 161 0 61 3 161 0 66 0 209 0 67 0 213 0 73 0 217 0 74 0 221 0 76 0 225 0 77 0 229 0 79 0 221 0 80 0 221 0 81 0 221 0 84 0 221 0 88 0 221 0 89 0 221 0 90 0 221 0 91 0 221 0 94 0 221 0 97 0 221 0 98 0 221 0 99 0 221 0 100 1 25 0 101 0 229 0 103 0 229 0 104 0 229 0 105 0 229 0 106 1 45 0 107 1 49 0 109 1 53 0 110 1 57 0 115] 
#[0 2 166 0 4 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 114 0 115] 
#[0 2 170 0 24 0 29] 
#[1 0 121 0 1 0 125 0 2 0 129 0 3 3 93 0 4 0 137 0 7 1 53 0 8 0 145 0 9 0 149 0 10 0 153 0 11 3 97 0 12 3 101 0 19 0 10 0 20 0 173 0 21 3 165 0 22 3 105 0 26 3 109 0 27 3 113 0 29 0 37 0 35 0 189 0 37 3 121 0 88 3 121 0 89 3 121 0 90 3 121 0 91 3 121 0 93 3 121 0 94 3 121 0 97 3 121 0 98 3 121 0 99 3 121 0 100 1 25 0 101 1 53 0 107 1 53 0 110 3 133 0 115] 
#[0 2 174 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 15 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 35 0 36 0 37 0 114 0 115] 
#[0 2 178 0 23 0 29 0 35 0 114 0 115] 
#[0 2 182 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 12 0 19 0 20 0 21 0 22 0 26 0 27 0 29 0 35 0 37 0 115]
	).
]

{ #category : #private }
GtPharoTemplateParser >> endLiteralArray [
	(nodeStack
		inject: 0
		into: [ :sum :each | 
			sum
				+
					(each == #array
						ifTrue: [ 1 ]
						ifFalse: [ 0 ]) ]) = 1
		ifTrue: [ self scope: #default ]
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
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
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
	result addObject: (nodes at: 1) to: result selectorParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern3: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern5: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern7: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern8: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addObject: (nodes at: 2) to: result selectorParts.
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
	result addObject: (nodes at: 2) to: result selectorParts.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma3: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addObjects: ((nodes at: 2) at: 1) to: result selectorParts.
	result addObjects: ((nodes at: 2) at: 2) to: result values.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma4: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma5: nodes [
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
GtPharoTemplateParser >> reduceActionForStatementList3: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatementList4: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	self addAll: (nodes at: 4) to: (result at: 2).
	self add: (nodes at: 5) to: (result at: 1).
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
GtPharoTemplateParser >> reduceActionFor_TemplateKeyword__selectorPart___space___Variable__variable__2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 3).
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

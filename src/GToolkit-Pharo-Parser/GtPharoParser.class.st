Class {
	#name : 'GtPharoParser',
	#superclass : 'SmaCCGLRParser',
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : 'generated' }
GtPharoParser class >> ambiguousTransitions [
^#(
#[ 0 230 1 45] 
#[ 0 10 1 45] 
#[ 0 37 1 62] 
#[ 1 45 1 90] 
#[ 1 45 1 94] 
#[ 0 106 1 45]
	).
]

{ #category : 'generated-accessing' }
GtPharoParser class >> cacheId [
	^'2021-04-23T16:43:40.789098+02:00'
]

{ #category : 'generated' }
GtPharoParser class >> definitionComment [
"%glr;
%prefix GtPharo;
%suffix Node;
%root Program;
%start Method MethodSequence Statement MethodPattern KeywordMessageSend Name Keyword;
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
default literalArray <keyword>
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
default literalArray <symbolHash>
	: \#{1,2}
	;
Method
	: MethodPattern 'pattern' MethodSequence 'body' {{}}
	;
MethodPattern
	: Name 'selectorPart' {{}}
	| <binary> 'selectorPart' Variable 'variable' {{}}
	| KeywordPattern {{}}
	| <binary> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| Keyword 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| (Keyword 'selectorPart' Variable 'variable')+ Keyword 'selectorPart' error 'smaccError' {{ErrorPattern}}
	;
Pragmas
	: Pragma 'pragma'+
	;
Pragma
	:  <lt> 'lessThan' Name 'selectorPart' <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' (Keyword 'selectorPart' (Literal 'value' | Variable 'value'))+ <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' error 'smaccError' {{PragmaError}}
	| <lt> 'lessThan' error 'smaccError' <gt> 'greaterThan' {{PragmaError}}
	;
KeywordPattern
	: (Keyword 'selectorPart' Variable 'variable')+
	;
MethodSequence
	: Pragmas Temporaries Pragmas Period 'period'? Statements? {{}}
	| Temporaries Pragmas Period 'period'? Statements? {{}}
	| Pragmas Temporaries? Period 'period'? Statements? {{}}
	| Sequence
	;
Sequence
	: Temporaries? Period 'period'? Statements? {{}}
	;
Temporaries
	:  <bar> 'leftBar' Variable 'variable'* <bar> 'rightBar'
	;
Statements
	: StatementList Period 'period'?
	;
StatementList
	: Statement 'statement'
	| StatementList Period 'period' Statement 'statement'
	;
Statement
	: <return> 'upArrow' Assignment 'value' {{Return}}
	| Assignment
	;
Assignment
	: Variable 'variable' <assign> 'assignmentToken' Assignment 'value' {{}}
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
	: (Keyword 'selectorPart' BinaryMessageSend 'value')+ {{}}
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
	: Name 'selectorPart' {{}}
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
	: Symbol 'value' {{}}
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
	: Name 'name' {{}}
	;
ThisContextVariable
	: <thisContext> 'name' {{}}
	;
Name
	# In order to support templates as part of the name in the same AST tree we should define Name production in such a way that it consists of multiple parts, where one of the parts is an ast node.
	: <name> 'namePart' Nothing 'namePart' {{}}
	;
Keyword
	# In order to support templates as part of the keyword in the same AST tree we should define Keyword production in such a way that it consists of multiple parts, where one of the parts is an ast node.
	: <keyword> 'selectorPart' Nothing 'selectorPart' {{}}
	;
Symbol
	: <symbolHash> 'hash'( Name 'symbolPart'(<colon>'symbolPart'<colon> 'symbolPart'Name'symbolPart')* | <binary> 'symbolPart'| Keyword'symbolPart'+ | <string> 'symbolPart') {{}}
	;
Period
	: <period> 'period' (<period> 'period')*
	;
NothingToken
	# use me to denote nothing. It can be used to trick smacc into thinking that some nodes consist of multiple parts while in fact being just one. For example see Name
	: { ^ nil }
	;
Nothing
	# Can be used to fake empty productions, see Name as an example
	: NothingToken {{}}
	;"
]

{ #category : 'generated' }
GtPharoParser class >> reduceTable [
^#(
	#(93 0 #reduceActionForSwitchToLiteralArray1: 7102465 false ) 
	#(48 0 #reduceActionForSequence1: 3652609 false ) 
	#(108 0 #nil 8163329 false ) 
	#(40 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 2912257 false ) 
	#(46 1 #reduceActionForKeywordPattern1: 3368961 false ) 
	#(38 1 #reduceActionForMethodPattern3: 2661379 false ) 
	#(38 1 #reduceActionForMethodPattern1: 2661377 false ) 
	#(91 1 #reduceActionForBooleanLiteral1: 6999041 false ) 
	#(91 1 #reduceActionForBooleanLiteral1: 6999042 false ) 
	#(92 1 #reduceActionForNilLiteral1: 7065601 false ) 
	#(50 0 #reduceActionForVariable__variable__1: 3748865 false ) 
	#(81 1 #reduceActionForStringLiteral1: 6071297 false ) 
	#(89 1 #reduceActionForCharacterLiteral1: 6908929 false ) 
	#(82 1 #reduceActionForNumberLiteral1: 6114305 false ) 
	#(82 1 #reduceActionForNumberLiteral1: 6114306 false ) 
	#(79 0 #reduceActionForBlockArgs1: 5844993 false ) 
	#(87 0 #reduceActionForVariable__variable__1: 6765569 false ) 
	#(107 0 #nil 8138753 false ) 
	#(95 1 #reduceActionForSelfVariable1: 7218177 false ) 
	#(96 1 #reduceActionForSuperVariable1: 7257089 false ) 
	#(98 1 #reduceActionForThisContextVariable1: 7335937 false ) 
	#(47 1 #reduceActionForMethodSequence9: 3437577 false ) 
	#(41 1 #reduceActionForKeywordPattern1: 3022849 false ) 
	#(42 1 #reduceActionForPragma__pragma__1: 3034113 false ) 
	#(47 1 #liftFirstValue: 3437585 false ) 
	#(48 1 #reduceActionForSequence5: 3652613 false ) 
	#(48 1 #reduceActionForSequence2: 3652610 false ) 
	#(51 1 #reduceActionForKeywordPattern1: 3790849 false ) 
	#(52 1 #reduceActionForStatementList1: 3840001 false ) 
	#(53 1 #liftFirstValue: 3939330 false ) 
	#(54 1 #liftFirstValue: 4020226 false ) 
	#(55 1 #liftFirstValue: 4121604 false ) 
	#(60 1 #reduceActionForKeywordMessageSend1: 4449281 false ) 
	#(60 1 #liftFirstValue: 4449282 false ) 
	#(65 1 #reduceActionForKeywordMessageSend1: 4702209 false ) 
	#(65 1 #liftFirstValue: 4702210 false ) 
	#(68 1 #reduceActionForKeywordMessageSend1: 4945921 false ) 
	#(72 1 #liftFirstValue: 5229569 false ) 
	#(68 1 #liftFirstValue: 4945922 false ) 
	#(72 1 #liftFirstValue: 5229571 false ) 
	#(72 1 #liftFirstValue: 5229572 false ) 
	#(72 1 #liftFirstValue: 5229570 false ) 
	#(80 1 #liftFirstValue: 5917697 false ) 
	#(80 1 #liftFirstValue: 5917698 false ) 
	#(80 1 #liftFirstValue: 5917699 false ) 
	#(80 1 #liftFirstValue: 5917700 false ) 
	#(80 1 #liftFirstValue: 5917701 false ) 
	#(80 1 #liftFirstValue: 5917702 false ) 
	#(80 1 #liftFirstValue: 5917703 false ) 
	#(80 1 #liftFirstValue: 5917704 false ) 
	#(71 1 #liftFirstValue: 5142529 false ) 
	#(71 1 #liftFirstValue: 5142530 false ) 
	#(71 1 #liftFirstValue: 5142532 false ) 
	#(71 1 #liftFirstValue: 5142531 false ) 
	#(97 1 #reduceActionForNamedVariable1: 7298049 false ) 
	#(90 1 #reduceActionForSymbolLiteral1: 6958081 false ) 
	#(48 1 #reduceActionForSequence3: 3652611 false ) 
	#(72 1 #reduceActionForValue6: 5229574 false ) 
	#(109 1 #reduceActionForNothing1: 8363009 false ) 
	#(99 2 #reduceActionForName1: 7389185 false ) 
	#(100 2 #reduceActionForKeyword1: 7644161 false ) 
	#(38 2 #reduceActionForMethodPattern2: 2661378 false ) 
	#(38 2 #reduceActionForMethodPattern4: 2661380 false ) 
	#(37 2 #reduceActionForMethod1: 2595841 false ) 
	#(40 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 2912258 false ) 
	#(39 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 2912257 false ) 
	#(38 2 #reduceActionForMethodPattern4: 2661381 false ) 
	#(53 2 #reduceActionForStatement1: 3939329 false ) 
	#(45 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 3146753 false ) 
	#(43 2 #reduceActionForPragma3: 3054595 false ) 
	#(73 2 #reduceActionForArray1: 5389313 false ) 
	#(75 0 #reduceActionFor__period___period__Assignment__value___1: 5443585 false ) 
	#(78 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 5672961 false ) 
	#(105 2 #liftSecondValue: 8110081 false ) 
	#(101 2 #reduceActionForSymbol4: 7919620 false ) 
	#(101 2 #reduceActionForSymbol4: 7919618 false ) 
	#(103 0 #reduceActionForVariable__variable__1: 7968769 false ) 
	#(104 1 #reduceActionForPragma__pragma__1: 8054785 false ) 
	#(101 2 #reduceActionForSymbol3: 7919619 false ) 
	#(47 2 #reduceActionForMethodSequence13: 3437581 false ) 
	#(47 2 #reduceActionForMethodSequence10: 3437578 false ) 
	#(47 2 #reduceActionForMethodSequence11: 3437579 false ) 
	#(42 2 #reduceActionForPragma__pragma__2: 3034114 false ) 
	#(47 2 #reduceActionForMethodSequence5: 3437573 false ) 
	#(48 2 #reduceActionForSequence6: 3652614 false ) 
	#(48 2 #reduceActionForSequence7: 3652615 false ) 
	#(51 2 #reduceActionForStatements2: 3790850 false ) 
	#(55 2 #reduceActionForCascade1: 4121601 false ) 
	#(58 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 4320257 false ) 
	#(56 1 #reduceActionForKeywordPattern1: 4299777 false ) 
	#(61 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4536321 false ) 
	#(64 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 4640769 false ) 
	#(62 1 #reduceActionForKeywordMessage1: 4622337 false ) 
	#(66 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4786177 false ) 
	#(55 2 #reduceActionForCascade1: 4121602 false ) 
	#(69 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 5016577 false ) 
	#(70 1 #reduceActionForUnaryMessage1: 5097473 false ) 
	#(55 2 #reduceActionForCascade1: 4121603 false ) 
	#(84 0 #reduceActionForVariable__variable__1: 6262785 false ) 
	#(48 2 #reduceActionForSequence4: 3652612 false ) 
	#(38 3 #reduceActionForMethodPattern6: 2661382 false ) 
	#(49 3 #reduceActionForTemporaries1: 3716097 false ) 
	#(50 2 #reduceActionForPragma__pragma__2: 3748866 false ) 
	#(43 3 #reduceActionForPragma2: 3054594 false ) 
	#(45 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 3146754 false ) 
	#(43 3 #reduceActionForPragma1: 3054593 false ) 
	#(44 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 3146754 false ) 
	#(44 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 3146753 false ) 
	#(43 3 #reduceActionForPragma4: 3054596 false ) 
	#(73 3 #reduceActionForArray2: 5389314 false ) 
	#(77 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 5672961 false ) 
	#(79 2 #reduceActionForBlockArgs2: 5844994 false ) 
	#(76 3 #reduceActionForBlock2: 5540866 false ) 
	#(78 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 5672962 false ) 
	#(72 3 #reduceActionForValue5: 5229573 false ) 
	#(86 3 #reduceActionForByteArrayLiteral1: 6714369 false ) 
	#(88 1 #liftFirstValue: 6833153 false ) 
	#(87 2 #reduceActionForPragma__pragma__2: 6765570 false ) 
	#(88 1 #reduceActionForValue6: 6833154 false ) 
	#(106 1 #liftFirstValue: 8138753 false ) 
	#(107 2 #liftFirstValue: 8138754 false ) 
	#(101 3 #reduceActionForSymbol1: 7919617 false ) 
	#(104 2 #reduceActionForPragma__pragma__2: 8054786 false ) 
	#(47 3 #reduceActionForMethodSequence1: 3437569 false ) 
	#(47 3 #reduceActionForMethodSequence14: 3437582 false ) 
	#(47 3 #reduceActionForMethodSequence15: 3437583 false ) 
	#(47 3 #reduceActionForMethodSequence12: 3437580 false ) 
	#(47 3 #reduceActionForMethodSequence6: 3437574 false ) 
	#(47 3 #reduceActionForMethodSequence7: 3437575 false ) 
	#(48 3 #reduceActionForSequence8: 3652616 false ) 
	#(52 3 #reduceActionForStatementList2: 3840002 false ) 
	#(57 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4320257 false ) 
	#(59 1 #liftFirstValue: 4377601 false ) 
	#(59 1 #liftFirstValue: 4377602 false ) 
	#(59 1 #liftFirstValue: 4377603 false ) 
	#(58 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 4320258 false ) 
	#(67 2 #reduceActionForBinaryMessage1: 4870145 false ) 
	#(64 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 4640770 false ) 
	#(63 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4640769 false ) 
	#(54 3 #reduceActionForAssignment1: 4020225 false ) 
	#(94 0 #reduceActionForEndLiteralArray1: 7166977 false ) 
	#(73 4 #reduceActionForArray3: 5389315 false ) 
	#(75 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 5443586 false ) 
	#(76 4 #reduceActionForBlock1: 5540865 false ) 
	#(76 4 #reduceActionForBlock3: 5540867 false ) 
	#(103 2 #reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart___2: 7968770 false ) 
	#(47 4 #reduceActionForMethodSequence2: 3437570 false ) 
	#(47 4 #reduceActionForMethodSequence3: 3437571 false ) 
	#(47 4 #reduceActionForMethodSequence16: 3437584 false ) 
	#(47 4 #reduceActionForMethodSequence8: 3437576 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6340611 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6340610 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6340612 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6340614 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6340613 false ) 
	#(85 1 #liftFirstValue: 6340609 false ) 
	#(84 2 #reduceActionForPragma__pragma__2: 6262786 false ) 
	#(85 1 #reduceActionForValue6: 6340616 false ) 
	#(73 5 #reduceActionForArray4: 5389316 false ) 
	#(74 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 5443585 false ) 
	#(47 5 #reduceActionForMethodSequence4: 3437572 false ) 
	#(83 5 #reduceActionForArrayLiteral1: 6191105 false ) 
	#(102 3 #reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart__1: 7968769 false ) 
	#(85 3 #reduceActionForArrayLiteralValue7: 6340615 false )
	).
]

{ #category : 'generated-accessing' }
GtPharoParser class >> scannerClass [
	^GtPharoScanner
]

{ #category : 'generated' }
GtPharoParser class >> startingStateForKeyword [
	^ 7
]

{ #category : 'generated' }
GtPharoParser class >> startingStateForKeywordMessageSend [
	^ 5
]

{ #category : 'generated' }
GtPharoParser class >> startingStateForMethod [
	^ 1
]

{ #category : 'generated' }
GtPharoParser class >> startingStateForMethodPattern [
	^ 4
]

{ #category : 'generated' }
GtPharoParser class >> startingStateForMethodSequence [
	^ 2
]

{ #category : 'generated' }
GtPharoParser class >> startingStateForName [
	^ 6
]

{ #category : 'generated' }
GtPharoParser class >> startingStateForStatement [
	^ 3
]

{ #category : 'generated' }
GtPharoParser class >> symbolNames [
	^ #('<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' '<self>' '<super>' '<thisContext>' '<symbolHash>' 'B e g i n' 'Method' 'MethodPattern' '(Keyword ''selectorPart'' Variable ''variable'')' '(Keyword ''selectorPart'' Variable ''variable'')+' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(Keyword ''selectorPart'' (Literal ''value'' | Variable ''value''))' '(Keyword ''selectorPart'' (Literal ''value'' | Variable ''value''))+' 'KeywordPattern' 'MethodSequence' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '(Keyword ''selectorPart'' BinaryMessageSend ''value'')' '(Keyword ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'Variable' 'Value' 'Array' '(<period> ''period'' Assignment ''value'')' '(<period> ''period'' Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' 'SelfVariable' 'SuperVariable' 'NamedVariable' 'ThisContextVariable' 'Name' 'Keyword' 'Symbol' '(<colon>''symbolPart''<colon> ''symbolPart''Name''symbolPart'')' '(<colon>''symbolPart''<colon> ''symbolPart''Name''symbolPart'')*' 'Keyword''symbolPart''+' 'Period' '(<period> ''period'')' '(<period> ''period'')*' 'NothingToken' 'Nothing' 'E O F' 'error')
]

{ #category : 'generated' }
GtPharoParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoVariableNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #GtPharoSelfVariableNode #GtPharoSuperVariableNode #GtPharoNamedVariableNode #GtPharoThisContextVariableNode #GtPharoNameNode #GtPharoKeywordNode #GtPharoSymbolNode #OrderedCollection #OrderedCollection #OrderedCollection nil #SmaCCToken nil nil #GtPharoNothingNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : 'generated' }
GtPharoParser class >> transitionTable [
^#(
#[1 0 33 0 4 0 37 0 24 0 41 0 25 0 45 0 37 0 49 0 38 0 53 0 39 0 57 0 40 0 61 0 46 0 65 0 99 0 69 0 100] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 85 0 6 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 109 0 13 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 0 149 0 41 0 153 0 42 0 157 0 43 0 161 0 47 0 161 0 48 0 169 0 49 0 173 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 41 0 105 0 10 0 110 1 45 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 1 49 0 53 1 49 0 54 1 49 0 55 1 49 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[1 0 33 0 4 0 37 0 24 0 41 0 25 1 53 0 38 0 53 0 39 0 57 0 40 0 61 0 46 0 65 0 99 0 69 0 100] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 1 57 0 60 1 61 0 61 0 201 0 65 1 65 0 66 0 209 0 68 1 69 0 69 0 209 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 209 0 95 0 209 0 96 0 209 0 97 0 209 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[1 0 33 0 4 1 77 0 99] 
#[1 0 37 0 24 1 81 0 100] 
#[1 0 14 0 1 0 14 0 2 0 14 0 3 0 14 0 4 0 14 0 6 0 14 0 7 0 14 0 8 0 14 0 9 0 14 0 10 0 14 0 11 0 14 0 12 0 14 0 13 0 14 0 14 0 14 0 15 0 14 0 16 0 14 0 17 0 14 0 18 0 14 0 19 0 14 0 20 0 14 0 21 0 14 0 22 0 14 0 23 0 14 0 24 0 14 0 25 0 14 0 26 0 14 0 27 0 14 0 28 0 14 0 32 0 14 0 33 0 14 0 34 0 14 0 35 1 85 0 108 1 89 0 109 0 14 0 110 0 14 0 111] 
#[1 0 14 0 1 0 14 0 2 0 14 0 3 0 14 0 4 0 14 0 7 0 14 0 8 0 14 0 9 0 14 0 10 0 14 0 11 0 14 0 14 0 14 0 15 0 14 0 16 0 14 0 18 0 14 0 19 0 14 0 20 0 14 0 21 0 14 0 22 0 14 0 23 0 14 0 24 0 14 0 25 0 14 0 26 0 14 0 28 0 14 0 32 0 14 0 33 0 14 0 34 0 14 0 35 1 85 0 108 1 93 0 109 0 14 0 110 0 14 0 111] 
#[1 0 33 0 4 0 133 0 32 0 137 0 33 0 141 0 34 1 97 0 71 1 97 0 95 1 97 0 96 1 97 0 97 1 97 0 98 1 33 0 99 1 101 0 111] 
#[0 0 0 0 110] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 85 0 6 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 109 0 13 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 0 149 0 41 0 153 0 42 0 157 0 43 1 105 0 47 1 105 0 48 0 169 0 49 0 173 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 41 0 105 0 10 0 110 1 45 0 111] 
#[0 0 18 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 24 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[1 0 22 0 1 0 22 0 2 0 22 0 3 0 22 0 4 0 22 0 6 0 22 0 7 0 22 0 8 0 22 0 9 0 22 0 10 0 22 0 12 0 22 0 13 0 22 0 15 0 22 0 16 0 22 0 18 0 22 0 19 0 22 0 20 0 37 0 24 0 22 0 28 0 22 0 32 0 22 0 33 0 22 0 34 0 22 0 35 1 109 0 39 1 113 0 100 0 22 0 110 0 22 0 111] 
#[0 0 26 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 30 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[1 0 33 0 4 0 133 0 32 0 137 0 33 0 141 0 34 1 117 0 71 1 117 0 95 1 117 0 96 1 117 0 97 1 117 0 98 1 33 0 99 1 121 0 111] 
#[0 0 34 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 38 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 42 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[1 0 46 0 4 0 46 0 6 0 46 0 32 0 46 0 33 0 46 0 34 1 125 0 50] 
#[0 0 50 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 54 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 58 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 62 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 1 129 0 54 1 129 0 55 1 129 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[1 0 33 0 4 0 37 0 24 1 133 0 44 1 137 0 45 1 141 0 99 1 145 0 100 1 149 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 1 153 0 23 1 157 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 1 161 0 54 1 161 0 55 1 161 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[1 0 66 0 1 0 66 0 2 0 66 0 3 0 66 0 4 0 66 0 6 0 66 0 7 0 66 0 8 0 66 0 9 0 66 0 10 0 66 0 12 0 66 0 15 0 66 0 16 1 165 0 17 0 66 0 18 0 66 0 19 0 66 0 20 0 66 0 22 0 66 0 28 0 66 0 32 0 66 0 33 0 66 0 34 0 66 0 35 1 169 0 77 1 173 0 78 1 177 0 79 0 66 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 1 181 0 54 1 181 0 55 1 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[1 0 70 0 9 0 70 0 10 0 70 0 22 1 185 0 87 0 70 0 111] 
#[1 0 74 0 1 0 74 0 2 0 74 0 3 0 74 0 4 0 74 0 7 0 74 0 8 0 74 0 9 0 74 0 10 0 74 0 12 0 74 0 15 0 74 0 16 0 74 0 18 0 74 0 19 0 74 0 20 0 74 0 22 0 74 0 28 0 74 0 32 0 74 0 33 0 74 0 34 0 74 0 35 1 189 0 107 0 74 0 110 0 74 0 111] 
#[0 0 78 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 82 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 86 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[1 0 33 0 4 1 193 0 7 0 37 0 24 1 197 0 25 1 201 0 99 1 205 0 100 1 209 0 104] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 85 0 6 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 1 213 0 49 1 217 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 221 0 105 0 90 0 110 1 45 0 111] 
#[1 0 94 0 1 0 94 0 2 0 94 0 3 0 94 0 4 0 94 0 6 0 94 0 7 0 94 0 8 0 94 0 9 0 94 0 10 0 94 0 12 0 109 0 13 0 94 0 15 0 94 0 16 0 94 0 18 0 94 0 19 0 94 0 20 0 94 0 28 0 94 0 32 0 94 0 33 0 94 0 34 0 94 0 35 1 225 0 43 0 94 0 110 0 94 0 111] 
#[0 0 98 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 0 0 110] 
#[0 0 102 0 110] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 109 0 13 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 1 229 0 41 0 153 0 42 0 157 0 43 1 233 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 237 0 105 0 106 0 110 1 45 0 111] 
#[0 0 110 0 22 0 110 0 111] 
#[1 0 114 0 22 0 129 0 28 1 241 0 105 0 114 0 110 0 114 0 111] 
#[0 0 118 0 22 0 28 0 110 0 111] 
#[0 0 122 0 22 0 28 0 110 0 111] 
#[0 0 126 0 21 0 22 0 23 0 28 0 110 0 111] 
#[0 0 130 0 21 0 22 0 23 0 28 0 110 0 111] 
#[1 0 134 0 21 0 134 0 22 0 134 0 23 1 245 0 26 0 134 0 28 1 249 0 56 1 253 0 57 2 1 0 58 0 134 0 110 0 134 0 111] 
#[1 0 138 0 21 0 138 0 22 0 138 0 23 0 37 0 24 2 5 0 25 0 138 0 28 2 9 0 62 2 13 0 63 2 17 0 64 2 21 0 67 2 25 0 100 0 138 0 110 0 138 0 111] 
#[1 0 142 0 21 0 142 0 22 0 142 0 23 0 142 0 24 0 142 0 25 1 245 0 26 0 142 0 28 2 29 0 56 1 253 0 57 2 1 0 58 0 142 0 110 0 142 0 111] 
#[1 0 33 0 4 0 146 0 21 0 146 0 22 0 146 0 23 0 146 0 24 0 146 0 25 0 146 0 26 0 146 0 28 2 33 0 70 2 37 0 99 0 146 0 110 0 146 0 111] 
#[1 0 150 0 4 0 150 0 21 0 150 0 22 0 150 0 23 0 150 0 24 0 150 0 25 1 245 0 26 0 150 0 28 2 41 0 56 1 253 0 57 2 1 0 58 0 150 0 110 0 150 0 111] 
#[1 0 154 0 4 0 154 0 21 0 154 0 22 0 154 0 23 0 154 0 24 0 154 0 25 2 45 0 27 0 154 0 28 0 154 0 110 0 154 0 111] 
#[0 0 158 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 0 162 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 0 166 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 0 170 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 0 174 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 178 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 182 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 186 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 190 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 194 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 198 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 0 202 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 2 49 0 19] 
#[0 0 206 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 210 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 214 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 218 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 222 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 226 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 230 0 22 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 53 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 0 230 0 110 0 7 0 111] 
#[0 0 234 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 0 0 0 110] 
#[0 0 0 0 110] 
#[0 0 0 0 110] 
#[0 0 134 0 110] 
#[0 0 142 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 0 150 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 0 154 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 0 0 0 110] 
#[0 0 0 0 110] 
#[0 0 238 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 242 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 246 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 250 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 0 254 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 1 2 0 110] 
#[0 1 6 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 24 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[1 0 33 0 4 0 133 0 32 0 137 0 33 0 141 0 34 1 117 0 71 1 117 0 95 1 117 0 96 1 117 0 97 1 117 0 98 1 33 0 99 2 57 0 111] 
#[0 1 10 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 24 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 1 14 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[1 0 33 0 4 2 61 0 6 0 133 0 32 0 137 0 33 0 141 0 34 2 65 0 71 2 65 0 95 2 65 0 96 2 65 0 97 2 65 0 98 1 33 0 99] 
#[0 1 18 0 22 0 28 0 110 0 111] 
#[0 1 22 0 14 0 24] 
#[1 2 69 0 14 0 37 0 24 2 73 0 44 1 145 0 100] 
#[0 2 77 0 14] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 81 0 71 2 85 0 80 2 85 0 81 2 85 0 82 2 85 0 83 2 85 0 86 2 85 0 89 2 85 0 90 2 85 0 91 2 85 0 92 1 13 0 93 2 81 0 95 2 81 0 96 2 81 0 97 2 81 0 98 1 33 0 99 1 37 0 101] 
#[1 1 26 0 1 1 26 0 2 1 26 0 3 1 26 0 4 1 26 0 6 1 26 0 7 1 26 0 8 1 26 0 9 1 26 0 10 1 26 0 12 1 26 0 13 2 89 0 14 1 26 0 15 1 26 0 16 1 26 0 18 1 26 0 19 1 26 0 20 1 26 0 28 1 26 0 32 1 26 0 33 1 26 0 34 1 26 0 35 1 26 0 110 1 26 0 111] 
#[0 1 30 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 2 93 0 23] 
#[1 1 34 0 23 1 34 0 28 2 97 0 75] 
#[1 0 33 0 4 0 133 0 32 0 137 0 33 0 141 0 34 2 101 0 71 2 101 0 95 2 101 0 96 2 101 0 97 2 101 0 98 1 33 0 99] 
#[0 1 38 0 6 0 17 0 22] 
#[1 2 105 0 6 1 165 0 17 2 109 0 22 2 113 0 77] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 85 0 6 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 10 0 22 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 117 0 48 2 121 0 49 0 173 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 41 0 105 0 11 0 111] 
#[0 2 125 0 21] 
#[1 0 97 0 9 0 101 0 10 2 129 0 22 2 137 0 82 2 137 0 88 2 141 0 111] 
#[1 1 42 0 1 1 42 0 2 1 42 0 3 1 42 0 4 1 42 0 7 1 42 0 8 1 42 0 9 1 42 0 10 1 42 0 12 1 42 0 15 1 42 0 16 1 42 0 18 1 42 0 19 1 42 0 20 1 42 0 22 2 149 0 28 1 42 0 32 1 42 0 33 1 42 0 34 1 42 0 35 2 149 0 106 1 42 0 110 1 42 0 111] 
#[0 1 46 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 1 50 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[1 1 54 0 1 1 54 0 2 1 54 0 3 1 54 0 4 1 54 0 7 1 54 0 8 1 54 0 9 1 54 0 10 1 54 0 11 1 54 0 14 1 54 0 17 1 54 0 18 1 54 0 19 1 54 0 20 1 54 0 21 1 54 0 22 1 54 0 23 1 54 0 24 1 54 0 25 1 54 0 26 1 54 0 28 1 54 0 35 2 153 0 103 1 54 0 110 1 54 0 111] 
#[0 1 58 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[1 1 62 0 1 1 62 0 2 1 62 0 3 1 62 0 4 1 62 0 7 1 62 0 8 1 62 0 9 1 62 0 10 1 62 0 11 1 62 0 14 1 62 0 18 1 62 0 19 1 62 0 20 1 62 0 21 1 62 0 22 1 62 0 23 0 15 0 24 1 62 0 25 1 62 0 26 1 62 0 28 1 62 0 35 2 157 0 100 1 62 0 110 1 62 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 109 0 13 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 161 0 41 0 153 0 42 0 157 0 43 2 165 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 2 169 0 105 1 66 0 110 1 45 0 111] 
#[0 1 70 0 110] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 173 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 74 0 110 1 45 0 111] 
#[0 1 78 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 177 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 2 181 0 105 1 82 0 110 1 45 0 111] 
#[0 1 86 0 22 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 1 90 0 22 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 185 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 90 0 110 0 19 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 1 94 0 22 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 189 0 53 2 189 0 54 2 189 0 55 2 189 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 94 0 110 0 23 0 111] 
#[1 0 33 0 4 0 37 0 24 2 5 0 25 2 193 0 59 2 193 0 62 2 13 0 63 2 17 0 64 2 193 0 67 2 193 0 70 2 37 0 99 2 25 0 100] 
#[0 1 98 0 21 0 22 0 23 0 28 0 110 0 111] 
#[0 1 102 0 21 0 22 0 23 0 26 0 28 0 110 0 111] 
#[1 1 106 0 21 1 106 0 22 1 106 0 23 1 245 0 26 1 106 0 28 2 209 0 57 1 106 0 110 1 106 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 213 0 68 1 69 0 69 2 213 0 71 2 213 0 72 2 213 0 73 2 213 0 76 2 213 0 80 2 213 0 81 2 213 0 82 2 213 0 83 2 213 0 86 2 213 0 89 2 213 0 90 2 213 0 91 2 213 0 92 1 13 0 93 2 213 0 95 2 213 0 96 2 213 0 97 2 213 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[0 1 110 0 21 0 22 0 23 0 26 0 28 0 110 0 111] 
#[0 1 114 0 21 0 22 0 23 0 24 0 26 0 28 0 110 0 111] 
#[1 1 118 0 21 1 118 0 22 1 118 0 23 0 37 0 24 1 118 0 26 1 118 0 28 2 217 0 63 2 25 0 100 1 118 0 110 1 118 0 111] 
#[0 1 122 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 221 0 65 1 65 0 66 0 209 0 68 1 69 0 69 0 209 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 209 0 95 0 209 0 96 0 209 0 97 0 209 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[0 1 126 0 21 0 22 0 23 0 28 0 110 0 111] 
#[0 1 130 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 1 134 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 1 138 0 21 0 22 0 23 0 28 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 2 225 0 54 2 225 0 55 2 225 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[1 1 142 0 1 1 142 0 2 1 142 0 3 1 142 0 4 1 142 0 7 1 142 0 8 1 142 0 9 1 142 0 10 1 142 0 11 1 142 0 18 1 142 0 19 1 142 0 20 1 142 0 21 1 142 0 25 1 142 0 26 1 142 0 28 1 142 0 35 2 229 0 84 1 142 0 111] 
#[0 1 146 0 22 0 110 0 111] 
#[0 1 150 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 1 154 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 1 158 0 4 0 6 0 32 0 33 0 34] 
#[0 1 162 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 1 166 0 14 0 24] 
#[0 1 170 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 1 174 0 14 0 24] 
#[0 1 178 0 14 0 24] 
#[0 1 182 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 1 186 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[1 2 233 0 23 2 237 0 28 2 241 0 74] 
#[0 1 190 0 6 0 17 0 22] 
#[0 1 194 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 32 0 33 0 34 0 35 0 111] 
#[0 1 198 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 1 202 0 6 0 17 0 22] 
#[1 2 245 0 22 2 249 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 106 0 22 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 1 233 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 237 0 105 0 27 0 111] 
#[0 1 206 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 1 210 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 1 214 0 9 0 10 0 22 0 111] 
#[0 1 218 0 9 0 10 0 22 0 111] 
#[0 1 222 0 9 0 10 0 22 0 111] 
#[0 1 226 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[0 1 230 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 32 0 33 0 34 0 35 0 110 0 111] 
#[1 1 234 0 1 1 234 0 2 1 234 0 3 1 234 0 4 1 234 0 7 1 234 0 8 1 234 0 9 1 234 0 10 1 234 0 11 1 234 0 14 2 253 0 17 1 234 0 18 1 234 0 19 1 234 0 20 1 234 0 21 1 234 0 22 1 234 0 23 1 234 0 24 1 234 0 25 1 234 0 26 1 234 0 28 1 234 0 35 3 1 0 102 1 234 0 110 1 234 0 111] 
#[0 1 238 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 129 0 28 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 3 5 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 3 9 0 105 1 242 0 110 1 45 0 111] 
#[0 1 246 0 110] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 3 13 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 250 0 110 1 45 0 111] 
#[0 1 254 0 110] 
#[0 2 2 0 110] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 3 17 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 2 6 0 110 1 45 0 111] 
#[0 2 10 0 22 0 110 0 111] 
#[0 2 14 0 22 0 28 0 110 0 111] 
#[0 2 18 0 21 0 22 0 23 0 26 0 28 0 110 0 111] 
#[0 2 22 0 21 0 22 0 23 0 26 0 28 0 110 0 111] 
#[0 2 26 0 21 0 22 0 23 0 26 0 28 0 110 0 111] 
#[0 2 30 0 21 0 22 0 23 0 26 0 28 0 110 0 111] 
#[0 2 34 0 21 0 22 0 23 0 26 0 28 0 110 0 111] 
#[1 0 33 0 4 2 38 0 21 2 38 0 22 2 38 0 23 2 38 0 24 2 38 0 25 2 38 0 26 2 38 0 28 2 33 0 70 2 37 0 99 2 38 0 110 2 38 0 111] 
#[0 2 42 0 21 0 22 0 23 0 24 0 26 0 28 0 110 0 111] 
#[1 2 46 0 21 2 46 0 22 2 46 0 23 2 46 0 24 2 5 0 25 2 46 0 26 2 46 0 28 2 21 0 67 2 46 0 110 2 46 0 111] 
#[0 2 50 0 21 0 22 0 23 0 28 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 3 21 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 3 25 0 11 3 29 0 18 0 6 0 19 0 125 0 20 2 54 0 21 3 33 0 25 3 37 0 26 3 41 0 28 0 145 0 35 3 49 0 80 3 49 0 81 3 49 0 82 3 49 0 83 3 49 0 85 3 49 0 86 3 49 0 89 3 49 0 90 3 49 0 91 3 49 0 92 1 13 0 93 3 53 0 94 1 37 0 101 3 57 0 111] 
#[0 2 58 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 3 61 0 23 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 3 65 0 54 3 65 0 55 3 65 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 1 45 0 111] 
#[0 2 62 0 23 0 28] 
#[0 2 66 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 2 70 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 3 69 0 17] 
#[0 2 74 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 2 78 0 110] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 0 33 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 0 105 0 12 0 113 0 15 0 117 0 16 0 121 0 18 0 6 0 19 0 125 0 20 0 133 0 32 0 137 0 33 0 141 0 34 0 145 0 35 3 73 0 51 0 177 0 52 0 181 0 53 0 181 0 54 0 181 0 55 0 181 0 60 0 197 0 61 0 201 0 65 0 205 0 66 0 209 0 68 0 213 0 69 0 217 0 71 0 209 0 72 0 209 0 73 0 209 0 76 0 209 0 80 0 209 0 81 0 209 0 82 0 209 0 83 0 209 0 86 0 209 0 89 0 209 0 90 0 209 0 91 0 209 0 92 1 13 0 93 0 217 0 95 0 217 0 96 0 217 0 97 0 217 0 98 1 33 0 99 1 37 0 101 2 82 0 110 1 45 0 111] 
#[0 2 86 0 110] 
#[0 2 90 0 110] 
#[0 2 94 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111] 
#[0 2 98 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111] 
#[1 1 142 0 1 1 142 0 2 1 142 0 3 1 142 0 4 1 142 0 7 1 142 0 8 1 142 0 9 1 142 0 10 1 142 0 11 1 142 0 18 1 142 0 19 1 142 0 20 1 142 0 21 1 142 0 25 1 142 0 26 1 142 0 28 1 142 0 35 3 77 0 84 1 142 0 111] 
#[0 2 102 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111] 
#[0 2 106 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111] 
#[0 2 110 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111] 
#[0 2 114 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111] 
#[0 2 118 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111] 
#[0 3 81 0 21] 
#[0 2 122 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111] 
#[0 2 126 0 4 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 110 0 111] 
#[0 2 130 0 23 0 28] 
#[1 0 33 0 4 3 85 0 99] 
#[0 2 134 0 110] 
#[1 0 73 0 1 0 77 0 2 0 81 0 3 3 21 0 4 0 89 0 7 0 93 0 8 0 97 0 9 0 101 0 10 3 25 0 11 3 29 0 18 0 6 0 19 0 125 0 20 3 89 0 21 3 33 0 25 3 37 0 26 3 41 0 28 0 145 0 35 3 49 0 80 3 49 0 81 3 49 0 82 3 49 0 83 3 49 0 85 3 49 0 86 3 49 0 89 3 49 0 90 3 49 0 91 3 49 0 92 1 13 0 93 1 37 0 101 3 57 0 111] 
#[0 2 138 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 2 142 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 28 0 35 0 110 0 111] 
#[0 2 146 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 111]
	).
]

{ #category : 'private' }
GtPharoParser >> actionsForCurrentToken [
	| actions |
	actions := super actionsForCurrentToken.
	actions isEmpty
		ifTrue: [ (currentToken ids includes: scanner binaryId)
				ifTrue: [ (#('|' '<' '>') includes: currentToken value)
						ifTrue: [ self addActionsFor: scanner binaryId to: actions ]
						ifFalse: [ (#('||' '|||') includes: currentToken value)
								ifTrue: [ currentToken := currentToken class value: '|' start: currentToken startPosition ids: (Array with: scanner barId).
									self position: currentToken startPosition.
									actions := super actionsForCurrentToken ] ] ].
			(currentToken ids includes: scanner negativeNumberId)
				ifTrue: [ self addActionsFor: scanner binaryId to: actions.
					actions notEmpty
						ifTrue: [ currentToken := currentToken class value: '-' start: currentToken startPosition ids: (Array with: scanner binaryId).
							self position: currentToken startPosition ] ].
			(currentToken ids includes: scanner nameId)
				ifTrue: [ self addActionsFor: scanner nameId to: actions ].
			(currentToken ids includes: scanner nameAssignmentId)
				ifTrue: [ self addActionsFor: scanner nameId to: actions.
					actions notEmpty
						ifTrue:
							[ currentToken := currentToken class value: (currentToken value copyFrom: 1 to: currentToken value size - 2) start: currentToken startPosition ids: (Array with: scanner nameId).
							self position: scanner position - 2 ] ] ].
	^ actions
]

{ #category : 'private' }
GtPharoParser >> endLiteralArray [
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

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForArray1: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result rightBrace: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForArray2: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addToken: (nodes at: 2) to: result periods.
	result rightBrace: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForArray3: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addNode: (nodes at: 2) to: result values.
	result addTokens: ((nodes at: 3) at: 1) to: result periods.
	result addNodes: ((nodes at: 3) at: 2) to: result values.
	result rightBrace: (nodes at: 4).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForArray4: nodes [
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

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForArrayLiteral1: nodes [
	| result |
	result := GtPharoArrayLiteralNode new.
	result arrayStart: (nodes at: 2).
	result addNodes: (nodes at: 3) to: result values.
	result arrayStop: (nodes at: 5).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForArrayLiteralValue7: nodes [
	| result |
	result := GtPharoArrayLiteralNode new.
	result arrayStart: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result values.
	result arrayStop: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForAssignment1: nodes [
	| result |
	result := GtPharoAssignmentNode new.
	result variable: (nodes at: 1).
	result assignmentToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForBinaryMessage1: nodes [
	| result |
	result := GtPharoBinaryMessageNode new.
	result selectorPart: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForBlock1: nodes [
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

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForBlock2: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBracket: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForBlock3: nodes [
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

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForBlockArgs1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForBlockArgs2: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 1) at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForBooleanLiteral1: nodes [
	| result |
	result := GtPharoBooleanLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForByteArrayLiteral1: nodes [
	| result |
	result := GtPharoByteArrayLiteralNode new.
	result arrayStart: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result values.
	result arrayStop: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForCascade1: nodes [
	| result |
	result := GtPharoCascadeNode new.
	result receiver: ((nodes at: 1) at: 1).
	result addNode: ((nodes at: 1) at: 2) to: result messages.
	result addTokens: ((nodes at: 2) at: 1) to: result semicolons.
	result addNodes: ((nodes at: 2) at: 2) to: result messages.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForCharacterLiteral1: nodes [
	| result |
	result := GtPharoCharacterLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForEndLiteralArray1: nodes [
	self endLiteralArray.
	^ nil
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForKeyword1: nodes [
	| result |
	result := GtPharoKeywordNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result addObject: (nodes at: 2) to: result selectorParts.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordMessage1: nodes [
	| result |
	result := GtPharoKeywordMessageNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result values.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordMessageSend1: nodes [
	| result |
	result := GtPharoMessageSendNode new.
	result receiver: ((nodes at: 1) at: 1).
	result message: ((nodes at: 1) at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordPattern1: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethod1: nodes [
	| result |
	result := GtPharoMethodNode new.
	result pattern: (nodes at: 1).
	result body: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern1: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern2: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result variables.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern3: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern4: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern6: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addObject: (nodes at: 2) to: result selectorParts.
	result smaccError: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence10: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addObjects: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence11: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addObject: (nodes at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence12: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addObject: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence13: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence14: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence15: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addObject: (nodes at: 3) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence16: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addObject: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence1: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence2: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence3: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	result addObject: (nodes at: 4) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence4: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence5: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence6: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence7: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	result addObject: (nodes at: 3) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence8: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	result addObject: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence9: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForName1: nodes [
	| result |
	result := GtPharoNameNode new.
	result addObject: (nodes at: 1) to: result nameParts.
	result addObject: (nodes at: 2) to: result nameParts.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForNamedVariable1: nodes [
	| result |
	result := GtPharoNamedVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForNilLiteral1: nodes [
	| result |
	result := GtPharoNilLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForNothing1: nodes [
	| result |
	result := GtPharoNothingNode new.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForNumberLiteral1: nodes [
	| result |
	result := GtPharoNumberLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma1: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addNode: (nodes at: 2) to: result selectorParts.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma2: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addNodes: ((nodes at: 2) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 2) to: result values.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma3: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma4: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma__pragma__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma__pragma__2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSelfVariable1: nodes [
	| result |
	result := GtPharoSelfVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence1: nodes [
	| result |
	result := GtPharoSequenceNode new.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence2: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result statements.
	result addObjects: ((nodes at: 1) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence3: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addObject: (nodes at: 1) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence4: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addObject: (nodes at: 1) to: result periods.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addObjects: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence5: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence6: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addObjects: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence7: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addObject: (nodes at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence8: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addObject: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForStatement1: nodes [
	| result |
	result := GtPharoReturnNode new.
	result upArrow: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForStatementList1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForStatementList2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForStatements2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForStringLiteral1: nodes [
	| result |
	result := GtPharoStringLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSuperVariable1: nodes [
	| result |
	result := GtPharoSuperVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSwitchToLiteralArray1: nodes [
	self scope: #literalArray.
	^ #array
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbol1: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObject: (nodes at: 2) to: result symbolParts.
	result addObjects: (nodes at: 3) to: result symbolParts.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbol3: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObjects: (nodes at: 2) to: result symbolParts.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbol4: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObject: (nodes at: 2) to: result symbolParts.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbolLiteral1: nodes [
	| result |
	result := GtPharoSymbolLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForTemporaries1: nodes [
	| result |
	result := Array new: 3.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self addAll: (nodes at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForThisContextVariable1: nodes [
	| result |
	result := GtPharoThisContextVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForUnaryMessage1: nodes [
	| result |
	result := GtPharoUnaryMessageNode new.
	result selectorPart: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForValue5: nodes [
	| result |
	result := nodes at: 2.
	result addFirstToken: (nodes at: 1) to: result leftParens.
	result addToken: (nodes at: 3) to: result rightParens.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForValue6: nodes [
	| result |
	result := GtPharoErrorNode new.
	result smaccError: (nodes at: 1).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionForVariable__variable__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionFor_Keyword__selectorPart__Variable__variable__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionFor_Keyword__selectorPart__Variable__variable___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionFor_Keyword__selectorPart__Variable__variable___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	self add: (nodes at: 2) to: result.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart___2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	^ result
]

{ #category : 'generated-reduction actions' }
GtPharoParser >> reduceActionFor__period___period__Assignment__value___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

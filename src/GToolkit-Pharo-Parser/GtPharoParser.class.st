Class {
	#name : #GtPharoParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoParser class >> ambiguousTransitions [
^#(
#[ 0 89 0 114] 
#[ 0 174 2 109] 
#[ 0 89 0 174] 
#[ 0 250 0 254] 
#[ 1 30 1 145] 
#[ 1 145 1 218] 
#[ 2 109 2 110] 
#[ 0 89 2 110]
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> cacheId [
	^'2022-12-02T10:55:29.17116-06:00'
]

{ #category : #generated }
GtPharoParser class >> definitionComment [
"%glr;
%prefix GtPharo;
%suffix Node;
%root Program;
%start Method MethodSequence Statement MethodPattern KeywordMessageSend Variable Pragma;
%id <bar> <binary> <doubleLeftBrace> <doubleRightBrace> <templateNamePart> <doubleLeftBraceStart> <templateKeyword>
	<number> <negativeNumber> <bar> <name> <keyword> <nameAssignment> <leftBrace> <rightBrace>
	<rbNamePattern> <rbKeywordPattern> <rbLiteralArrayKeywordPattern> <rbPatternBlock> <template>;
%hierarchy Value (
	Array
	Assignment
	Block
	Cascade
	Error
	Literal
	MessageSend
	PatternMessageBlock
	TemplateVariable
	Variable
);
%hierarchy Literal (StringLiteral NumberLiteral CharacterLiteral SymbolLiteral ArrayLiteral BooleanLiteral NilLiteral);
%hierarchy ArrayLiteral (ByteArrayLiteral);
%hierarchy Message (UnaryMessage BinaryMessage KeywordMessage);
%hierarchy UnaryMessage (TemplateUnaryMessage);
%hierarchy KeywordMessage (TemplateKeywordMessage);
%hierarchy Sequence (MethodSequence);
%hierarchy Pragma (PragmaError TemplatePragma);
%hierarchy Block (BlockError);
%hierarchy MethodPattern (ErrorPattern TemplatePattern);
%hierarchy Variable (SelfVariable SuperVariable ThisContextVariable NamedVariable);
%ignore_variables leftParen rightParen leftBar rightBar leftBracket rightBracket semicolon colon period ;


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
	: \d
	;
default literalArray <negativeNumber>
	: \- <number>
	;
literalArray <literalArrayKeyword>
	: <keyword>+
	;
default literalArray <return>
	: \^
	;
default <lt>
	: \<
	;
default <gt>
	: \>
	;
default literalArray <leftBrace>
	: \{
	;
default literalArray <leftBracket>
	: \[
	;
default literalArray <colon>
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
default literalArray <rightBrace>
	: \}
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
Method
	: MethodPattern 'pattern' MethodSequence 'body' {{}}
	;
MethodPattern
	: <name> 'selectorPart' {{}}
	| <rbNamePattern> 'selectorPart' {{}}
	| <binary> 'selectorPart' Variable 'variable' {{}}
	| KeywordPattern {{}}
	| TemplatePattern
	| <binary> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| <keyword> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| (<keyword> 'selectorPart' Variable 'variable')+ <keyword> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	;
TemplatePattern
	: OnlyTemplate TemplateWithName {{}}
	| OnlyTemplate KeywordPattern? (TemplateKeywordPattern KeywordPattern?)+ {{}}
	;
TemplateWithName
	: TemplateNamePart 'part' (MidTemplate 'part' TemplateNameContinuationPart 'part'?)+
	| StartTemplate 'part' TemplateNameContinuationPart 'part'? (MidTemplate 'part' TemplateNameContinuationPart 'part'?)*
	;
TemplateKeywordPattern
	: TemplateKeyword Variable 'variable'
	;
TemplateKeyword
	: TemplateWithName (<templateKeyword> 'selectorPart' | <colon> 'selectorPart')
	;
TemplateNameContinuationPart
	: <templateNamePart> 'name' {{TemplateNamePart}}
	;
TemplateNamePart
	: <name> 'name' {{TemplateNamePart}}
	;
Pragmas
	: Pragma 'pragma'+
	;
Pragma
	:  <lt> 'lessThan' <name> 'selectorPart' <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' (<keyword> 'selectorPart' PragmaArgument)+ <gt> 'greaterThan' {{}}
	| TemplatePragma
	| <lt> 'lessThan' error 'smaccError' {{PragmaError}}
	| <lt> 'lessThan' error 'smaccError' <gt> 'greaterThan' {{PragmaError}}
	;
OnlyTemplate
	: <template> {nil}
	;
PragmaArgument
	: Literal 'value'
	| Variable 'value'
	;
TemplatePragma
	: OnlyTemplate <lt> 'lessThan' TemplateWithName <gt> 'greaterThan' {{}}
	| OnlyTemplate <lt> 'lessThan' (<keyword> 'selectorPart' PragmaArgument)+? (TemplateKeyword PragmaArgument (<keyword> 'selectorPart' PragmaArgument)+?)+ <gt> 'greaterThan' {{}}
	;
KeywordPattern
	: ((<keyword> 'selectorPart' | <rbKeywordPattern> 'selectorPart') Variable 'variable')+
	;
MethodSequence
	: Pragmas Temporaries Pragmas <period> 'period'+? Statements? {{}}
	| Temporaries Pragmas <period> 'period'+? Statements? {{}}
	| Pragmas Temporaries? <period> 'period'+? Statements? {{}}
	| Sequence
	;
Sequence
	: Temporaries? <period> 'period'+? Statements? {{}}
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
	: ((<keyword> 'selectorPart' | <rbKeywordPattern> 'selectorPart')  BinaryMessageSend 'value')+ {{}}
	| TemplateKeywordMessage
	;
TemplateKeywordMessage
	: OnlyTemplate (<keyword> 'selectorPart' BinaryMessageSend 'value')+? (TemplateKeyword BinaryMessageSend 'value' (<keyword> 'selectorPart' BinaryMessageSend 'value')+?)+ {{}}
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
	| <rbNamePattern> 'selectorPart' {{}}
	| TemplateUnaryMessage
	;
TemplateUnaryMessage
	: OnlyTemplate TemplateWithName {{}}
	;
Variable
	: ""self"" 'name' {{SelfVariable}}
	| ""super"" 'name' {{SuperVariable}}
	| ""thisContext"" 'name' {{ThisContextVariable}}
	| NamedVariable
	| TemplateVariable
	;
NamedVariable
	: <name> 'name' {{NamedVariable}}
	|  <rbNamePattern> 'name' {{}}
	;
TemplateVariable
	: OnlyTemplate TemplateWithName {{}}
	;
MidTemplate
	: <doubleLeftBrace> 'leftBraces' Assignment 'expression' <doubleRightBrace>'rightBraces' {{Template}}
	;
StartTemplate
	: <doubleLeftBraceStart> 'leftBraces' Assignment 'expression' <doubleRightBrace>'rightBraces' {{Template}}
	;
Value
	: Variable
	| Literal
	| Array
	| Block
	| <leftParen> 'leftParen' Assignment <rightParen> 'rightParen' {{Value}}
	| UnaryMessageSend 'node'? <rbPatternBlock> 'leftBrace' BlockArgs Sequence 'body' <rightBrace> 'rightBrace' {{PatternMessageBlock}}
	| error 'smaccError' {{Error}}
	;
Array
	: <leftBrace> 'leftBrace' (Assignment 'value' (<period> 'period'+ Assignment 'value')*)? <period> 'period'+? <rightBrace> 'rightBrace' {{}}
	;
Block
	: <leftBracket> 'leftBracket' BlockArgs Sequence 'body' <rightBracket> 'rightBracket' {{}}
	| <leftBracket> 'leftBracket' (<colon> 'colon' Variable 'variable')+ <rightBracket> 'rightBracket' {{}}
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
	| <rbLiteralArrayKeywordPattern> 'value' {{SymbolLiteral}}
	| <name> 'value' {{SymbolLiteral}}
	| <rbNamePattern> 'value' {{SymbolLiteral}}
	| <binary> 'value' {{SymbolLiteral}}
	| <period> 'value' {{SymbolLiteral}}
	| <return> 'value' {{SymbolLiteral}}
	| <semicolon> 'value' {{SymbolLiteral}}
	| <colon> 'value' {{SymbolLiteral}}
	| <leftBrace> 'value' {{SymbolLiteral}}
	| <rightBrace> 'value' {{SymbolLiteral}}
	| <leftBracket> 'value' {{SymbolLiteral}}
	| <rightBracket> 'value' {{SymbolLiteral}}
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
	: [self scope: #literalArray. #array]
	;
EndLiteralArray
	: [self endLiteralArray. nil]
	;"
]

{ #category : #'class initialization' }
GtPharoParser class >> initialize [
	self maxParallelParses: 50
]

{ #category : #generated }
GtPharoParser class >> reduceTable [
^#(
	#(122 0 #reduceActionForSwitchToLiteralArray1: 9773057 true) 
	#(67 0 #reduceActionForSequence1: 5024769 false) 
	#(38 1 #reduceActionForMethodPattern1: 2863105 false) 
	#(40 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3177473 false) 
	#(38 1 #liftFirstValue: 2863109 false) 
	#(38 1 #reduceActionForMethodPattern4: 2863108 false) 
	#(64 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4709377 false) 
	#(62 1 #reduceActionForKeywordPattern1: 4690945 false) 
	#(38 1 #reduceActionForMethodPattern1: 2863106 false) 
	#(57 1 #nil 4320257 false) 
	#(96 1 #reduceActionForVariable1: 6929409 false) 
	#(96 1 #reduceActionForVariable2: 6929410 false) 
	#(96 1 #reduceActionForVariable3: 6929411 false) 
	#(120 1 #reduceActionForBooleanLiteral1: 9669633 false) 
	#(120 1 #reduceActionForBooleanLiteral1: 9669634 false) 
	#(121 1 #reduceActionForNilLiteral1: 9736193 false) 
	#(97 1 #reduceActionForNamedVariable1: 7100417 false) 
	#(69 0 #reduceActionForVariable__variable__1: 5124097 false) 
	#(110 1 #reduceActionForStringLiteral1: 8381441 false) 
	#(119 1 #reduceActionForSymbolLiteral1: 9626625 false) 
	#(118 1 #reduceActionForCharacterLiteral1: 9577473 false) 
	#(111 1 #reduceActionForNumberLiteral1: 8424449 false) 
	#(111 1 #reduceActionForNumberLiteral1: 8424450 false) 
	#(108 0 #reduceActionForBlockArgs1: 8155137 false) 
	#(116 0 #reduceActionForVariable__variable__1: 9434113 false) 
	#(66 1 #reduceActionFor_period___period__1: 4847617 false) 
	#(65 1 #reduceActionForMethodSequence9: 4800521 false) 
	#(52 1 #reduceActionForKeywordPattern1: 3974145 false) 
	#(53 1 #reduceActionFor_period___period__1: 3985409 false) 
	#(54 1 #liftFirstValue: 4005891 false) 
	#(67 1 #reduceActionForSequence3: 5024771 false) 
	#(65 1 #liftFirstValue: 4800529 false) 
	#(67 1 #reduceActionForSequence5: 5024773 false) 
	#(67 1 #reduceActionForSequence2: 5024770 false) 
	#(70 1 #reduceActionForKeywordPattern1: 5166081 false) 
	#(71 1 #reduceActionForStatementList1: 5218305 false) 
	#(72 1 #liftFirstValue: 5320706 false) 
	#(73 1 #liftFirstValue: 5401602 false) 
	#(74 1 #liftFirstValue: 5502980 false) 
	#(79 1 #reduceActionForKeywordMessageSend1: 5830657 false) 
	#(79 1 #liftFirstValue: 5830658 false) 
	#(89 1 #reduceActionForKeywordMessageSend1: 6359041 false) 
	#(89 1 #liftFirstValue: 6359042 false) 
	#(92 1 #reduceActionForKeywordMessageSend1: 6602753 false) 
	#(101 1 #liftFirstValue: 7494657 false) 
	#(96 1 #liftFirstValue: 6929412 false) 
	#(96 1 #liftFirstValue: 6929413 false) 
	#(92 1 #liftFirstValue: 6602754 false) 
	#(101 1 #liftFirstValue: 7494659 false) 
	#(101 1 #liftFirstValue: 7494660 false) 
	#(101 1 #liftFirstValue: 7494658 false) 
	#(109 1 #liftFirstValue: 8227841 false) 
	#(109 1 #liftFirstValue: 8227842 false) 
	#(109 1 #liftFirstValue: 8227843 false) 
	#(109 1 #liftFirstValue: 8227844 false) 
	#(109 1 #liftFirstValue: 8227845 false) 
	#(109 1 #liftFirstValue: 8227846 false) 
	#(109 1 #liftFirstValue: 8227847 false) 
	#(109 1 #liftFirstValue: 8227848 false) 
	#(97 1 #reduceActionForNamedVariable1: 7100418 false) 
	#(101 1 #reduceActionForValue8: 7494664 false) 
	#(63 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4709377 false) 
	#(39 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 3177473 false) 
	#(38 2 #reduceActionForMethodPattern7: 2863111 false) 
	#(38 2 #reduceActionForMethodPattern3: 2863107 false) 
	#(38 2 #reduceActionForMethodPattern7: 2863110 false) 
	#(37 2 #reduceActionForMethod1: 2797569 false) 
	#(40 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3177474 false) 
	#(51 1 #reduceActionForTemplateNamePart1: 3914753 false) 
	#(43 1 #reduceActionForKeywordPattern1: 3380225 false) 
	#(41 2 #reduceActionForTemplatePattern2: 3292162 false) 
	#(41 2 #reduceActionForTemplatePattern1: 3292161 false) 
	#(42 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern__1: 3380225 false) 
	#(47 0 #reduceActionForVariable__variable__1: 3599361 false) 
	#(64 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4709378 false) 
	#(63 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4709378 false) 
	#(72 2 #reduceActionForStatement1: 5320705 false) 
	#(56 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4100097 false) 
	#(54 2 #reduceActionForPragma4: 4005892 false) 
	#(102 2 #reduceActionForArray1: 7790593 false) 
	#(104 0 #reduceActionFor__period___period___Assignment__value___1: 7844865 false) 
	#(107 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 8076289 false) 
	#(65 2 #reduceActionForMethodSequence11: 4800523 false) 
	#(65 2 #reduceActionForMethodSequence13: 4800525 false) 
	#(65 2 #reduceActionForMethodSequence10: 4800522 false) 
	#(53 2 #reduceActionForPragma__pragma__2: 3985410 false) 
	#(98 2 #reduceActionForTemplateVariable1: 7186433 false) 
	#(66 2 #reduceActionForPragma__pragma__2: 4847618 false) 
	#(67 2 #reduceActionForSequence4: 5024772 false) 
	#(65 2 #reduceActionForMethodSequence5: 4800517 false) 
	#(67 2 #reduceActionForSequence7: 5024775 false) 
	#(67 2 #reduceActionForSequence6: 5024774 false) 
	#(70 2 #reduceActionForStatements2: 5166082 false) 
	#(74 2 #reduceActionForCascade1: 5502977 false) 
	#(77 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5701633 false) 
	#(75 1 #reduceActionForKeywordPattern1: 5681153 false) 
	#(80 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 5917697 false) 
	#(83 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 6022145 false) 
	#(81 1 #reduceActionForKeywordMessage1: 6003713 false) 
	#(81 1 #liftFirstValue: 6003714 false) 
	#(90 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6443009 false) 
	#(74 2 #reduceActionForCascade1: 5502978 false) 
	#(94 1 #reduceActionForUnaryMessage1: 6754305 false) 
	#(93 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6673409 false) 
	#(94 1 #liftFirstValue: 6754307 false) 
	#(94 1 #reduceActionForUnaryMessage1: 6754306 false) 
	#(74 2 #reduceActionForCascade1: 5502979 false) 
	#(113 0 #reduceActionForVariable__variable__1: 8572929 false) 
	#(38 3 #reduceActionForMethodPattern8: 2863112 false) 
	#(43 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 3380226 false) 
	#(49 2 #reduceActionForTemplateKeyword2: 3729410 false) 
	#(49 2 #reduceActionForTemplateKeyword2: 3729409 false) 
	#(42 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern__2: 3380226 false) 
	#(48 2 #reduceActionForTemplateKeywordPattern1: 3662849 false) 
	#(46 1 #reduceActionForKeywordPattern1: 3476481 false) 
	#(44 2 #reduceActionForTemplateWithName1: 3431425 false) 
	#(45 1 #reduceActionFor_period___period__1: 3476481 false) 
	#(41 3 #reduceActionForTemplatePattern3: 3292163 false) 
	#(44 2 #reduceActionForTemplateWithName1: 3431426 false) 
	#(50 1 #reduceActionForTemplateNamePart1: 3830785 false) 
	#(68 3 #reduceActionForTemporaries1: 5091329 false) 
	#(69 2 #reduceActionForPragma__pragma__2: 5124098 false) 
	#(54 3 #reduceActionForPragma1: 4005889 false) 
	#(55 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4100097 false) 
	#(58 1 #liftFirstValue: 4357122 false) 
	#(58 1 #liftFirstValue: 4357121 false) 
	#(54 3 #reduceActionForPragma2: 4005890 false) 
	#(56 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4100098 false) 
	#(54 3 #reduceActionForPragma5: 4005893 false) 
	#(102 3 #reduceActionForArray2: 7790594 false) 
	#(106 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 8076289 false) 
	#(108 2 #reduceActionForBlockArgs2: 8155138 false) 
	#(105 3 #reduceActionForBlock2: 7944194 false) 
	#(107 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 8076290 false) 
	#(101 3 #reduceActionForValue5: 7494661 false) 
	#(115 3 #reduceActionForByteArrayLiteral1: 9382913 false) 
	#(117 1 #liftFirstValue: 9501697 false) 
	#(116 2 #reduceActionForPragma__pragma__2: 9434114 false) 
	#(117 1 #reduceActionForValue8: 9501698 false) 
	#(65 3 #reduceActionForMethodSequence12: 4800524 false) 
	#(65 3 #reduceActionForMethodSequence1: 4800513 false) 
	#(65 3 #reduceActionForMethodSequence15: 4800527 false) 
	#(65 3 #reduceActionForMethodSequence14: 4800526 false) 
	#(61 1 #reduceActionForKeywordPattern1: 4583425 false) 
	#(65 3 #reduceActionForMethodSequence7: 4800519 false) 
	#(65 3 #reduceActionForMethodSequence6: 4800518 false) 
	#(67 3 #reduceActionForSequence8: 5024776 false) 
	#(71 3 #reduceActionForStatementList2: 5218306 false) 
	#(76 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 5701633 false) 
	#(78 1 #liftFirstValue: 5758977 false) 
	#(78 1 #liftFirstValue: 5758978 false) 
	#(78 1 #liftFirstValue: 5758979 false) 
	#(77 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5701634 false) 
	#(82 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6022145 false) 
	#(91 2 #reduceActionForBinaryMessage1: 6526977 false) 
	#(86 1 #reduceActionForKeywordPattern1: 6248449 false) 
	#(84 2 #reduceActionForTemplateKeywordMessage1: 6152193 false) 
	#(88 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 6292481 false) 
	#(83 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 6022146 false) 
	#(82 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6022146 false) 
	#(95 2 #reduceActionForTemplateUnaryMessage1: 6865921 false) 
	#(73 3 #reduceActionForAssignment1: 5401601 false) 
	#(123 0 #reduceActionForEndLiteralArray1: 9837569 true) 
	#(46 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: 3476482 false) 
	#(45 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part___2: 3476482 false) 
	#(47 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: 3599362 false) 
	#(44 3 #reduceActionForTemplateWithName3: 3431427 false) 
	#(100 3 #reduceActionForStartTemplate1: 7366657 false) 
	#(102 4 #reduceActionForArray3: 7790595 false) 
	#(104 2 #reduceActionFor__period___period___Assignment__value___2: 7844866 false) 
	#(105 4 #reduceActionForBlock1: 7944193 false) 
	#(65 4 #reduceActionForMethodSequence3: 4800515 false) 
	#(65 4 #reduceActionForMethodSequence2: 4800514 false) 
	#(65 4 #reduceActionForMethodSequence16: 4800528 false) 
	#(59 4 #reduceActionForTemplatePragma1: 4415489 false) 
	#(60 2 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: 4583425 false) 
	#(59 4 #reduceActionForTemplatePragma2: 4415490 false) 
	#(61 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 4583426 false) 
	#(65 4 #reduceActionForMethodSequence8: 4800520 false) 
	#(87 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6292481 false) 
	#(85 2 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: 6248449 false) 
	#(86 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 6248450 false) 
	#(84 3 #reduceActionForTemplateKeywordMessage2: 6152194 false) 
	#(88 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 6292482 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650756 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650754 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650760 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650763 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650765 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650762 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650766 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650764 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650758 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650761 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650759 false) 
	#(114 1 #liftFirstValue: 8650753 false) 
	#(113 2 #reduceActionForPragma__pragma__2: 8572930 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650755 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8650757 false) 
	#(114 1 #reduceActionForValue8: 8650768 false) 
	#(101 4 #reduceActionForValue6: 7494662 false) 
	#(99 3 #reduceActionForStartTemplate1: 7245825 false) 
	#(102 5 #reduceActionForArray4: 7790596 false) 
	#(103 2 #reduceActionForTemplateKeyword2: 7844865 false) 
	#(65 5 #reduceActionForMethodSequence4: 4800516 false) 
	#(60 3 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: 4583426 false) 
	#(59 5 #reduceActionForTemplatePragma3: 4415491 false) 
	#(85 3 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: 6248450 false) 
	#(101 5 #reduceActionForValue7: 7494663 false) 
	#(112 5 #reduceActionForArrayLiteral1: 8501249 false) 
	#(114 3 #reduceActionForArrayLiteralValue15: 8650767 false)
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> scannerClass [
	^GtPharoScanner
]

{ #category : #generated }
GtPharoParser class >> startingStateForKeywordMessageSend [
	^ 5
]

{ #category : #generated }
GtPharoParser class >> startingStateForMethod [
	^ 1
]

{ #category : #generated }
GtPharoParser class >> startingStateForMethodPattern [
	^ 4
]

{ #category : #generated }
GtPharoParser class >> startingStateForMethodSequence [
	^ 2
]

{ #category : #generated }
GtPharoParser class >> startingStateForPragma [
	^ 7
]

{ #category : #generated }
GtPharoParser class >> startingStateForStatement [
	^ 3
]

{ #category : #generated }
GtPharoParser class >> startingStateForVariable [
	^ 6
]

{ #category : #generated }
GtPharoParser class >> symbolNames [
	^ #('"self"' '"super"' '"thisContext"' '<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<symbol>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' 'B e g i n' 'Method' 'MethodPattern' '(<keyword> ''selectorPart'' Variable ''variable'')' '(<keyword> ''selectorPart'' Variable ''variable'')+' 'TemplatePattern' '(TemplateKeywordPattern KeywordPattern?)' '(TemplateKeywordPattern KeywordPattern?)+' 'TemplateWithName' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)+' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)*' 'TemplateKeywordPattern' 'TemplateKeyword' 'TemplateNameContinuationPart' 'TemplateNamePart' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(<keyword> ''selectorPart'' PragmaArgument)' '(<keyword> ''selectorPart'' PragmaArgument)+' 'OnlyTemplate' 'PragmaArgument' 'TemplatePragma' '(TemplateKeyword PragmaArgument (<keyword> ''selectorPart'' PragmaArgument)+?)' '(TemplateKeyword PragmaArgument (<keyword> ''selectorPart'' PragmaArgument)+?)+' 'KeywordPattern' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'') Variable ''variable'')' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'') Variable ''variable'')+' 'MethodSequence' '<period> ''period''+' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'')  BinaryMessageSend ''value'')' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'')  BinaryMessageSend ''value'')+' 'TemplateKeywordMessage' '(TemplateKeyword BinaryMessageSend ''value'' (<keyword> ''selectorPart'' BinaryMessageSend ''value'')+?)' '(TemplateKeyword BinaryMessageSend ''value'' (<keyword> ''selectorPart'' BinaryMessageSend ''value'')+?)+' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'TemplateUnaryMessage' 'Variable' 'NamedVariable' 'TemplateVariable' 'MidTemplate' 'StartTemplate' 'Value' 'Array' '(<period> ''period''+ Assignment ''value'')' '(<period> ''period''+ Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' '<doubleLeftBrace>' '<doubleLeftBraceStart>' '<doubleRightBrace>' '<rbKeywordPattern>' '<rbLiteralArrayKeywordPattern>' '<rbNamePattern>' '<rbPatternBlock>' '<template>' '<templateKeyword>' '<templateNamePart>' 'E O F' 'error')
]

{ #category : #generated }
GtPharoParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #GtPharoTemplatePatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoTemplateNamePartNode #GtPharoTemplateNamePartNode #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection nil #GtPharoValueNode #GtPharoTemplatePragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoTemplateKeywordMessageNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoTemplateUnaryMessageNode #GtPharoValueNode #GtPharoNamedVariableNode #GtPharoTemplateVariableNode #GtPharoTemplateNode #GtPharoTemplateNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoParser class >> transitionTable [
^#(
#[1 0 33 0 7 0 37 0 28 0 41 0 29 0 45 0 37 0 49 0 38 0 53 0 39 0 57 0 40 0 49 0 41 0 65 0 57 0 69 0 62 0 73 0 63 0 77 0 64 0 81 0 127 0 85 0 129 0 89 0 131] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 9 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 149 0 17 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 169 0 32 0 173 0 52 0 177 0 53 0 181 0 54 0 185 0 57 0 181 0 59 0 193 0 65 0 197 0 66 0 193 0 67 0 205 0 68 0 209 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 0 10 0 134 1 69 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 1 77 0 72 1 77 0 73 1 77 0 74 1 77 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 0 33 0 7 0 37 0 28 0 41 0 29 1 81 0 38 0 53 0 39 0 57 0 40 1 81 0 41 0 65 0 57 0 69 0 62 0 73 0 63 0 77 0 64 0 81 0 127 0 85 0 129 0 89 0 131] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 1 85 0 79 1 89 0 80 0 237 0 89 1 93 0 90 0 245 0 92 1 97 0 93 0 245 0 96 0 245 0 97 0 245 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 1 73 0 57 1 105 0 96 1 105 0 97 1 105 0 98 1 61 0 129 0 89 0 131] 
#[1 0 149 0 17 1 109 0 54 1 113 0 57 1 109 0 59 0 89 0 131] 
#[0 0 14 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 1 73 0 57 1 117 0 96 1 117 0 97 1 117 0 98 1 61 0 129 0 89 0 131 1 121 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 1 73 0 57 1 125 0 96 1 125 0 97 1 125 0 98 1 61 0 129 0 89 0 131 1 129 0 135] 
#[0 0 0 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 9 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 149 0 17 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 169 0 32 0 173 0 52 0 177 0 53 0 181 0 54 0 185 0 57 0 181 0 59 1 133 0 65 0 197 0 66 1 133 0 67 0 205 0 68 0 209 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 0 10 0 134 1 69 0 135] 
#[0 0 18 0 28] 
#[1 1 137 0 28 1 141 0 39] 
#[0 0 22 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[1 1 145 0 7 1 149 0 28 1 153 0 42 1 157 0 43 1 161 0 44 1 165 0 48 1 169 0 49 1 173 0 51 1 177 0 62 0 73 0 63 0 77 0 64 1 181 0 100 1 185 0 125 0 81 0 127] 
#[0 0 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 0 30 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 125 0 127 0 129 0 130 0 131 0 134 0 135] 
#[1 0 34 0 1 0 34 0 2 0 34 0 3 0 34 0 4 0 34 0 5 0 34 0 6 0 34 0 7 0 34 0 9 0 34 0 10 0 34 0 11 0 34 0 12 0 34 0 13 0 34 0 14 0 34 0 16 0 34 0 17 0 34 0 19 0 34 0 20 0 34 0 22 0 34 0 23 0 34 0 24 1 149 0 28 0 34 0 32 1 189 0 63 0 34 0 125 0 81 0 127 0 34 0 129 0 34 0 130 0 34 0 131 0 34 0 134 0 34 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 1 73 0 57 1 193 0 96 1 193 0 97 1 193 0 98 1 61 0 129 0 89 0 131] 
#[0 0 38 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 0 42 0 7 0 17 0 28 0 125 0 127] 
#[0 0 46 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 0 50 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 0 54 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 0 58 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 62 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 66 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 70 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134 0 135] 
#[1 0 74 0 1 0 74 0 2 0 74 0 3 0 74 0 7 0 74 0 9 1 197 0 69 0 74 0 129 0 74 0 131] 
#[0 0 78 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 82 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 86 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 90 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 94 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 1 201 0 73 1 201 0 74 1 201 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 1 205 0 7 1 209 0 28 1 213 0 55 1 217 0 56 1 221 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 225 0 27 0 169 0 32 1 73 0 57 1 229 0 66 1 233 0 73 1 233 0 74 1 233 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 0 98 0 1 0 98 0 2 0 98 0 3 0 98 0 4 0 98 0 5 0 98 0 6 0 98 0 7 0 98 0 9 0 98 0 10 0 98 0 11 0 98 0 12 0 98 0 13 0 98 0 14 0 98 0 16 0 98 0 19 0 98 0 20 1 237 0 21 0 98 0 22 0 98 0 23 0 98 0 24 0 98 0 26 0 98 0 32 1 241 0 106 1 245 0 107 1 249 0 108 0 98 0 129 0 98 0 130 0 98 0 131 0 98 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 1 253 0 73 1 253 0 74 1 253 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 0 102 0 13 0 102 0 14 0 102 0 26 2 1 0 116 0 102 0 135] 
#[0 0 106 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 129 0 130 0 131 0 134 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 9 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 169 0 32 1 73 0 57 2 5 0 66 2 9 0 68 2 13 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 0 110 0 134 1 69 0 135] 
#[1 0 114 0 1 0 114 0 2 0 114 0 3 0 114 0 4 0 114 0 5 0 114 0 6 0 114 0 7 0 114 0 9 0 114 0 10 0 114 0 11 0 114 0 12 0 114 0 13 0 114 0 14 0 114 0 16 0 149 0 17 0 114 0 19 0 114 0 20 0 114 0 22 0 114 0 23 0 114 0 24 0 114 0 32 2 17 0 54 1 113 0 57 2 17 0 59 0 114 0 129 0 114 0 130 0 7 0 131 0 114 0 134 0 114 0 135] 
#[0 0 118 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[1 1 145 0 7 2 21 0 17 2 25 0 44 1 173 0 51 1 181 0 100 1 185 0 125] 
#[0 0 122 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 0 0 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 126 0 26 0 126 0 27 2 29 0 32 1 73 0 57 2 33 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 0 126 0 134 1 69 0 135] 
#[0 0 130 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 149 0 17 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 169 0 32 2 37 0 52 0 177 0 53 0 181 0 54 0 185 0 57 0 181 0 59 2 41 0 66 2 45 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 0 134 0 134 1 69 0 135] 
#[0 0 138 0 26 0 27 0 134] 
#[1 0 142 0 26 0 142 0 27 0 169 0 32 2 49 0 66 0 142 0 134] 
#[0 0 146 0 26 0 27 0 32 0 134] 
#[0 0 150 0 26 0 27 0 32 0 134] 
#[0 0 154 0 25 0 26 0 27 0 32 0 126 0 134] 
#[0 0 158 0 25 0 26 0 27 0 32 0 126 0 134] 
#[1 0 162 0 25 0 162 0 26 0 162 0 27 2 53 0 30 0 162 0 32 2 57 0 75 2 61 0 76 2 65 0 77 0 162 0 126 0 162 0 134] 
#[1 0 166 0 25 0 166 0 26 0 166 0 27 2 69 0 28 2 73 0 29 0 166 0 32 2 77 0 57 2 81 0 81 2 85 0 82 2 89 0 83 2 81 0 84 2 97 0 91 0 166 0 126 2 101 0 127 0 89 0 131 0 166 0 134] 
#[1 0 170 0 25 0 170 0 26 0 170 0 27 0 170 0 28 0 170 0 29 2 53 0 30 0 170 0 32 2 105 0 75 2 61 0 76 2 65 0 77 0 170 0 126 0 170 0 127 0 170 0 131 0 170 0 134] 
#[1 0 11 0 7 0 174 0 25 0 174 0 26 0 174 0 27 0 174 0 28 0 174 0 29 0 174 0 30 0 174 0 32 2 113 0 57 2 117 0 94 2 117 0 95 0 174 0 125 0 174 0 126 0 174 0 127 2 125 0 129 2 129 0 130 0 15 0 131 0 174 0 134] 
#[1 0 178 0 7 0 178 0 25 0 178 0 26 0 178 0 27 0 178 0 28 0 178 0 29 2 53 0 30 0 178 0 32 2 133 0 75 2 61 0 76 2 65 0 77 0 178 0 126 0 178 0 127 0 178 0 129 0 178 0 130 0 178 0 131 0 178 0 134] 
#[1 0 182 0 7 0 182 0 25 0 182 0 26 0 182 0 27 0 182 0 28 0 182 0 29 2 137 0 31 0 182 0 32 0 182 0 126 0 182 0 127 0 182 0 129 0 182 0 130 0 182 0 131 0 182 0 134] 
#[0 0 186 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 0 190 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 0 194 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 0 198 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 0 202 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 0 206 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 0 210 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 214 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 218 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 222 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 226 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 230 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 234 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 0 238 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 2 141 0 23] 
#[0 0 242 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134 0 135] 
#[1 0 98 0 1 0 98 0 2 0 98 0 3 0 98 0 4 0 98 0 5 0 98 0 6 0 98 0 7 0 98 0 9 0 98 0 10 0 98 0 11 0 98 0 12 0 98 0 13 0 98 0 14 0 98 0 16 0 98 0 19 0 98 0 20 1 237 0 21 0 98 0 22 0 98 0 23 0 98 0 24 0 98 0 27 0 98 0 32 1 241 0 106 2 145 0 107 2 149 0 108 0 98 0 129 0 98 0 130 0 98 0 131 0 98 0 135] 
#[0 0 246 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 1 145 0 7 2 25 0 44 1 173 0 51 1 181 0 100 1 185 0 125] 
#[0 0 0 0 134] 
#[0 0 0 0 134] 
#[0 0 0 0 134] 
#[0 0 162 0 134] 
#[0 0 170 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 131 0 134] 
#[0 0 178 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 0 182 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 0 0 0 134] 
#[0 0 0 0 134] 
#[0 2 21 0 17] 
#[1 0 250 0 1 0 250 0 2 0 250 0 3 0 250 0 4 0 250 0 5 0 250 0 6 0 250 0 7 0 250 0 9 0 250 0 10 0 250 0 11 0 250 0 12 0 250 0 13 0 250 0 14 0 250 0 16 0 250 0 17 0 250 0 19 0 250 0 20 0 250 0 22 0 250 0 23 0 250 0 24 0 19 0 28 0 250 0 32 0 250 0 127 0 250 0 129 0 250 0 130 0 250 0 131 0 250 0 134 0 250 0 135] 
#[0 1 2 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 1 6 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 1 10 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 1 14 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 1 73 0 57 2 153 0 96 2 153 0 97 2 153 0 98 1 61 0 129 0 89 0 131 2 157 0 135] 
#[0 1 18 0 28] 
#[0 1 22 0 124] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 1 73 0 57 2 161 0 96 2 161 0 97 2 161 0 98 1 61 0 129 0 89 0 131] 
#[0 1 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 125 0 129 0 130 0 131 0 134 0 135] 
#[1 1 30 0 1 1 30 0 2 1 30 0 3 1 30 0 4 1 30 0 5 1 30 0 6 0 23 0 7 1 30 0 9 1 30 0 10 1 30 0 11 1 30 0 12 1 30 0 13 1 30 0 14 1 30 0 16 1 30 0 17 1 30 0 19 1 30 0 20 1 30 0 22 1 30 0 23 1 30 0 24 1 30 0 32 2 165 0 42 2 169 0 44 1 165 0 48 1 169 0 49 1 173 0 51 1 181 0 100 1 185 0 125 1 30 0 129 1 30 0 130 1 30 0 131 1 30 0 134 1 30 0 135] 
#[1 1 34 0 1 1 34 0 2 1 34 0 3 1 34 0 4 1 34 0 5 1 34 0 6 1 34 0 7 1 34 0 9 1 34 0 10 1 34 0 11 1 34 0 12 1 34 0 13 1 34 0 14 1 34 0 16 1 34 0 17 1 34 0 19 1 34 0 20 2 173 0 21 1 34 0 22 1 34 0 23 1 34 0 24 1 34 0 32 1 34 0 129 1 34 0 130 1 34 0 131 2 177 0 132 1 34 0 134 1 34 0 135] 
#[1 1 38 0 1 1 38 0 2 1 38 0 3 1 38 0 4 1 38 0 5 1 38 0 6 1 38 0 7 1 38 0 9 1 38 0 10 1 38 0 11 1 38 0 12 1 38 0 13 1 38 0 14 1 38 0 16 1 38 0 17 1 38 0 19 1 38 0 20 1 38 0 22 1 38 0 23 1 38 0 24 1 149 0 28 1 38 0 32 2 181 0 62 0 73 0 63 0 77 0 64 1 38 0 125 0 81 0 127 1 38 0 129 1 38 0 130 1 38 0 131 1 38 0 134 1 38 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 1 73 0 57 2 185 0 96 2 185 0 97 2 185 0 98 1 61 0 129 0 89 0 131] 
#[1 2 189 0 45 2 193 0 46 2 197 0 99 2 201 0 124] 
#[1 1 145 0 7 1 153 0 42 2 205 0 43 2 169 0 44 1 165 0 48 1 169 0 49 1 173 0 51 1 181 0 100 1 185 0 125] 
#[1 1 42 0 1 1 42 0 2 1 42 0 3 1 42 0 4 1 42 0 5 1 42 0 6 1 42 0 7 1 42 0 9 1 42 0 10 1 42 0 11 1 42 0 12 1 42 0 13 1 42 0 14 1 42 0 16 1 42 0 17 1 42 0 18 1 42 0 19 1 42 0 20 1 42 0 21 1 42 0 22 1 42 0 23 1 42 0 24 1 42 0 25 1 42 0 26 1 42 0 27 1 42 0 28 1 42 0 29 1 42 0 30 1 42 0 31 1 42 0 32 2 209 0 47 2 213 0 50 1 42 0 124 1 42 0 125 1 42 0 126 1 42 0 127 1 42 0 129 1 42 0 130 1 42 0 131 1 42 0 132 2 217 0 133 1 42 0 134 1 42 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 2 221 0 73 2 221 0 74 2 221 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[0 1 46 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 125 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 1 50 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 125 0 127 0 129 0 130 0 131 0 134 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 2 225 0 9 1 73 0 57 2 229 0 96 2 229 0 97 2 229 0 98 1 61 0 129 0 89 0 131] 
#[0 1 54 0 26 0 27 0 32 0 134] 
#[0 2 233 0 18] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 6 0 23 0 165 0 24 1 73 0 57 2 237 0 58 2 237 0 96 2 237 0 97 2 237 0 98 2 237 0 109 2 237 0 110 2 237 0 111 2 237 0 112 2 237 0 115 2 237 0 118 2 237 0 119 2 237 0 120 2 237 0 121 1 57 0 122 1 61 0 129 0 89 0 131] 
#[0 1 58 0 7 0 18 0 28 0 125] 
#[1 2 249 0 18 1 209 0 28 2 253 0 55] 
#[1 1 62 0 1 1 62 0 2 1 62 0 3 1 62 0 4 1 62 0 5 1 62 0 6 1 62 0 7 1 62 0 9 1 62 0 10 1 62 0 11 1 62 0 12 1 62 0 13 1 62 0 14 1 62 0 16 1 62 0 17 3 1 0 18 1 62 0 19 1 62 0 20 1 62 0 22 1 62 0 23 1 62 0 24 1 62 0 32 1 62 0 129 1 62 0 130 1 62 0 131 1 62 0 134 1 62 0 135] 
#[0 1 66 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 3 5 0 27 2 29 0 32] 
#[1 1 70 0 27 1 70 0 32 3 9 0 104] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 1 73 0 57 3 13 0 96 3 13 0 97 3 13 0 98 1 61 0 129 0 89 0 131] 
#[0 1 74 0 9 0 21 0 26] 
#[1 3 17 0 9 1 237 0 21 3 21 0 26 3 25 0 106] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 9 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 10 0 26 0 169 0 32 1 73 0 57 0 197 0 66 3 29 0 67 3 33 0 68 0 209 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[0 3 37 0 25] 
#[1 0 137 0 13 0 141 0 14 3 41 0 26 3 49 0 111 3 49 0 117 3 53 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 2 29 0 32 1 73 0 57 3 57 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 78 0 134 1 69 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 149 0 17 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 169 0 32 3 61 0 52 0 177 0 53 0 181 0 54 0 185 0 57 0 181 0 59 3 65 0 66 3 69 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 82 0 134 1 69 0 135] 
#[0 1 86 0 134] 
#[0 1 90 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[1 1 145 0 7 1 209 0 28 3 73 0 44 3 77 0 49 1 173 0 51 1 213 0 55 3 81 0 56 3 85 0 60 3 89 0 61 1 181 0 100 1 185 0 125] 
#[0 1 94 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 1 98 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 1 102 0 26 0 27 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 169 0 32 1 73 0 57 3 93 0 66 3 97 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 106 0 134 1 69 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 110 0 26 1 110 0 27 2 29 0 32 1 73 0 57 3 101 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 110 0 134 1 69 0 135] 
#[0 1 114 0 26 0 27 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 118 0 26 1 118 0 27 2 29 0 32 1 73 0 57 3 105 0 72 3 105 0 73 3 105 0 74 3 105 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 118 0 134 1 69 0 135] 
#[1 2 109 0 7 2 69 0 28 2 73 0 29 3 109 0 57 3 113 0 78 3 113 0 81 2 85 0 82 2 89 0 83 3 113 0 84 3 113 0 91 3 113 0 94 3 113 0 95 2 101 0 127 2 125 0 129 0 89 0 131] 
#[0 1 122 0 25 0 26 0 27 0 32 0 126 0 134] 
#[0 1 126 0 25 0 26 0 27 0 30 0 32 0 126 0 134] 
#[1 1 130 0 25 1 130 0 26 1 130 0 27 2 53 0 30 1 130 0 32 3 129 0 76 1 130 0 126 1 130 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 3 133 0 89 1 93 0 90 0 245 0 92 1 97 0 93 0 245 0 96 0 245 0 97 0 245 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 3 137 0 92 1 97 0 93 3 137 0 96 3 137 0 97 3 137 0 98 3 137 0 101 3 137 0 102 3 137 0 105 3 137 0 109 3 137 0 110 3 137 0 111 3 137 0 112 3 137 0 115 3 137 0 118 3 137 0 119 3 137 0 120 3 137 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 1 145 0 7 3 141 0 28 2 169 0 44 3 145 0 49 1 173 0 51 3 149 0 85 3 153 0 86 3 157 0 87 3 161 0 88 1 181 0 100 1 185 0 125] 
#[0 1 134 0 25 0 26 0 27 0 30 0 32 0 126 0 134] 
#[0 1 138 0 25 0 26 0 27 0 28 0 30 0 32 0 126 0 127 0 134] 
#[1 1 142 0 25 1 142 0 26 1 142 0 27 2 69 0 28 1 142 0 30 1 142 0 32 3 165 0 82 1 142 0 126 2 101 0 127 1 142 0 134] 
#[0 1 146 0 25 0 26 0 27 0 30 0 32 0 126 0 134] 
#[0 1 150 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 131 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 3 169 0 89 1 93 0 90 0 245 0 92 1 97 0 93 0 245 0 96 0 245 0 97 0 245 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[0 1 154 0 25 0 26 0 27 0 32 0 126 0 134] 
#[0 1 158 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 1 145 0 7 3 173 0 44 1 173 0 51 1 181 0 100 1 185 0 125] 
#[0 1 162 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 1 166 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 1 170 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 0 98 0 1 0 98 0 2 0 98 0 3 0 98 0 4 0 98 0 5 0 98 0 6 0 98 0 7 0 98 0 9 0 98 0 10 0 98 0 11 0 98 0 12 0 98 0 13 0 98 0 14 0 98 0 16 0 98 0 19 0 98 0 20 1 237 0 21 0 98 0 22 0 98 0 23 0 98 0 24 0 98 0 27 0 98 0 32 1 241 0 106 2 145 0 107 3 177 0 108 0 98 0 129 0 98 0 130 0 98 0 131 0 98 0 135] 
#[0 1 174 0 25 0 26 0 27 0 32 0 126 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 3 181 0 73 3 181 0 74 3 181 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 1 178 0 4 1 178 0 5 1 178 0 6 1 178 0 7 1 178 0 10 1 178 0 11 1 178 0 12 1 178 0 13 1 178 0 14 1 178 0 15 1 178 0 16 1 178 0 19 1 178 0 20 1 178 0 21 1 178 0 22 1 178 0 23 1 178 0 24 1 178 0 25 1 178 0 26 1 178 0 27 1 178 0 29 1 178 0 30 1 178 0 32 3 185 0 113 1 178 0 128 1 178 0 129 1 178 0 135] 
#[1 3 17 0 9 1 237 0 21 3 25 0 106] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 9 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 10 0 27 0 169 0 32 1 73 0 57 0 197 0 66 3 189 0 67 3 33 0 68 0 209 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[0 0 254 0 28] 
#[0 1 182 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 0 250 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 125 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 1 186 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 125 0 129 0 130 0 131 0 134 0 135] 
#[1 2 173 0 21 2 177 0 132] 
#[0 1 190 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 19 0 20 0 22 0 23 0 24 0 129 0 130 0 131 0 135] 
#[0 1 194 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 19 0 20 0 22 0 23 0 24 0 129 0 130 0 131 0 135] 
#[0 1 198 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 125 0 129 0 130 0 131 0 134 0 135] 
#[0 1 202 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 125 0 127 0 129 0 130 0 131 0 134 0 135] 
#[0 1 206 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 127 0 129 0 130 0 131 0 132 0 134 0 135] 
#[1 1 210 0 1 1 210 0 2 1 210 0 3 1 210 0 4 1 210 0 5 1 210 0 6 1 210 0 7 1 210 0 9 1 210 0 10 1 210 0 11 1 210 0 12 1 210 0 13 1 210 0 14 1 210 0 16 1 210 0 17 1 210 0 18 1 210 0 19 1 210 0 20 1 210 0 21 1 210 0 22 1 210 0 23 1 210 0 24 1 210 0 25 1 210 0 26 1 210 0 27 1 210 0 28 1 210 0 29 1 210 0 30 1 210 0 31 1 210 0 32 3 193 0 45 2 197 0 99 2 201 0 124 1 210 0 125 1 210 0 126 1 210 0 127 1 210 0 129 1 210 0 130 1 210 0 131 1 210 0 132 1 210 0 134 1 210 0 135] 
#[1 1 214 0 1 1 214 0 2 1 214 0 3 1 214 0 4 1 214 0 5 1 214 0 6 1 214 0 7 1 214 0 9 1 214 0 10 1 214 0 11 1 214 0 12 1 214 0 13 1 214 0 14 1 214 0 16 1 214 0 17 1 214 0 18 1 214 0 19 1 214 0 20 1 214 0 21 1 214 0 22 1 214 0 23 1 214 0 24 1 214 0 25 1 214 0 26 1 214 0 27 1 214 0 28 1 214 0 29 1 214 0 30 1 214 0 31 1 214 0 32 3 197 0 50 1 214 0 124 1 214 0 125 1 214 0 126 1 214 0 127 1 214 0 129 1 214 0 130 1 214 0 131 1 214 0 132 2 217 0 133 1 214 0 134 1 214 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 3 201 0 73 3 201 0 74 3 201 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 1 218 0 1 1 218 0 2 1 218 0 3 1 218 0 4 1 218 0 5 1 218 0 6 0 27 0 7 1 218 0 9 1 218 0 10 1 218 0 11 1 218 0 12 1 218 0 13 1 218 0 14 1 218 0 16 1 218 0 17 1 218 0 19 1 218 0 20 1 218 0 22 1 218 0 23 1 218 0 24 1 218 0 32 2 165 0 42 2 169 0 44 1 165 0 48 1 169 0 49 1 173 0 51 1 181 0 100 1 185 0 125 1 218 0 129 1 218 0 130 1 218 0 131 1 218 0 134 1 218 0 135] 
#[1 1 222 0 1 1 222 0 2 1 222 0 3 1 222 0 4 1 222 0 5 1 222 0 6 1 222 0 7 1 222 0 9 1 222 0 10 1 222 0 11 1 222 0 12 1 222 0 13 1 222 0 14 1 222 0 16 1 222 0 17 1 222 0 18 1 222 0 19 1 222 0 20 1 222 0 21 1 222 0 22 1 222 0 23 1 222 0 24 1 222 0 25 1 222 0 26 1 222 0 27 1 222 0 28 1 222 0 29 1 222 0 30 1 222 0 31 1 222 0 32 3 205 0 45 2 197 0 99 2 201 0 124 1 222 0 125 1 222 0 126 1 222 0 127 1 222 0 129 1 222 0 130 1 222 0 131 1 222 0 132 1 222 0 134 1 222 0 135] 
#[1 1 42 0 1 1 42 0 2 1 42 0 3 1 42 0 4 1 42 0 5 1 42 0 6 1 42 0 7 1 42 0 9 1 42 0 10 1 42 0 11 1 42 0 12 1 42 0 13 1 42 0 14 1 42 0 16 1 42 0 17 1 42 0 18 1 42 0 19 1 42 0 20 1 42 0 21 1 42 0 22 1 42 0 23 1 42 0 24 1 42 0 25 1 42 0 26 1 42 0 27 1 42 0 28 1 42 0 29 1 42 0 30 1 42 0 31 1 42 0 32 3 209 0 47 1 42 0 124 1 42 0 125 1 42 0 126 1 42 0 127 1 42 0 129 1 42 0 130 1 42 0 131 1 42 0 132 1 42 0 134 1 42 0 135] 
#[0 1 226 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 127 0 129 0 130 0 131 0 132 0 134 0 135] 
#[0 3 213 0 126] 
#[0 1 230 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 1 234 0 1 0 2 0 3 0 7 0 9 0 129 0 131] 
#[0 1 238 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 1 242 0 7 0 18 0 28 0 125] 
#[0 1 246 0 7 0 18 0 28 0 125] 
#[0 1 250 0 7 0 18 0 28 0 125] 
#[0 1 254 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 2 2 0 7 0 18 0 28 0 125] 
#[0 2 6 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 2 10 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 3 217 0 27 0 169 0 32 3 221 0 66 3 225 0 103] 
#[0 2 14 0 9 0 21 0 26] 
#[0 2 18 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 129 0 130 0 131 0 135] 
#[0 2 22 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 2 26 0 9 0 21 0 26] 
#[0 3 229 0 26] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 134 0 26 0 134 0 27 0 169 0 32 1 73 0 57 2 41 0 66 2 45 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[0 2 30 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 2 34 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 2 38 0 13 0 14 0 26 0 135] 
#[0 2 42 0 13 0 14 0 26 0 135] 
#[0 2 46 0 13 0 14 0 26 0 135] 
#[0 2 50 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 169 0 32 1 73 0 57 3 233 0 66 3 237 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 2 54 0 134 1 69 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 2 29 0 32 1 73 0 57 3 241 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 2 58 0 134 1 69 0 135] 
#[0 2 62 0 134] 
#[1 3 245 0 18 2 173 0 21 2 177 0 132] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 6 0 23 0 165 0 24 1 73 0 57 3 249 0 58 3 249 0 96 3 249 0 97 3 249 0 98 3 249 0 109 3 249 0 110 3 249 0 111 3 249 0 112 3 249 0 115 3 249 0 118 3 249 0 119 3 249 0 120 3 249 0 121 1 57 0 122 1 61 0 129 0 89 0 131] 
#[1 1 145 0 7 1 209 0 28 2 169 0 44 3 77 0 49 1 173 0 51 2 253 0 55 3 85 0 60 3 253 0 61 1 181 0 100 1 185 0 125] 
#[0 2 66 0 7 0 18 0 125] 
#[1 1 145 0 7 4 1 0 18 2 169 0 44 3 77 0 49 1 173 0 51 4 5 0 60 1 181 0 100 1 185 0 125] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 2 29 0 32 1 73 0 57 4 9 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 2 70 0 134 1 69 0 135] 
#[0 2 74 0 134] 
#[0 2 78 0 26 0 27 0 134] 
#[0 2 82 0 26 0 27 0 32 0 134] 
#[1 1 145 0 7 3 141 0 28 4 13 0 44 3 145 0 49 1 173 0 51 3 149 0 85 3 153 0 86 3 157 0 87 3 161 0 88 1 181 0 100 1 185 0 125] 
#[0 2 86 0 25 0 26 0 27 0 30 0 32 0 126 0 134] 
#[0 2 90 0 25 0 26 0 27 0 30 0 32 0 126 0 134] 
#[0 2 94 0 25 0 26 0 27 0 30 0 32 0 126 0 134] 
#[0 2 98 0 25 0 26 0 27 0 30 0 32 0 126 0 134] 
#[0 2 102 0 25 0 26 0 27 0 30 0 32 0 126 0 134] 
#[1 2 106 0 25 2 106 0 26 2 106 0 27 2 106 0 28 2 73 0 29 2 106 0 30 2 106 0 32 2 97 0 91 2 106 0 126 2 106 0 127 2 106 0 134] 
#[1 0 31 0 7 2 110 0 25 2 110 0 26 2 110 0 27 2 110 0 28 2 110 0 29 2 110 0 30 2 110 0 32 2 113 0 57 2 117 0 94 2 117 0 95 2 110 0 125 2 110 0 126 2 110 0 127 2 125 0 129 2 129 0 130 0 35 0 131 2 110 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 4 17 0 89 1 93 0 90 0 245 0 92 1 97 0 93 0 245 0 96 0 245 0 97 0 245 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 1 73 0 57 4 21 0 89 1 93 0 90 0 245 0 92 1 97 0 93 0 245 0 96 0 245 0 97 0 245 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[0 2 114 0 7 0 25 0 26 0 27 0 30 0 32 0 125 0 126 0 134] 
#[1 1 145 0 7 2 118 0 25 2 118 0 26 2 118 0 27 2 118 0 30 2 118 0 32 2 169 0 44 3 145 0 49 1 173 0 51 4 25 0 85 1 181 0 100 1 185 0 125 2 118 0 126 2 118 0 134] 
#[0 2 122 0 7 0 25 0 26 0 27 0 28 0 30 0 32 0 125 0 126 0 134] 
#[1 1 145 0 7 3 141 0 28 2 169 0 44 3 145 0 49 1 173 0 51 3 149 0 85 4 29 0 86 4 33 0 87 1 181 0 100 1 185 0 125] 
#[0 2 126 0 25 0 26 0 27 0 28 0 30 0 32 0 126 0 127 0 134] 
#[1 2 130 0 25 2 130 0 26 2 130 0 27 2 130 0 28 2 73 0 29 2 130 0 30 2 130 0 32 2 97 0 91 2 130 0 126 2 130 0 127 2 130 0 134] 
#[0 2 134 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 9 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 0 10 0 27 0 169 0 32 1 73 0 57 0 197 0 66 4 37 0 67 3 33 0 68 0 209 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[0 2 138 0 25 0 26 0 27 0 32 0 126 0 134] 
#[1 0 105 0 4 0 109 0 5 0 113 0 6 4 41 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 4 45 0 15 4 49 0 16 4 53 0 19 4 57 0 20 4 61 0 21 4 65 0 22 0 6 0 23 0 165 0 24 2 142 0 25 4 69 0 26 4 73 0 27 4 77 0 29 4 81 0 30 4 85 0 32 4 93 0 109 4 93 0 110 4 93 0 111 4 93 0 112 4 93 0 114 4 93 0 115 4 93 0 118 4 93 0 119 4 93 0 120 4 93 0 121 1 57 0 122 4 97 0 123 4 101 0 128 4 105 0 129 4 109 0 135] 
#[0 4 113 0 27] 
#[0 2 146 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 127 0 129 0 130 0 131 0 132 0 134 0 135] 
#[0 2 150 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 127 0 129 0 130 0 131 0 132 0 134 0 135] 
#[0 4 117 0 126] 
#[0 2 154 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 127 0 129 0 130 0 131 0 132 0 134 0 135] 
#[1 2 158 0 1 2 158 0 2 2 158 0 3 2 158 0 4 2 158 0 5 2 158 0 6 2 158 0 7 2 158 0 9 2 158 0 10 2 158 0 11 2 158 0 12 2 158 0 13 2 158 0 14 2 158 0 16 2 158 0 17 2 158 0 18 2 158 0 19 2 158 0 20 2 158 0 21 2 158 0 22 2 158 0 23 2 158 0 24 2 158 0 25 2 158 0 26 2 158 0 27 2 158 0 28 2 158 0 29 2 158 0 30 2 158 0 31 2 158 0 32 3 205 0 45 2 197 0 99 2 201 0 124 2 158 0 125 2 158 0 126 2 158 0 127 2 158 0 129 2 158 0 130 2 158 0 131 2 158 0 132 2 158 0 134 2 158 0 135] 
#[0 2 162 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 127 0 129 0 130 0 131 0 132 0 133 0 134 0 135] 
#[0 2 166 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 4 121 0 27 2 29 0 32 1 73 0 57 4 125 0 73 4 125 0 74 4 125 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 1 69 0 135] 
#[0 2 170 0 27 0 32] 
#[0 2 174 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 16 0 153 0 19 0 157 0 20 0 161 0 22 0 6 0 23 0 165 0 24 2 29 0 32 1 73 0 57 4 129 0 70 0 213 0 71 0 217 0 72 0 217 0 73 0 217 0 74 0 217 0 79 0 233 0 80 0 237 0 89 0 241 0 90 0 245 0 92 0 249 0 93 0 253 0 96 0 253 0 97 0 253 0 98 0 245 0 101 0 245 0 102 0 245 0 105 0 245 0 109 0 245 0 110 0 245 0 111 0 245 0 112 0 245 0 115 0 245 0 118 0 245 0 119 0 245 0 120 0 245 0 121 1 57 0 122 1 61 0 129 1 65 0 130 0 89 0 131 2 178 0 134 1 69 0 135] 
#[0 2 182 0 134] 
#[0 2 186 0 134] 
#[0 2 190 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[1 2 194 0 7 2 194 0 18 1 209 0 28 1 213 0 55 4 133 0 56 2 194 0 125] 
#[1 1 145 0 7 4 137 0 18 2 169 0 44 3 77 0 49 1 173 0 51 4 5 0 60 1 181 0 100 1 185 0 125] 
#[0 2 198 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[0 2 202 0 7 0 18 0 125] 
#[0 2 206 0 134] 
#[1 2 173 0 21 2 134 0 25 2 134 0 26 2 134 0 27 2 134 0 30 2 134 0 32 2 134 0 126 2 177 0 132 2 134 0 134] 
#[1 2 210 0 7 2 210 0 25 2 210 0 26 2 210 0 27 2 210 0 28 2 73 0 29 2 210 0 30 2 210 0 32 2 97 0 91 2 210 0 125 2 210 0 126 2 210 0 134] 
#[1 2 214 0 7 2 214 0 25 2 214 0 26 2 214 0 27 3 141 0 28 2 73 0 29 2 214 0 30 2 214 0 32 3 157 0 87 4 141 0 88 2 97 0 91 2 214 0 125 2 214 0 126 2 214 0 134] 
#[0 2 218 0 7 0 25 0 26 0 27 0 30 0 32 0 125 0 126 0 134] 
#[1 1 145 0 7 2 222 0 25 2 222 0 26 2 222 0 27 2 222 0 30 2 222 0 32 2 169 0 44 3 145 0 49 1 173 0 51 4 25 0 85 1 181 0 100 1 185 0 125 2 222 0 126 2 222 0 134] 
#[0 2 226 0 7 0 25 0 26 0 27 0 28 0 30 0 32 0 125 0 126 0 134] 
#[0 4 145 0 27] 
#[0 2 230 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 2 234 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 2 238 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 2 242 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 2 246 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 2 250 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[1 1 178 0 4 1 178 0 5 1 178 0 6 1 178 0 7 1 178 0 10 1 178 0 11 1 178 0 12 1 178 0 13 1 178 0 14 1 178 0 15 1 178 0 16 1 178 0 19 1 178 0 20 1 178 0 21 1 178 0 22 1 178 0 23 1 178 0 24 1 178 0 25 1 178 0 26 1 178 0 27 1 178 0 29 1 178 0 30 1 178 0 32 4 149 0 113 1 178 0 128 1 178 0 129 1 178 0 135] 
#[0 2 254 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 2 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 6 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 10 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 14 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 18 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 22 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 4 153 0 25] 
#[0 3 26 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 30 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 34 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135] 
#[0 3 38 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 3 42 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 127 0 129 0 130 0 131 0 132 0 133 0 134 0 135] 
#[0 3 46 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[0 3 50 0 27 0 32] 
#[0 3 54 0 134] 
#[1 3 58 0 7 3 58 0 18 1 209 0 28 2 253 0 55 3 58 0 125] 
#[0 3 62 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 129 0 130 0 131 0 134 0 135] 
#[1 3 66 0 7 3 66 0 25 3 66 0 26 3 66 0 27 3 141 0 28 3 66 0 30 3 66 0 32 4 33 0 87 3 66 0 125 3 66 0 126 3 66 0 134] 
#[0 3 70 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 129 0 130 0 131 0 134] 
#[1 0 105 0 4 0 109 0 5 0 113 0 6 4 41 0 7 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 4 45 0 15 4 49 0 16 4 53 0 19 4 57 0 20 4 61 0 21 4 65 0 22 0 6 0 23 0 165 0 24 4 157 0 25 4 69 0 26 4 73 0 27 4 77 0 29 4 81 0 30 4 85 0 32 4 93 0 109 4 93 0 110 4 93 0 111 4 93 0 112 4 93 0 114 4 93 0 115 4 93 0 118 4 93 0 119 4 93 0 120 4 93 0 121 1 57 0 122 4 101 0 128 4 105 0 129 4 109 0 135] 
#[0 3 74 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 125 0 126 0 127 0 128 0 129 0 130 0 131 0 134 0 135] 
#[0 3 78 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 29 0 30 0 32 0 128 0 129 0 135]
	).
]

{ #category : #private }
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

{ #category : #private }
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

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArray1: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result rightBrace: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArray2: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addTokens: (nodes at: 2) to: result periods.
	result rightBrace: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
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

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArray4: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addNode: (nodes at: 2) to: result values.
	result addTokens: ((nodes at: 3) at: 1) to: result periods.
	result addNodes: ((nodes at: 3) at: 2) to: result values.
	result addTokens: (nodes at: 4) to: result periods.
	result rightBrace: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArrayLiteral1: nodes [
	| result |
	result := GtPharoArrayLiteralNode new.
	result arrayStart: (nodes at: 2).
	result addNodes: (nodes at: 3) to: result values.
	result arrayStop: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForArrayLiteralValue15: nodes [
	| result |
	result := GtPharoArrayLiteralNode new.
	result arrayStart: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result values.
	result arrayStop: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForAssignment1: nodes [
	| result |
	result := GtPharoAssignmentNode new.
	result variable: (nodes at: 1).
	result assignmentToken: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBinaryMessage1: nodes [
	| result |
	result := GtPharoBinaryMessageNode new.
	result selectorPart: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
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

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBlock2: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBracket: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBlockArgs1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
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

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForBooleanLiteral1: nodes [
	| result |
	result := GtPharoBooleanLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForByteArrayLiteral1: nodes [
	| result |
	result := GtPharoByteArrayLiteralNode new.
	result arrayStart: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result values.
	result arrayStop: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForCascade1: nodes [
	| result |
	result := GtPharoCascadeNode new.
	result receiver: ((nodes at: 1) at: 1).
	result addNode: ((nodes at: 1) at: 2) to: result messages.
	result addTokens: ((nodes at: 2) at: 1) to: result semicolons.
	result addNodes: ((nodes at: 2) at: 2) to: result messages.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForCharacterLiteral1: nodes [
	| result |
	result := GtPharoCharacterLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForEndLiteralArray1: nodes [
	self endLiteralArray.
	^ nil
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordMessage1: nodes [
	| result |
	result := GtPharoKeywordMessageNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result values.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordMessageSend1: nodes [
	| result |
	result := GtPharoMessageSendNode new.
	result receiver: ((nodes at: 1) at: 1).
	result message: ((nodes at: 1) at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordPattern1: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethod1: nodes [
	| result |
	result := GtPharoMethodNode new.
	result pattern: (nodes at: 1).
	result body: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern1: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern3: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern4: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern7: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern8: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addToken: (nodes at: 2) to: result selectorParts.
	result smaccError: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence10: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addTokens: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence11: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addTokens: (nodes at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence12: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addTokens: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addTokens: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence13: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence14: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addTokens: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence15: nodes [
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
GtPharoParser >> reduceActionForMethodSequence16: nodes [
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

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence2: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result rightBar: ((nodes at: 2) at: 3).
	result addNodes: (nodes at: 3) to: result pragmas.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addTokens: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence3: nodes [
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
GtPharoParser >> reduceActionForMethodSequence4: nodes [
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
GtPharoParser >> reduceActionForMethodSequence5: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence6: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: (nodes at: 2) to: result pragmas.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addTokens: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence7: nodes [
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
GtPharoParser >> reduceActionForMethodSequence8: nodes [
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
GtPharoParser >> reduceActionForMethodSequence9: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForNamedVariable1: nodes [
	| result |
	result := GtPharoNamedVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForNilLiteral1: nodes [
	| result |
	result := GtPharoNilLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForNumberLiteral1: nodes [
	| result |
	result := GtPharoNumberLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma1: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addToken: (nodes at: 2) to: result selectorParts.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma2: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 2) to: result values.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma4: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma5: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma__pragma__2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence1: nodes [
	| result |
	result := GtPharoSequenceNode new.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence2: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result statements.
	result addTokens: ((nodes at: 1) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence3: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addTokens: (nodes at: 1) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence4: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addTokens: (nodes at: 1) to: result periods.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addTokens: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence5: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence6: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addTokens: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence7: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addTokens: (nodes at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence8: nodes [
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
GtPharoParser >> reduceActionForStartTemplate1: nodes [
	| result |
	result := GtPharoTemplateNode new.
	result leftBraces: (nodes at: 1).
	result expression: (nodes at: 2).
	result rightBraces: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatement1: nodes [
	| result |
	result := GtPharoReturnNode new.
	result upArrow: (nodes at: 1).
	result value: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatementList1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatementList2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatements2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStringLiteral1: nodes [
	| result |
	result := GtPharoStringLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSwitchToLiteralArray1: nodes [
	self scope: #literalArray.
	^ #array
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbolLiteral1: nodes [
	| result |
	result := GtPharoSymbolLiteralNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateKeyword2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	self addAll: (nodes at: 1) to: (result at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateKeywordMessage1: nodes [
	| result |
	result := GtPharoTemplateKeywordMessageNode new.
	result addNodes: ((nodes at: 2) at: 1) to: result parts.
	result addTokens: ((nodes at: 2) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 3) to: result values.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateKeywordMessage2: nodes [
	| result |
	result := GtPharoTemplateKeywordMessageNode new.
	result addTokens: ((nodes at: 2) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 2) to: result values.
	result addNodes: ((nodes at: 3) at: 1) to: result parts.
	result addTokens: ((nodes at: 3) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 3) at: 3) to: result values.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateKeywordPattern1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	result at: 2 put: ((nodes at: 1) at: 2).
	result at: 3 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateNamePart1: nodes [
	| result |
	result := GtPharoTemplateNamePartNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePattern1: nodes [
	| result |
	result := GtPharoTemplatePatternNode new.
	result addNodes: (nodes at: 2) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePattern2: nodes [
	| result |
	result := GtPharoTemplatePatternNode new.
	result addNodes: ((nodes at: 2) at: 1) to: result parts.
	result addTokens: ((nodes at: 2) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePattern3: nodes [
	| result |
	result := GtPharoTemplatePatternNode new.
	result addTokens: ((nodes at: 2) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result addNodes: ((nodes at: 3) at: 1) to: result parts.
	result addTokens: ((nodes at: 3) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePragma1: nodes [
	| result |
	result := GtPharoTemplatePragmaNode new.
	result lessThan: (nodes at: 2).
	result addNodes: (nodes at: 3) to: result parts.
	result greaterThan: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePragma2: nodes [
	| result |
	result := GtPharoTemplatePragmaNode new.
	result lessThan: (nodes at: 2).
	result addNodes: ((nodes at: 3) at: 1) to: result parts.
	result addTokens: ((nodes at: 3) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 3) at: 3) to: result values.
	result greaterThan: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePragma3: nodes [
	| result |
	result := GtPharoTemplatePragmaNode new.
	result lessThan: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 3) at: 2) to: result values.
	result addNodes: ((nodes at: 4) at: 1) to: result parts.
	result addTokens: ((nodes at: 4) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 4) at: 3) to: result values.
	result greaterThan: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateUnaryMessage1: nodes [
	| result |
	result := GtPharoTemplateUnaryMessageNode new.
	result addNodes: (nodes at: 2) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateVariable1: nodes [
	| result |
	result := GtPharoTemplateVariableNode new.
	result addNodes: (nodes at: 2) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateWithName1: nodes [
	| result |
	result := nodes at: 2.
	self addFirst: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateWithName3: nodes [
	| result |
	result := nodes at: 3.
	self addFirst: (nodes at: 1) to: result.
	self addFirst: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemporaries1: nodes [
	| result |
	result := Array new: 3.
	result at: 2 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self addAll: (nodes at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForUnaryMessage1: nodes [
	| result |
	result := GtPharoUnaryMessageNode new.
	result selectorPart: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForValue5: nodes [
	| result |
	result := nodes at: 2.
	result addFirstToken: (nodes at: 1) to: result leftParens.
	result addToken: (nodes at: 3) to: result rightParens.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForValue6: nodes [
	| result |
	result := GtPharoPatternMessageBlockNode new.
	result leftBrace: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 3).
	result rightBrace: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForValue7: nodes [
	| result |
	result := GtPharoPatternMessageBlockNode new.
	result node: (nodes at: 1).
	result leftBrace: (nodes at: 2).
	result addTokens: ((nodes at: 3) at: 1) to: result colons.
	result addNodes: ((nodes at: 3) at: 2) to: result variables.
	result bar: ((nodes at: 3) at: 3).
	result body: (nodes at: 4).
	result rightBrace: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForValue8: nodes [
	| result |
	result := GtPharoErrorNode new.
	result smaccError: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForVariable1: nodes [
	| result |
	result := GtPharoSelfVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForVariable2: nodes [
	| result |
	result := GtPharoSuperVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForVariable3: nodes [
	| result |
	result := GtPharoThisContextVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForVariable__variable__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part___2: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_TemplateKeywordPattern_KeywordPattern__1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	self add: ((nodes at: 1) at: 3) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_TemplateKeywordPattern_KeywordPattern__2: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	self add: ((nodes at: 1) at: 3) to: (result at: 3).
	self addAll: ((nodes at: 2) at: 1) to: (result at: 2).
	self addAll: ((nodes at: 2) at: 2) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: nodes [
	| result |
	result := nodes at: 2.
	self addAllFirst: ((nodes at: 1) at: 1) to: (result at: 1).
	self addAllFirst: ((nodes at: 1) at: 2) to: (result at: 2).
	self addAllFirst: ((nodes at: 1) at: 3) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	self add: (nodes at: 2) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	result at: 3 put: (OrderedCollection new: 2).
	self addAll: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	self add: (nodes at: 2) to: (result at: 3).
	self addAll: ((nodes at: 3) at: 1) to: (result at: 2).
	self addAll: ((nodes at: 3) at: 2) to: (result at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__keyword___selectorPart__Variable__variable___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__keyword___selectorPart__Variable__variable___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__period___period___Assignment__value___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__period___period___Assignment__value___2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_period___period__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

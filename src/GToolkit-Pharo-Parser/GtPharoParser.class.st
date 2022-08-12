Class {
	#name : #GtPharoParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoParser class >> ambiguousTransitions [
^#(
#[ 0 34 1 161] 
#[ 0 34 0 105] 
#[ 0 46 1 161] 
#[ 0 46 0 105] 
#[ 0 150 1 93] 
#[ 0 198 2 173] 
#[ 0 105 0 198] 
#[ 1 18 1 22] 
#[ 1 78 1 161] 
#[ 0 105 1 78] 
#[ 0 10 1 93] 
#[ 1 93 1 154] 
#[ 1 93 1 162] 
#[ 0 158 1 93] 
#[ 2 150 2 154] 
#[ 2 158 2 173] 
#[ 0 105 2 158]
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> cacheId [
	^'2022-08-12T14:36:27.436054-05:00'
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
	<rbNamePattern> <rbKeywordPattern> <rbLiteralArrayKeywordPattern> <rbPatternBlock>;
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
default <leftBrace>
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
default <rightBrace>
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
	: TemplateWithName {{}}
	| KeywordPattern? (TemplateKeywordPattern KeywordPattern?)+ {{}}
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
PragmaArgument
	: Literal 'value'
	| Variable 'value'
	;
TemplatePragma
	: <lt> 'lessThan' TemplateWithName <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' (<keyword> 'selectorPart' PragmaArgument)+? (TemplateKeyword PragmaArgument (<keyword> 'selectorPart' PragmaArgument)+?)+ <gt> 'greaterThan' {{}}
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
	: (<keyword> 'selectorPart' BinaryMessageSend 'value')+? (TemplateKeyword BinaryMessageSend 'value' (<keyword> 'selectorPart' BinaryMessageSend 'value')+?)+ {{}}
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
	| TemplateUnaryMessage
	;
TemplateUnaryMessage
	: TemplateWithName {{}}
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
	: TemplateWithName {{}}
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
	| <rbLiteralArrayKeywordPattern> 'value' {{SymbolLiteral}}
	| <name> 'value' {{SymbolLiteral}}
	| <rbNamePattern> 'value' {{SymbolLiteral}}
	| <binary> 'value' {{SymbolLiteral}}
	| <period> 'value' {{SymbolLiteral}}
	| <return> 'value' {{SymbolLiteral}}
	| <semicolon> 'value' {{SymbolLiteral}}
	| <colon> 'value' {{SymbolLiteral}}
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

{ #category : #generated }
GtPharoParser class >> reduceTable [
^#(
	#(121 0 #reduceActionForSwitchToLiteralArray1: 9484289 true) 
	#(66 0 #reduceActionForSequence1: 4896769 false) 
	#(38 1 #reduceActionForMethodPattern1: 2825217 false) 
	#(51 1 #reduceActionForTemplateNamePart1: 3850241 false) 
	#(40 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3139585 false) 
	#(38 1 #liftFirstValue: 2825221 false) 
	#(43 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: 3315713 false) 
	#(41 1 #reduceActionForTemplatePattern2: 3254274 false) 
	#(41 1 #reduceActionForTemplatePattern1: 3254273 false) 
	#(42 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern__1: 3315713 false) 
	#(38 1 #reduceActionForMethodPattern4: 2825220 false) 
	#(63 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4581377 false) 
	#(61 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: 4562945 false) 
	#(47 0 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: 3534849 false) 
	#(38 1 #reduceActionForMethodPattern1: 2825218 false) 
	#(95 1 #reduceActionForVariable1: 6734849 false) 
	#(95 1 #reduceActionForVariable2: 6734850 false) 
	#(95 1 #reduceActionForVariable3: 6734851 false) 
	#(119 1 #reduceActionForBooleanLiteral1: 9380865 false) 
	#(119 1 #reduceActionForBooleanLiteral1: 9380866 false) 
	#(120 1 #reduceActionForNilLiteral1: 9447425 false) 
	#(96 1 #reduceActionForNamedVariable1: 6905857 false) 
	#(68 0 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: 4996097 false) 
	#(109 1 #reduceActionForStringLiteral1: 8266753 false) 
	#(118 1 #reduceActionForSymbolLiteral1: 9337857 false) 
	#(117 1 #reduceActionForCharacterLiteral1: 9288705 false) 
	#(110 1 #reduceActionForNumberLiteral1: 8309761 false) 
	#(110 1 #reduceActionForNumberLiteral1: 8309762 false) 
	#(107 0 #reduceActionForBlockArgs1: 8040449 false) 
	#(115 0 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: 9145345 false) 
	#(65 1 #reduceActionFor_period___period__1: 4719617 false) 
	#(97 1 #reduceActionForTemplateVariable1: 6991873 false) 
	#(64 1 #reduceActionForMethodSequence9: 4672521 false) 
	#(52 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: 3909633 false) 
	#(53 1 #reduceActionFor_period___period__1: 3920897 false) 
	#(54 1 #liftFirstValue: 3941379 false) 
	#(66 1 #reduceActionForSequence3: 4896771 false) 
	#(64 1 #liftFirstValue: 4672529 false) 
	#(66 1 #reduceActionForSequence5: 4896773 false) 
	#(66 1 #reduceActionForSequence2: 4896770 false) 
	#(69 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: 5038081 false) 
	#(70 1 #reduceActionForStatementList1: 5090305 false) 
	#(71 1 #liftFirstValue: 5192706 false) 
	#(72 1 #liftFirstValue: 5273602 false) 
	#(73 1 #liftFirstValue: 5374980 false) 
	#(78 1 #reduceActionForKeywordMessageSend1: 5702657 false) 
	#(78 1 #liftFirstValue: 5702658 false) 
	#(88 1 #reduceActionForKeywordMessageSend1: 6217729 false) 
	#(88 1 #liftFirstValue: 6217730 false) 
	#(91 1 #reduceActionForKeywordMessageSend1: 6461441 false) 
	#(100 1 #liftFirstValue: 7286785 false) 
	#(95 1 #liftFirstValue: 6734852 false) 
	#(95 1 #liftFirstValue: 6734853 false) 
	#(91 1 #liftFirstValue: 6461442 false) 
	#(100 1 #liftFirstValue: 7286787 false) 
	#(100 1 #liftFirstValue: 7286788 false) 
	#(100 1 #liftFirstValue: 7286786 false) 
	#(108 1 #liftFirstValue: 8113153 false) 
	#(108 1 #liftFirstValue: 8113154 false) 
	#(108 1 #liftFirstValue: 8113155 false) 
	#(108 1 #liftFirstValue: 8113156 false) 
	#(108 1 #liftFirstValue: 8113157 false) 
	#(108 1 #liftFirstValue: 8113158 false) 
	#(108 1 #liftFirstValue: 8113159 false) 
	#(108 1 #liftFirstValue: 8113160 false) 
	#(96 1 #reduceActionForNamedVariable1: 6905858 false) 
	#(100 1 #reduceActionForValue8: 7286792 false) 
	#(62 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4581377 false) 
	#(39 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 3139585 false) 
	#(38 2 #reduceActionForMethodPattern7: 2825223 false) 
	#(38 2 #reduceActionForMethodPattern3: 2825219 false) 
	#(38 2 #reduceActionForMethodPattern7: 2825222 false) 
	#(37 2 #reduceActionForMethod1: 2759681 false) 
	#(40 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3139586 false) 
	#(43 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 3315714 false) 
	#(49 2 #reduceActionForTemplateKeyword2: 3664898 false) 
	#(49 2 #reduceActionForTemplateKeyword2: 3664897 false) 
	#(42 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern__2: 3315714 false) 
	#(48 2 #reduceActionForTemplateKeywordPattern1: 3598337 false) 
	#(46 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: 3411969 false) 
	#(44 2 #reduceActionForTemplateWithName1: 3366913 false) 
	#(45 1 #reduceActionFor_period___period__1: 3411969 false) 
	#(41 2 #reduceActionForTemplatePattern3: 3254275 false) 
	#(63 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4581378 false) 
	#(44 2 #reduceActionForTemplateWithName1: 3366914 false) 
	#(50 1 #reduceActionForTemplateNamePart1: 3766273 false) 
	#(62 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4581378 false) 
	#(71 2 #reduceActionForStatement1: 5192705 false) 
	#(56 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4035585 false) 
	#(60 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: 4455425 false) 
	#(54 2 #reduceActionForPragma4: 3941380 false) 
	#(101 2 #reduceActionForArray1: 7582721 false) 
	#(103 0 #reduceActionFor__period___period___Assignment__value___1: 7636993 false) 
	#(106 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 7868417 false) 
	#(64 2 #reduceActionForMethodSequence11: 4672523 false) 
	#(64 2 #reduceActionForMethodSequence13: 4672525 false) 
	#(64 2 #reduceActionForMethodSequence10: 4672522 false) 
	#(53 2 #reduceActionForPragma__pragma__2: 3920898 false) 
	#(65 2 #reduceActionForPragma__pragma__2: 4719618 false) 
	#(66 2 #reduceActionForSequence4: 4896772 false) 
	#(64 2 #reduceActionForMethodSequence5: 4672517 false) 
	#(66 2 #reduceActionForSequence7: 4896775 false) 
	#(66 2 #reduceActionForSequence6: 4896774 false) 
	#(69 2 #reduceActionForStatements2: 5038082 false) 
	#(73 2 #reduceActionForCascade1: 5374977 false) 
	#(76 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5573633 false) 
	#(74 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: 5553153 false) 
	#(79 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 5789697 false) 
	#(82 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5894145 false) 
	#(80 1 #reduceActionForKeywordMessage1: 5875713 false) 
	#(80 1 #liftFirstValue: 5875714 false) 
	#(85 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: 6107137 false) 
	#(83 1 #reduceActionForTemplateKeywordMessage1: 6024193 false) 
	#(87 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 6151169 false) 
	#(89 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6301697 false) 
	#(73 2 #reduceActionForCascade1: 5374978 false) 
	#(93 1 #reduceActionForUnaryMessage1: 6612993 false) 
	#(94 1 #reduceActionForTemplateUnaryMessage1: 6684673 false) 
	#(92 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6532097 false) 
	#(93 1 #liftFirstValue: 6612994 false) 
	#(73 2 #reduceActionForCascade1: 5374979 false) 
	#(112 0 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: 8458241 false) 
	#(38 3 #reduceActionForMethodPattern8: 2825224 false) 
	#(46 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: 3411970 false) 
	#(45 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part___2: 3411970 false) 
	#(47 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: 3534850 false) 
	#(44 3 #reduceActionForTemplateWithName3: 3366915 false) 
	#(99 3 #reduceActionForStartTemplate1: 7158785 false) 
	#(67 3 #reduceActionForTemporaries1: 4963329 false) 
	#(68 2 #reduceActionForPragma__pragma__2: 4996098 false) 
	#(54 3 #reduceActionForPragma1: 3941377 false) 
	#(55 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4035585 false) 
	#(57 1 #liftFirstValue: 4255746 false) 
	#(57 1 #liftFirstValue: 4255745 false) 
	#(58 3 #reduceActionForTemplatePragma1: 4314113 false) 
	#(59 2 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: 4455425 false) 
	#(54 3 #reduceActionForPragma2: 3941378 false) 
	#(56 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4035586 false) 
	#(58 3 #reduceActionForTemplatePragma2: 4314114 false) 
	#(60 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 4455426 false) 
	#(54 3 #reduceActionForPragma5: 3941381 false) 
	#(101 3 #reduceActionForArray2: 7582722 false) 
	#(105 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 7868417 false) 
	#(107 2 #reduceActionForBlockArgs2: 8040450 false) 
	#(104 3 #reduceActionForBlock2: 7736322 false) 
	#(106 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 7868418 false) 
	#(100 3 #reduceActionForValue5: 7286789 false) 
	#(114 3 #reduceActionForByteArrayLiteral1: 9094145 false) 
	#(116 1 #liftFirstValue: 9212929 false) 
	#(115 2 #reduceActionForPragma__pragma__2: 9145346 false) 
	#(116 1 #reduceActionForValue8: 9212930 false) 
	#(64 3 #reduceActionForMethodSequence12: 4672524 false) 
	#(64 3 #reduceActionForMethodSequence1: 4672513 false) 
	#(64 3 #reduceActionForMethodSequence15: 4672527 false) 
	#(64 3 #reduceActionForMethodSequence14: 4672526 false) 
	#(64 3 #reduceActionForMethodSequence7: 4672519 false) 
	#(64 3 #reduceActionForMethodSequence6: 4672518 false) 
	#(66 3 #reduceActionForSequence8: 4896776 false) 
	#(70 3 #reduceActionForStatementList2: 5090306 false) 
	#(75 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 5573633 false) 
	#(77 1 #liftFirstValue: 5630977 false) 
	#(77 1 #liftFirstValue: 5630978 false) 
	#(77 1 #liftFirstValue: 5630979 false) 
	#(76 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5573634 false) 
	#(86 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6151169 false) 
	#(81 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 5894145 false) 
	#(90 2 #reduceActionForBinaryMessage1: 6385665 false) 
	#(84 2 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: 6107137 false) 
	#(82 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5894146 false) 
	#(85 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 6107138 false) 
	#(83 2 #reduceActionForTemplateKeywordMessage2: 6024194 false) 
	#(87 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 6151170 false) 
	#(81 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 5894146 false) 
	#(72 3 #reduceActionForAssignment1: 5273601 false) 
	#(122 0 #reduceActionForEndLiteralArray1: 9548801 true) 
	#(98 3 #reduceActionForStartTemplate1: 7037953 false) 
	#(59 3 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: 4455426 false) 
	#(58 4 #reduceActionForTemplatePragma3: 4314115 false) 
	#(101 4 #reduceActionForArray3: 7582723 false) 
	#(103 2 #reduceActionFor__period___period___Assignment__value___2: 7636994 false) 
	#(104 4 #reduceActionForBlock1: 7736321 false) 
	#(104 4 #reduceActionForBlock3: 7736323 false) 
	#(64 4 #reduceActionForMethodSequence3: 4672515 false) 
	#(64 4 #reduceActionForMethodSequence2: 4672514 false) 
	#(64 4 #reduceActionForMethodSequence16: 4672528 false) 
	#(64 4 #reduceActionForMethodSequence8: 4672520 false) 
	#(84 3 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: 6107138 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536068 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536066 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536072 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536074 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536070 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536073 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536071 false) 
	#(113 1 #liftFirstValue: 8536065 false) 
	#(112 2 #reduceActionForPragma__pragma__2: 8458242 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536067 false) 
	#(113 1 #reduceActionForSymbolLiteral1: 8536069 false) 
	#(113 1 #reduceActionForValue8: 8536076 false) 
	#(100 4 #reduceActionForValue6: 7286790 false) 
	#(101 5 #reduceActionForArray4: 7582724 false) 
	#(102 2 #reduceActionForTemplateKeyword2: 7636993 false) 
	#(64 5 #reduceActionForMethodSequence4: 4672516 false) 
	#(100 5 #reduceActionForValue7: 7286791 false) 
	#(111 5 #reduceActionForArrayLiteral1: 8386561 false) 
	#(113 3 #reduceActionForArrayLiteralValue11: 8536075 false)
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
	^ #('"self"' '"super"' '"thisContext"' '<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<symbol>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' 'B e g i n' 'Method' 'MethodPattern' '(<keyword> ''selectorPart'' Variable ''variable'')' '(<keyword> ''selectorPart'' Variable ''variable'')+' 'TemplatePattern' '(TemplateKeywordPattern KeywordPattern?)' '(TemplateKeywordPattern KeywordPattern?)+' 'TemplateWithName' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)+' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)*' 'TemplateKeywordPattern' 'TemplateKeyword' 'TemplateNameContinuationPart' 'TemplateNamePart' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(<keyword> ''selectorPart'' PragmaArgument)' '(<keyword> ''selectorPart'' PragmaArgument)+' 'PragmaArgument' 'TemplatePragma' '(TemplateKeyword PragmaArgument (<keyword> ''selectorPart'' PragmaArgument)+?)' '(TemplateKeyword PragmaArgument (<keyword> ''selectorPart'' PragmaArgument)+?)+' 'KeywordPattern' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'') Variable ''variable'')' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'') Variable ''variable'')+' 'MethodSequence' '<period> ''period''+' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'')  BinaryMessageSend ''value'')' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'')  BinaryMessageSend ''value'')+' 'TemplateKeywordMessage' '(TemplateKeyword BinaryMessageSend ''value'' (<keyword> ''selectorPart'' BinaryMessageSend ''value'')+?)' '(TemplateKeyword BinaryMessageSend ''value'' (<keyword> ''selectorPart'' BinaryMessageSend ''value'')+?)+' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'TemplateUnaryMessage' 'Variable' 'NamedVariable' 'TemplateVariable' 'MidTemplate' 'StartTemplate' 'Value' 'Array' '(<period> ''period''+ Assignment ''value'')' '(<period> ''period''+ Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' '<doubleLeftBrace>' '<doubleLeftBraceStart>' '<doubleRightBrace>' '<rbKeywordPattern>' '<rbLiteralArrayKeywordPattern>' '<rbNamePattern>' '<rbPatternBlock>' '<templateKeyword>' '<templateNamePart>' 'E O F' 'error')
]

{ #category : #generated }
GtPharoParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #GtPharoTemplatePatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoTemplateNamePartNode #GtPharoTemplateNamePartNode #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #GtPharoValueNode #GtPharoTemplatePragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoTemplateKeywordMessageNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoTemplateUnaryMessageNode #GtPharoValueNode #GtPharoNamedVariableNode #GtPharoTemplateVariableNode #GtPharoTemplateNode #GtPharoTemplateNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoParser class >> transitionTable [
^#(
#[1 0 33 0 7 0 37 0 28 0 41 0 29 0 45 0 37 0 49 0 38 0 53 0 39 0 57 0 40 0 49 0 41 0 65 0 42 0 69 0 43 0 73 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 89 0 61 0 93 0 62 0 97 0 63 0 101 0 99 0 105 0 124 0 109 0 126 0 113 0 128] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 173 0 17 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 193 0 32 0 197 0 44 0 85 0 51 0 201 0 52 0 205 0 53 0 209 0 54 0 209 0 58 0 217 0 64 0 221 0 65 0 217 0 66 0 229 0 67 0 233 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 0 10 0 132 1 93 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 1 97 0 71 1 97 0 72 1 97 0 73 1 97 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 0 33 0 7 0 37 0 28 0 41 0 29 1 101 0 38 0 53 0 39 0 57 0 40 1 101 0 41 0 65 0 42 0 69 0 43 0 73 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 89 0 61 0 93 0 62 0 97 0 63 0 101 0 99 0 105 0 124 0 109 0 126 0 113 0 128] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 1 105 0 78 1 109 0 79 1 5 0 88 1 113 0 89 1 13 0 91 1 117 0 92 1 13 0 95 1 13 0 96 1 13 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 0 197 0 44 0 85 0 51 1 125 0 95 1 125 0 96 1 125 0 97 0 101 0 99 0 105 0 124 1 85 0 128] 
#[1 0 173 0 17 1 129 0 54 1 129 0 58] 
#[1 0 14 0 1 0 14 0 2 0 14 0 3 0 14 0 4 0 14 0 5 0 14 0 6 0 14 0 7 0 14 0 9 0 14 0 10 0 14 0 11 0 14 0 12 0 14 0 13 0 14 0 14 0 14 0 16 0 14 0 17 0 14 0 19 0 14 0 20 0 14 0 22 0 14 0 23 0 14 0 24 0 14 0 32 0 18 0 123 0 14 0 124 0 14 0 128 0 14 0 129 0 14 0 132 0 14 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 0 197 0 44 0 85 0 51 1 133 0 95 1 133 0 96 1 133 0 97 0 101 0 99 0 105 0 124 1 85 0 128 1 137 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 0 197 0 44 0 85 0 51 1 141 0 95 1 141 0 96 1 141 0 97 0 101 0 99 0 105 0 124 1 85 0 128 1 145 0 133] 
#[0 0 0 0 132] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 173 0 17 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 193 0 32 0 197 0 44 0 85 0 51 0 201 0 52 0 205 0 53 0 209 0 54 0 209 0 58 1 149 0 64 0 221 0 65 1 149 0 66 0 229 0 67 0 233 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 0 10 0 132 1 93 0 133] 
#[0 0 22 0 28] 
#[1 1 153 0 28 1 157 0 39] 
#[0 0 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 0 30 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[1 0 34 0 1 0 34 0 2 0 34 0 3 0 34 0 4 0 34 0 5 0 34 0 6 0 7 0 7 0 34 0 9 0 34 0 10 0 34 0 11 0 34 0 12 0 34 0 13 0 34 0 14 0 34 0 16 0 34 0 17 0 34 0 19 0 34 0 20 0 34 0 22 0 34 0 23 0 34 0 24 0 34 0 32 1 165 0 42 1 169 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 101 0 99 0 11 0 124 0 34 0 128 0 34 0 129 0 34 0 132 0 34 0 133] 
#[1 0 38 0 1 0 38 0 2 0 38 0 3 0 38 0 4 0 38 0 5 0 38 0 6 0 38 0 7 0 38 0 9 0 38 0 10 0 38 0 11 0 38 0 12 0 38 0 13 0 38 0 14 0 38 0 16 0 38 0 17 0 38 0 19 0 38 0 20 1 173 0 21 0 38 0 22 0 38 0 23 0 38 0 24 0 38 0 32 0 38 0 124 0 38 0 128 0 38 0 129 1 177 0 130 0 38 0 132 0 38 0 133] 
#[1 0 42 0 1 0 42 0 2 0 42 0 3 0 42 0 4 0 42 0 5 0 42 0 6 0 42 0 7 0 42 0 9 0 42 0 10 0 42 0 11 0 42 0 12 0 42 0 13 0 42 0 14 0 42 0 16 0 42 0 17 0 42 0 19 0 42 0 20 0 42 0 22 0 42 0 23 0 42 0 24 1 181 0 28 0 42 0 32 1 185 0 61 0 93 0 62 0 97 0 63 0 42 0 124 0 109 0 126 0 42 0 128 0 42 0 129 0 42 0 132 0 42 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 0 197 0 44 0 85 0 51 1 189 0 95 1 189 0 96 1 189 0 97 0 101 0 99 0 105 0 124 1 85 0 128] 
#[1 1 193 0 45 1 197 0 46 1 201 0 98 1 205 0 123] 
#[1 0 46 0 1 0 46 0 2 0 46 0 3 0 46 0 4 0 46 0 5 0 46 0 6 0 15 0 7 0 46 0 9 0 46 0 10 0 46 0 11 0 46 0 12 0 46 0 13 0 46 0 14 0 46 0 16 0 46 0 17 0 46 0 19 0 46 0 20 0 46 0 22 0 46 0 23 0 46 0 24 0 46 0 32 0 65 0 42 1 209 0 43 1 169 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 101 0 99 0 19 0 124 0 46 0 128 0 46 0 129 0 46 0 132 0 46 0 133] 
#[0 0 50 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 124 0 126 0 128 0 129 0 132 0 133] 
#[1 0 54 0 1 0 54 0 2 0 54 0 3 0 54 0 4 0 54 0 5 0 54 0 6 0 54 0 7 0 54 0 9 0 54 0 10 0 54 0 11 0 54 0 12 0 54 0 13 0 54 0 14 0 54 0 16 0 54 0 17 0 54 0 19 0 54 0 20 0 54 0 22 0 54 0 23 0 54 0 24 1 181 0 28 0 54 0 32 1 213 0 62 0 54 0 124 0 109 0 126 0 54 0 128 0 54 0 129 0 54 0 132 0 54 0 133] 
#[1 0 58 0 1 0 58 0 2 0 58 0 3 0 58 0 4 0 58 0 5 0 58 0 6 0 58 0 7 0 58 0 9 0 58 0 10 0 58 0 11 0 58 0 12 0 58 0 13 0 58 0 14 0 58 0 16 0 58 0 17 0 58 0 18 0 58 0 19 0 58 0 20 0 58 0 21 0 58 0 22 0 58 0 23 0 58 0 24 0 58 0 25 0 58 0 26 0 58 0 27 0 58 0 28 0 58 0 29 0 58 0 30 0 58 0 31 0 58 0 32 1 217 0 47 1 221 0 50 0 58 0 123 0 58 0 124 0 58 0 125 0 58 0 126 0 58 0 128 0 58 0 129 0 58 0 130 1 225 0 131 0 58 0 132 0 58 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 1 229 0 72 1 229 0 73 1 229 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 0 197 0 44 0 85 0 51 1 233 0 95 1 233 0 96 1 233 0 97 0 101 0 99 0 105 0 124 1 85 0 128] 
#[0 0 62 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 0 66 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 128 0 129 0 132 0 133] 
#[0 0 70 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 128 0 129 0 132 0 133] 
#[0 0 74 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 128 0 129 0 132 0 133] 
#[0 0 78 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 82 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 86 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[1 0 90 0 1 0 90 0 2 0 90 0 3 0 90 0 4 0 90 0 5 0 90 0 6 0 90 0 7 0 90 0 9 0 90 0 10 0 90 0 11 0 90 0 12 0 90 0 13 0 90 0 14 0 90 0 16 0 90 0 17 0 90 0 18 0 90 0 19 0 90 0 20 0 90 0 21 0 90 0 22 0 90 0 23 0 90 0 24 0 90 0 25 0 90 0 26 0 90 0 27 0 90 0 28 0 90 0 29 0 90 0 30 0 90 0 31 0 90 0 32 0 18 0 123 0 90 0 124 0 90 0 125 0 90 0 126 0 90 0 128 0 90 0 129 0 90 0 132 0 90 0 133] 
#[1 0 94 0 1 0 94 0 2 0 94 0 3 0 94 0 7 0 94 0 9 1 237 0 68 0 94 0 124 0 94 0 128] 
#[0 0 98 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 102 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 106 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 110 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 114 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 1 241 0 72 1 241 0 73 1 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 1 245 0 7 1 249 0 28 1 253 0 44 2 1 0 49 0 85 0 51 2 5 0 55 2 9 0 56 2 13 0 59 2 17 0 60 0 101 0 99 0 105 0 124 2 21 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 2 25 0 27 0 193 0 32 0 197 0 44 0 85 0 51 2 29 0 65 2 33 0 72 2 33 0 73 2 33 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 0 118 0 1 0 118 0 2 0 118 0 3 0 118 0 4 0 118 0 5 0 118 0 6 0 118 0 7 0 118 0 9 0 118 0 10 0 118 0 11 0 118 0 12 0 118 0 13 0 118 0 14 0 118 0 16 0 118 0 19 0 118 0 20 2 37 0 21 0 118 0 22 0 118 0 23 0 118 0 24 0 118 0 26 0 118 0 32 2 41 0 105 2 45 0 106 2 49 0 107 0 118 0 124 0 118 0 128 0 118 0 129 0 118 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 2 53 0 72 2 53 0 73 2 53 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 0 122 0 13 0 122 0 14 0 122 0 26 2 57 0 115 0 122 0 133] 
#[0 0 126 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 0 130 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 128 0 129 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 193 0 32 0 197 0 44 0 85 0 51 2 61 0 65 2 65 0 67 2 69 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 0 134 0 132 1 93 0 133] 
#[1 0 138 0 1 0 138 0 2 0 138 0 3 0 138 0 4 0 138 0 5 0 138 0 6 0 138 0 7 0 138 0 9 0 138 0 10 0 138 0 11 0 138 0 12 0 138 0 13 0 138 0 14 0 138 0 16 0 173 0 17 0 138 0 19 0 138 0 20 0 138 0 22 0 138 0 23 0 138 0 24 0 138 0 32 2 73 0 54 2 73 0 58 0 138 0 124 0 138 0 128 0 138 0 129 0 138 0 132 0 138 0 133] 
#[0 0 142 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 0 146 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 0 0 0 132] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 150 0 26 0 150 0 27 2 77 0 32 0 197 0 44 0 85 0 51 2 81 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 0 150 0 132 0 23 0 133] 
#[0 0 154 0 132] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 173 0 17 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 193 0 32 0 197 0 44 0 85 0 51 2 85 0 52 0 205 0 53 0 209 0 54 0 209 0 58 2 89 0 65 2 93 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 0 158 0 132 1 93 0 133] 
#[0 0 162 0 26 0 27 0 132 0 133] 
#[1 0 166 0 26 0 166 0 27 0 193 0 32 2 97 0 65 0 166 0 132 0 166 0 133] 
#[0 0 170 0 26 0 27 0 32 0 132 0 133] 
#[0 0 174 0 26 0 27 0 32 0 132 0 133] 
#[0 0 178 0 25 0 26 0 27 0 32 0 125 0 132 0 133] 
#[0 0 182 0 25 0 26 0 27 0 32 0 125 0 132 0 133] 
#[1 0 186 0 25 0 186 0 26 0 186 0 27 2 101 0 30 0 186 0 32 2 105 0 74 2 109 0 75 2 113 0 76 0 186 0 125 0 186 0 132 0 186 0 133] 
#[1 1 161 0 7 0 190 0 25 0 190 0 26 0 190 0 27 2 117 0 28 2 121 0 29 0 190 0 32 1 169 0 44 2 125 0 49 0 85 0 51 2 129 0 80 2 133 0 81 2 137 0 82 2 129 0 83 2 145 0 84 2 149 0 85 2 153 0 86 2 157 0 87 2 161 0 90 0 101 0 99 0 105 0 124 0 190 0 125 2 165 0 126 0 190 0 132 0 190 0 133] 
#[1 0 194 0 7 0 194 0 25 0 194 0 26 0 194 0 27 0 194 0 28 0 194 0 29 2 101 0 30 0 194 0 32 2 169 0 74 2 109 0 75 2 113 0 76 0 194 0 124 0 194 0 125 0 194 0 126 0 194 0 132 0 194 0 133] 
#[1 0 27 0 7 0 198 0 25 0 198 0 26 0 198 0 27 0 198 0 28 0 198 0 29 0 198 0 30 0 198 0 32 2 177 0 44 0 85 0 51 2 181 0 93 2 181 0 94 0 101 0 99 0 31 0 124 0 198 0 125 0 198 0 126 2 189 0 129 0 198 0 132 0 198 0 133] 
#[1 0 202 0 7 0 202 0 25 0 202 0 26 0 202 0 27 0 202 0 28 0 202 0 29 2 101 0 30 0 202 0 32 2 193 0 74 2 109 0 75 2 113 0 76 0 202 0 124 0 202 0 125 0 202 0 126 0 202 0 129 0 202 0 132 0 202 0 133] 
#[1 0 206 0 7 0 206 0 25 0 206 0 26 0 206 0 27 0 206 0 28 0 206 0 29 2 197 0 31 0 206 0 32 0 206 0 124 0 206 0 125 0 206 0 126 0 206 0 129 0 206 0 132 0 206 0 133] 
#[0 0 210 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 128 0 129 0 132 0 133] 
#[0 0 214 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 128 0 129 0 132 0 133] 
#[0 0 218 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 0 222 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 0 226 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 0 230 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 0 234 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 238 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 242 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 246 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 250 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 0 254 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 1 2 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 1 6 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 2 201 0 23] 
#[0 1 10 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 124 0 125 0 126 0 128 0 129 0 132 0 133] 
#[1 0 118 0 1 0 118 0 2 0 118 0 3 0 118 0 4 0 118 0 5 0 118 0 6 0 118 0 7 0 118 0 9 0 118 0 10 0 118 0 11 0 118 0 12 0 118 0 13 0 118 0 14 0 118 0 16 0 118 0 19 0 118 0 20 2 37 0 21 0 118 0 22 0 118 0 23 0 118 0 24 0 118 0 27 0 118 0 32 2 41 0 105 2 205 0 106 2 209 0 107 0 118 0 124 0 118 0 128 0 118 0 129 0 118 0 133] 
#[0 1 14 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 0 0 0 132] 
#[0 0 0 0 132] 
#[0 0 0 0 132] 
#[0 0 186 0 132] 
#[0 0 194 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 132 0 133] 
#[0 0 202 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 0 206 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 0 0 0 132] 
#[0 0 0 0 132] 
#[1 1 18 0 1 1 18 0 2 1 18 0 3 1 18 0 4 1 18 0 5 1 18 0 6 1 18 0 7 1 18 0 9 1 18 0 10 1 18 0 11 1 18 0 12 1 18 0 13 1 18 0 14 1 18 0 16 1 18 0 17 1 18 0 19 1 18 0 20 1 18 0 22 1 18 0 23 1 18 0 24 0 35 0 28 1 18 0 32 1 18 0 124 1 18 0 126 1 18 0 128 1 18 0 129 1 18 0 132 1 18 0 133] 
#[0 1 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 1 30 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 1 34 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 1 38 0 132] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 0 197 0 44 0 85 0 51 2 213 0 95 2 213 0 96 2 213 0 97 0 101 0 99 0 105 0 124 1 85 0 128 2 217 0 133] 
#[0 1 42 0 28] 
#[0 0 18 0 123] 
#[0 1 46 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[1 1 173 0 21 1 177 0 130] 
#[0 1 50 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 19 0 20 0 22 0 23 0 24 0 124 0 128 0 129 0 133] 
#[0 1 54 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 19 0 20 0 22 0 23 0 24 0 124 0 128 0 129 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 0 197 0 44 0 85 0 51 2 221 0 95 2 221 0 96 2 221 0 97 0 101 0 99 0 105 0 124 1 85 0 128] 
#[0 1 58 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 1 62 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 124 0 126 0 128 0 129 0 132 0 133] 
#[0 1 66 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 123 0 124 0 125 0 126 0 128 0 129 0 130 0 132 0 133] 
#[1 1 70 0 1 1 70 0 2 1 70 0 3 1 70 0 4 1 70 0 5 1 70 0 6 1 70 0 7 1 70 0 9 1 70 0 10 1 70 0 11 1 70 0 12 1 70 0 13 1 70 0 14 1 70 0 16 1 70 0 17 1 70 0 18 1 70 0 19 1 70 0 20 1 70 0 21 1 70 0 22 1 70 0 23 1 70 0 24 1 70 0 25 1 70 0 26 1 70 0 27 1 70 0 28 1 70 0 29 1 70 0 30 1 70 0 31 1 70 0 32 2 225 0 45 1 201 0 98 1 205 0 123 1 70 0 124 1 70 0 125 1 70 0 126 1 70 0 128 1 70 0 129 1 70 0 130 1 70 0 132 1 70 0 133] 
#[1 1 74 0 1 1 74 0 2 1 74 0 3 1 74 0 4 1 74 0 5 1 74 0 6 1 74 0 7 1 74 0 9 1 74 0 10 1 74 0 11 1 74 0 12 1 74 0 13 1 74 0 14 1 74 0 16 1 74 0 17 1 74 0 18 1 74 0 19 1 74 0 20 1 74 0 21 1 74 0 22 1 74 0 23 1 74 0 24 1 74 0 25 1 74 0 26 1 74 0 27 1 74 0 28 1 74 0 29 1 74 0 30 1 74 0 31 1 74 0 32 2 229 0 50 1 74 0 123 1 74 0 124 1 74 0 125 1 74 0 126 1 74 0 128 1 74 0 129 1 74 0 130 1 225 0 131 1 74 0 132 1 74 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 2 233 0 72 2 233 0 73 2 233 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 1 78 0 1 1 78 0 2 1 78 0 3 1 78 0 4 1 78 0 5 1 78 0 6 0 39 0 7 1 78 0 9 1 78 0 10 1 78 0 11 1 78 0 12 1 78 0 13 1 78 0 14 1 78 0 16 1 78 0 17 1 78 0 19 1 78 0 20 1 78 0 22 1 78 0 23 1 78 0 24 1 78 0 32 1 165 0 42 1 169 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 101 0 99 0 43 0 124 1 78 0 128 1 78 0 129 1 78 0 132 1 78 0 133] 
#[0 1 82 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 124 0 126 0 128 0 129 0 132 0 133] 
#[1 1 86 0 1 1 86 0 2 1 86 0 3 1 86 0 4 1 86 0 5 1 86 0 6 1 86 0 7 1 86 0 9 1 86 0 10 1 86 0 11 1 86 0 12 1 86 0 13 1 86 0 14 1 86 0 16 1 86 0 17 1 86 0 18 1 86 0 19 1 86 0 20 1 86 0 21 1 86 0 22 1 86 0 23 1 86 0 24 1 86 0 25 1 86 0 26 1 86 0 27 1 86 0 28 1 86 0 29 1 86 0 30 1 86 0 31 1 86 0 32 2 237 0 45 1 201 0 98 1 205 0 123 1 86 0 124 1 86 0 125 1 86 0 126 1 86 0 128 1 86 0 129 1 86 0 130 1 86 0 132 1 86 0 133] 
#[1 0 58 0 1 0 58 0 2 0 58 0 3 0 58 0 4 0 58 0 5 0 58 0 6 0 58 0 7 0 58 0 9 0 58 0 10 0 58 0 11 0 58 0 12 0 58 0 13 0 58 0 14 0 58 0 16 0 58 0 17 0 58 0 18 0 58 0 19 0 58 0 20 0 58 0 21 0 58 0 22 0 58 0 23 0 58 0 24 0 58 0 25 0 58 0 26 0 58 0 27 0 58 0 28 0 58 0 29 0 58 0 30 0 58 0 31 0 58 0 32 2 241 0 47 0 58 0 123 0 58 0 124 0 58 0 125 0 58 0 126 0 58 0 128 0 58 0 129 0 58 0 130 0 58 0 132 0 58 0 133] 
#[0 1 90 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 123 0 124 0 125 0 126 0 128 0 129 0 130 0 132 0 133] 
#[0 2 245 0 125] 
#[0 1 94 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 124 0 126 0 128 0 129 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 2 249 0 9 0 197 0 44 0 85 0 51 2 253 0 95 2 253 0 96 2 253 0 97 0 101 0 99 0 105 0 124 1 85 0 128] 
#[0 1 98 0 26 0 27 0 32 0 132 0 133] 
#[1 3 1 0 18 0 18 0 123] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 3 5 0 57 3 5 0 95 3 5 0 96 3 5 0 97 0 101 0 99 3 5 0 108 3 5 0 109 3 5 0 110 3 5 0 111 3 5 0 114 3 5 0 117 3 5 0 118 3 5 0 119 3 5 0 120 1 81 0 121 0 105 0 124 1 85 0 128] 
#[1 3 17 0 18 1 173 0 21 1 177 0 130] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 3 21 0 57 3 21 0 95 3 21 0 96 3 21 0 97 0 101 0 99 3 21 0 108 3 21 0 109 3 21 0 110 3 21 0 111 3 21 0 114 3 21 0 117 3 21 0 118 3 21 0 119 3 21 0 120 1 81 0 121 0 105 0 124 1 85 0 128] 
#[0 1 102 0 7 0 18 0 28 0 124] 
#[1 1 161 0 7 3 25 0 18 1 249 0 28 1 169 0 44 2 1 0 49 0 85 0 51 3 29 0 55 2 13 0 59 3 33 0 60 0 101 0 99 0 105 0 124] 
#[0 1 106 0 7 0 18 0 124] 
#[1 1 161 0 7 3 37 0 18 1 169 0 44 2 1 0 49 0 85 0 51 3 41 0 59 0 101 0 99 0 105 0 124] 
#[1 1 110 0 1 1 110 0 2 1 110 0 3 1 110 0 4 1 110 0 5 1 110 0 6 1 110 0 7 1 110 0 9 1 110 0 10 1 110 0 11 1 110 0 12 1 110 0 13 1 110 0 14 1 110 0 16 1 110 0 17 3 45 0 18 1 110 0 19 1 110 0 20 1 110 0 22 1 110 0 23 1 110 0 24 1 110 0 32 1 110 0 124 1 110 0 128 1 110 0 129 1 110 0 132 1 110 0 133] 
#[0 1 114 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[1 3 49 0 27 2 77 0 32] 
#[1 1 118 0 27 1 118 0 32 3 53 0 103] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 141 0 7 0 197 0 44 0 85 0 51 3 57 0 95 3 57 0 96 3 57 0 97 0 101 0 99 0 105 0 124 1 85 0 128] 
#[0 1 122 0 9 0 21 0 26] 
#[1 3 61 0 9 2 37 0 21 3 65 0 26 3 69 0 105] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 10 0 26 0 193 0 32 0 197 0 44 0 85 0 51 0 221 0 65 3 73 0 66 3 77 0 67 0 233 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 0 47 0 133] 
#[0 3 81 0 25] 
#[1 0 161 0 13 0 165 0 14 3 85 0 26 3 93 0 110 3 93 0 116 3 97 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 2 77 0 32 0 197 0 44 0 85 0 51 3 101 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 126 0 132 1 93 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 173 0 17 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 193 0 32 0 197 0 44 0 85 0 51 3 105 0 52 0 205 0 53 0 209 0 54 0 209 0 58 3 109 0 65 3 113 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 130 0 132 1 93 0 133] 
#[0 1 134 0 132] 
#[0 1 138 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 1 142 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 1 146 0 26 0 27 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 193 0 32 0 197 0 44 0 85 0 51 3 117 0 65 3 121 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 150 0 132 1 93 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 1 154 0 26 1 154 0 27 2 77 0 32 0 197 0 44 0 85 0 51 3 125 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 154 0 132 0 51 0 133] 
#[0 1 158 0 26 0 27 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 1 162 0 26 1 162 0 27 2 77 0 32 0 197 0 44 0 85 0 51 3 129 0 71 3 129 0 72 3 129 0 73 3 129 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 162 0 132 0 55 0 133] 
#[1 2 173 0 7 2 117 0 28 2 121 0 29 3 133 0 44 2 125 0 49 0 85 0 51 3 137 0 77 3 137 0 80 2 133 0 81 2 137 0 82 3 137 0 83 2 145 0 84 2 149 0 85 2 153 0 86 2 157 0 87 3 137 0 90 3 137 0 93 3 137 0 94 0 101 0 99 0 105 0 124 2 165 0 126] 
#[0 1 166 0 25 0 26 0 27 0 32 0 125 0 132 0 133] 
#[0 1 170 0 25 0 26 0 27 0 30 0 32 0 125 0 132 0 133] 
#[1 1 174 0 25 1 174 0 26 1 174 0 27 2 101 0 30 1 174 0 32 3 153 0 75 1 174 0 125 1 174 0 132 1 174 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 3 157 0 88 1 113 0 89 1 13 0 91 1 117 0 92 1 13 0 95 1 13 0 96 1 13 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 3 161 0 91 1 117 0 92 3 161 0 95 3 161 0 96 3 161 0 97 0 101 0 99 3 161 0 100 3 161 0 101 3 161 0 104 3 161 0 108 3 161 0 109 3 161 0 110 3 161 0 111 3 161 0 114 3 161 0 117 3 161 0 118 3 161 0 119 3 161 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 3 165 0 88 1 113 0 89 1 13 0 91 1 117 0 92 1 13 0 95 1 13 0 96 1 13 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[0 1 178 0 25 0 26 0 27 0 30 0 32 0 125 0 132 0 133] 
#[0 1 182 0 25 0 26 0 27 0 28 0 30 0 32 0 125 0 126 0 132 0 133] 
#[1 1 186 0 25 1 186 0 26 1 186 0 27 3 169 0 28 1 186 0 30 1 186 0 32 3 173 0 81 1 186 0 125 2 165 0 126 1 186 0 132 1 186 0 133] 
#[0 1 190 0 25 0 26 0 27 0 30 0 32 0 125 0 132 0 133] 
#[0 1 194 0 7 0 25 0 26 0 27 0 30 0 32 0 124 0 125 0 132 0 133] 
#[1 1 161 0 7 1 198 0 25 1 198 0 26 1 198 0 27 1 198 0 30 1 198 0 32 1 169 0 44 2 125 0 49 0 85 0 51 3 177 0 84 0 101 0 99 0 105 0 124 1 198 0 125 1 198 0 132 1 198 0 133] 
#[0 1 202 0 7 0 25 0 26 0 27 0 28 0 30 0 32 0 124 0 125 0 132 0 133] 
#[1 1 161 0 7 3 181 0 28 1 169 0 44 2 125 0 49 0 85 0 51 2 145 0 84 3 185 0 85 3 189 0 86 0 101 0 99 0 105 0 124] 
#[0 1 206 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 3 193 0 88 1 113 0 89 1 13 0 91 1 117 0 92 1 13 0 95 1 13 0 96 1 13 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[0 1 210 0 25 0 26 0 27 0 32 0 125 0 132 0 133] 
#[1 1 214 0 7 1 214 0 25 1 214 0 26 1 214 0 27 1 214 0 28 1 214 0 29 1 214 0 30 1 214 0 32 0 18 0 123 1 214 0 124 1 214 0 125 1 214 0 126 1 214 0 129 1 214 0 132 1 214 0 133] 
#[0 1 218 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 1 222 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 1 226 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[1 0 118 0 1 0 118 0 2 0 118 0 3 0 118 0 4 0 118 0 5 0 118 0 6 0 118 0 7 0 118 0 9 0 118 0 10 0 118 0 11 0 118 0 12 0 118 0 13 0 118 0 14 0 118 0 16 0 118 0 19 0 118 0 20 2 37 0 21 0 118 0 22 0 118 0 23 0 118 0 24 0 118 0 27 0 118 0 32 2 41 0 105 2 205 0 106 3 197 0 107 0 118 0 124 0 118 0 128 0 118 0 129 0 118 0 133] 
#[0 1 230 0 25 0 26 0 27 0 32 0 125 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 3 201 0 72 3 201 0 73 3 201 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 1 234 0 4 1 234 0 5 1 234 0 6 1 234 0 7 1 234 0 10 1 234 0 11 1 234 0 12 1 234 0 13 1 234 0 14 1 234 0 15 1 234 0 16 1 234 0 21 1 234 0 22 1 234 0 23 1 234 0 24 1 234 0 25 1 234 0 29 1 234 0 30 1 234 0 32 3 205 0 112 1 234 0 127 1 234 0 128 1 234 0 133] 
#[1 3 61 0 9 2 37 0 21 3 69 0 105] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 10 0 27 0 193 0 32 0 197 0 44 0 85 0 51 0 221 0 65 3 209 0 66 3 77 0 67 0 233 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[0 1 22 0 28] 
#[0 1 238 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 1 18 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 124 0 126 0 128 0 129 0 132 0 133] 
#[0 1 242 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 123 0 124 0 125 0 126 0 128 0 129 0 130 0 132 0 133] 
#[0 1 246 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 123 0 124 0 125 0 126 0 128 0 129 0 130 0 132 0 133] 
#[0 3 213 0 125] 
#[0 1 250 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 123 0 124 0 125 0 126 0 128 0 129 0 130 0 132 0 133] 
#[1 1 254 0 1 1 254 0 2 1 254 0 3 1 254 0 4 1 254 0 5 1 254 0 6 1 254 0 7 1 254 0 9 1 254 0 10 1 254 0 11 1 254 0 12 1 254 0 13 1 254 0 14 1 254 0 16 1 254 0 17 1 254 0 18 1 254 0 19 1 254 0 20 1 254 0 21 1 254 0 22 1 254 0 23 1 254 0 24 1 254 0 25 1 254 0 26 1 254 0 27 1 254 0 28 1 254 0 29 1 254 0 30 1 254 0 31 1 254 0 32 2 237 0 45 1 201 0 98 1 205 0 123 1 254 0 124 1 254 0 125 1 254 0 126 1 254 0 128 1 254 0 129 1 254 0 130 1 254 0 132 1 254 0 133] 
#[0 2 2 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 123 0 124 0 125 0 126 0 128 0 129 0 130 0 131 0 132 0 133] 
#[0 2 6 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 2 10 0 1 0 2 0 3 0 7 0 9 0 124 0 128] 
#[0 2 14 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 2 18 0 7 0 18 0 28 0 124] 
#[0 2 22 0 7 0 18 0 28 0 124] 
#[0 2 26 0 7 0 18 0 28 0 124] 
#[0 2 30 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[1 2 34 0 7 2 34 0 18 1 249 0 28 2 5 0 55 3 217 0 56 2 34 0 124] 
#[0 2 38 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 2 42 0 7 0 18 0 28 0 124] 
#[1 1 161 0 7 3 221 0 18 1 169 0 44 2 1 0 49 0 85 0 51 3 41 0 59 0 101 0 99 0 105 0 124] 
#[0 2 46 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 2 50 0 7 0 18 0 124] 
#[0 2 54 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 2 58 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[1 3 225 0 27 0 193 0 32 3 229 0 65 3 233 0 102] 
#[0 2 62 0 9 0 21 0 26] 
#[0 2 66 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 124 0 128 0 129 0 133] 
#[0 2 70 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 2 74 0 9 0 21 0 26] 
#[1 3 237 0 26 3 241 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 158 0 26 0 158 0 27 0 193 0 32 0 197 0 44 0 85 0 51 2 89 0 65 2 93 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 0 59 0 133] 
#[0 2 78 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 2 82 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 2 86 0 13 0 14 0 26 0 133] 
#[0 2 90 0 13 0 14 0 26 0 133] 
#[0 2 94 0 13 0 14 0 26 0 133] 
#[0 2 98 0 132] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 193 0 32 0 197 0 44 0 85 0 51 3 245 0 65 3 249 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 2 102 0 132 1 93 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 2 77 0 32 0 197 0 44 0 85 0 51 3 253 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 2 106 0 132 1 93 0 133] 
#[0 2 110 0 132] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 2 77 0 32 0 197 0 44 0 85 0 51 4 1 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 2 114 0 132 1 93 0 133] 
#[0 2 118 0 132] 
#[0 2 122 0 26 0 27 0 132 0 133] 
#[0 2 126 0 26 0 27 0 32 0 132 0 133] 
#[1 1 173 0 21 1 218 0 25 1 218 0 26 1 218 0 27 1 218 0 30 1 218 0 32 1 218 0 125 1 177 0 130 1 218 0 132 1 218 0 133] 
#[0 2 130 0 25 0 26 0 27 0 30 0 32 0 125 0 132 0 133] 
#[0 2 134 0 25 0 26 0 27 0 30 0 32 0 125 0 132 0 133] 
#[0 2 138 0 25 0 26 0 27 0 30 0 32 0 125 0 132 0 133] 
#[0 2 142 0 25 0 26 0 27 0 30 0 32 0 125 0 132 0 133] 
#[0 2 146 0 25 0 26 0 27 0 30 0 32 0 125 0 132 0 133] 
#[1 2 150 0 7 2 154 0 25 2 154 0 26 2 154 0 27 0 63 0 28 2 121 0 29 2 154 0 30 2 154 0 32 2 161 0 90 2 150 0 124 2 154 0 125 2 154 0 126 2 154 0 132 2 154 0 133] 
#[1 0 67 0 7 2 158 0 25 2 158 0 26 2 158 0 27 2 158 0 28 2 158 0 29 2 158 0 30 2 158 0 32 2 177 0 44 0 85 0 51 2 181 0 93 2 181 0 94 0 101 0 99 0 71 0 124 2 158 0 125 2 158 0 126 2 189 0 129 2 158 0 132 2 158 0 133] 
#[1 2 162 0 7 2 162 0 25 2 162 0 26 2 162 0 27 3 181 0 28 2 121 0 29 2 162 0 30 2 162 0 32 2 153 0 86 4 5 0 87 2 161 0 90 2 162 0 124 2 162 0 125 2 162 0 132 2 162 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 4 9 0 88 1 113 0 89 1 13 0 91 1 117 0 92 1 13 0 95 1 13 0 96 1 13 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[0 2 166 0 25 0 26 0 27 0 28 0 30 0 32 0 125 0 126 0 132 0 133] 
#[0 2 170 0 7 0 25 0 26 0 27 0 30 0 32 0 124 0 125 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 197 0 44 0 85 0 51 4 13 0 88 1 113 0 89 1 13 0 91 1 117 0 92 1 13 0 95 1 13 0 96 1 13 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[1 1 161 0 7 2 174 0 25 2 174 0 26 2 174 0 27 2 174 0 30 2 174 0 32 1 169 0 44 2 125 0 49 0 85 0 51 3 177 0 84 0 101 0 99 0 105 0 124 2 174 0 125 2 174 0 132 2 174 0 133] 
#[0 2 178 0 7 0 25 0 26 0 27 0 28 0 30 0 32 0 124 0 125 0 132 0 133] 
#[1 2 182 0 25 2 182 0 26 2 182 0 27 2 182 0 28 2 121 0 29 2 182 0 30 2 182 0 32 2 161 0 90 2 182 0 125 2 182 0 126 2 182 0 132 2 182 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 145 0 9 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 0 10 0 27 0 193 0 32 0 197 0 44 0 85 0 51 0 221 0 65 4 17 0 66 3 77 0 67 0 233 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[0 2 186 0 25 0 26 0 27 0 32 0 125 0 132 0 133] 
#[1 0 129 0 4 0 133 0 5 0 137 0 6 4 21 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 4 25 0 15 4 29 0 16 4 33 0 21 4 37 0 22 0 6 0 23 0 189 0 24 2 190 0 25 4 41 0 29 4 45 0 30 4 49 0 32 4 57 0 108 4 57 0 109 4 57 0 110 4 57 0 111 4 57 0 113 4 57 0 114 4 57 0 117 4 57 0 118 4 57 0 119 4 57 0 120 1 81 0 121 4 61 0 122 4 65 0 127 4 69 0 128 4 73 0 133] 
#[0 4 77 0 27] 
#[0 2 194 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 123 0 124 0 125 0 126 0 128 0 129 0 130 0 131 0 132 0 133] 
#[1 2 198 0 7 2 198 0 18 1 249 0 28 3 29 0 55 2 198 0 124] 
#[0 2 202 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 124 0 128 0 129 0 132 0 133] 
#[0 2 206 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 4 81 0 27 2 77 0 32 0 197 0 44 0 85 0 51 4 85 0 72 4 85 0 73 4 85 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 1 93 0 133] 
#[0 2 210 0 27 0 32] 
#[0 2 214 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 2 218 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[1 0 117 0 1 0 121 0 2 0 125 0 3 0 129 0 4 0 133 0 5 0 137 0 6 0 141 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 0 169 0 16 0 177 0 19 0 181 0 20 0 185 0 22 0 6 0 23 0 189 0 24 2 77 0 32 0 197 0 44 0 85 0 51 4 89 0 69 0 237 0 70 0 241 0 71 0 241 0 72 0 241 0 73 0 241 0 78 1 1 0 79 1 5 0 88 1 9 0 89 1 13 0 91 1 17 0 92 1 21 0 95 1 21 0 96 1 21 0 97 0 101 0 99 1 13 0 100 1 13 0 101 1 13 0 104 1 13 0 108 1 13 0 109 1 13 0 110 1 13 0 111 1 13 0 114 1 13 0 117 1 13 0 118 1 13 0 119 1 13 0 120 1 81 0 121 0 105 0 124 1 85 0 128 1 89 0 129 2 222 0 132 1 93 0 133] 
#[0 2 226 0 132] 
#[0 2 230 0 132] 
#[0 2 234 0 132] 
#[1 2 238 0 7 2 238 0 25 2 238 0 26 2 238 0 27 3 181 0 28 2 238 0 30 2 238 0 32 3 189 0 86 2 238 0 124 2 238 0 125 2 238 0 132 2 238 0 133] 
#[1 2 154 0 25 2 154 0 26 2 154 0 27 2 154 0 28 2 121 0 29 2 154 0 30 2 154 0 32 2 161 0 90 2 154 0 125 2 154 0 126 2 154 0 132 2 154 0 133] 
#[1 2 150 0 7 2 150 0 25 2 150 0 26 2 150 0 27 2 150 0 28 2 121 0 29 2 150 0 30 2 150 0 32 2 161 0 90 2 150 0 124 2 150 0 125 2 150 0 132 2 150 0 133] 
#[0 4 93 0 27] 
#[0 2 242 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 2 246 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 2 250 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 2 254 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[1 1 234 0 4 1 234 0 5 1 234 0 6 1 234 0 7 1 234 0 10 1 234 0 11 1 234 0 12 1 234 0 13 1 234 0 14 1 234 0 15 1 234 0 16 1 234 0 21 1 234 0 22 1 234 0 23 1 234 0 24 1 234 0 25 1 234 0 29 1 234 0 30 1 234 0 32 4 97 0 112 1 234 0 127 1 234 0 128 1 234 0 133] 
#[0 3 2 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 3 6 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 3 10 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 3 14 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 3 18 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 4 101 0 25] 
#[0 3 22 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 3 26 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 3 30 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133] 
#[0 3 34 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 3 38 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[0 3 42 0 27 0 32] 
#[0 3 46 0 132] 
#[0 3 50 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 129 0 132 0 133] 
#[1 0 129 0 4 0 133 0 5 0 137 0 6 4 21 0 7 0 149 0 10 0 153 0 11 0 157 0 12 0 161 0 13 0 165 0 14 4 25 0 15 4 29 0 16 4 33 0 21 4 37 0 22 0 6 0 23 0 189 0 24 4 105 0 25 4 41 0 29 4 45 0 30 4 49 0 32 4 57 0 108 4 57 0 109 4 57 0 110 4 57 0 111 4 57 0 113 4 57 0 114 4 57 0 117 4 57 0 118 4 57 0 119 4 57 0 120 1 81 0 121 4 65 0 127 4 69 0 128 4 73 0 133] 
#[0 3 54 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 124 0 125 0 126 0 127 0 128 0 129 0 132 0 133] 
#[0 3 58 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 21 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 127 0 128 0 133]
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
GtPharoParser >> reduceActionForArrayLiteralValue11: nodes [
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
	result addNodes: ((nodes at: 1) at: 1) to: result parts.
	result addTokens: ((nodes at: 1) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 3) to: result values.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateKeywordMessage2: nodes [
	| result |
	result := GtPharoTemplateKeywordMessageNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result values.
	result addNodes: ((nodes at: 2) at: 1) to: result parts.
	result addTokens: ((nodes at: 2) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 3) to: result values.
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
	result addNodes: (nodes at: 1) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePattern2: nodes [
	| result |
	result := GtPharoTemplatePatternNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result parts.
	result addTokens: ((nodes at: 1) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePattern3: nodes [
	| result |
	result := GtPharoTemplatePatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addNodes: ((nodes at: 2) at: 1) to: result parts.
	result addTokens: ((nodes at: 2) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePragma1: nodes [
	| result |
	result := GtPharoTemplatePragmaNode new.
	result lessThan: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result parts.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePragma2: nodes [
	| result |
	result := GtPharoTemplatePragmaNode new.
	result lessThan: (nodes at: 1).
	result addNodes: ((nodes at: 2) at: 1) to: result parts.
	result addTokens: ((nodes at: 2) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 3) to: result values.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplatePragma3: nodes [
	| result |
	result := GtPharoTemplatePragmaNode new.
	result lessThan: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 2) to: result values.
	result addNodes: ((nodes at: 3) at: 1) to: result parts.
	result addTokens: ((nodes at: 3) at: 2) to: result selectorParts.
	result addNodes: ((nodes at: 3) at: 3) to: result values.
	result greaterThan: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateUnaryMessage1: nodes [
	| result |
	result := GtPharoTemplateUnaryMessageNode new.
	result addNodes: (nodes at: 1) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForTemplateVariable1: nodes [
	| result |
	result := GtPharoTemplateVariableNode new.
	result addNodes: (nodes at: 1) to: result parts.
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
GtPharoParser >> reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part___2: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: nodes [
	| result |
	result := OrderedCollection new: 2.
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
GtPharoParser >> reduceActionFor_TemplateKeywordPattern_KeywordPattern___1: nodes [
	| result |
	result := nodes at: 1.
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

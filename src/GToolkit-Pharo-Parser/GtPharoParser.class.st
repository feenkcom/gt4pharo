Class {
	#name : #GtPharoParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoParser class >> ambiguousTransitions [
^#(
#[ 0 89 0 118] 
#[ 0 178 2 117] 
#[ 0 89 0 178] 
#[ 1 2 1 6] 
#[ 1 38 1 153] 
#[ 1 153 1 226] 
#[ 2 117 2 118] 
#[ 0 89 2 118]
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> cacheId [
	^'2023-05-02T08:58:12.143681-05:00'
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
	GSPath
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


default gs literalArray <true>
	: true
	;
default gs literalArray <false>
	: false
	;
default gs literalArray <nil>
	: nil
	;
default gs literalArray <name>
	:  (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;
gs <gsPath>
	:  <name> (\. <name>)+
	;
default gs <nameAssignment>
	: <name> \:\=
	;
default gs <bar>
	: \|
	;
default gs literalArray <string>
	: ( \' [^\']* \' )+
	;
default gs literalArray <symbol>
	: \#{1,2} ( <name> (\:\: <name>)* | <binary> | <keyword>+ | <string> )
	;
default gs literalArray <character>
	: \$ .
	;
default gs literalArray <number>
	: \d
	;
default gs literalArray <negativeNumber>
	: \- <number>
	;
literalArray <literalArrayKeyword>
	: <keyword>+
	;
default gs literalArray <return>
	: \^
	;
default gs <lt>
	: \<
	;
default gs <gt>
	: \>
	;
default gs literalArray <leftBrace>
	: \{
	;
default gs literalArray <leftBracket>
	: \[
	;
default gs literalArray <colon>
	: \:
	;
default gs literalArray <leftParen>
	: \(
	;
default gs literalArray <literalArrayStart>
	: \#\(
	;
default gs literalArray <byteArrayStart>
	: \#\[
	;
default gs literalArray <rightParen>
	: \)
	;
default gs literalArray <rightBracket>
	: \]
	;
default gs literalArray <rightBrace>
	: \}
	;
default gs <keyword>
	: <name> \:
	;
default gs literalArray <binary>
	: [\~\-\!\@\%\&\*\+\=\\\|\?\/\>\<\,] +
	;
default gs literalArray <semicolon>
	: \;
	;
default gs <assign>
	: \: \=
	;
default gs literalArray <period>
	: \.
	;
default gs literalArray <comment>
	: \"" [^\""]* \""
	;
default gs literalArray <whitespace>
	: (\s | \x0)+
	;
default gs <patternToken>
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
	: <lt> 'lessThan' <name> 'selectorPart' <gt> 'greaterThan' {{}}
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
	| GemStonePath 
	;
GemStonePath
	: <gsPath> 'name' {{GSPath}}
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
	#(124 0 #reduceActionForSwitchToLiteralArray1: 9988097 true) 
	#(68 0 #reduceActionForSequence1: 5175297 false) 
	#(39 1 #reduceActionForMethodPattern1: 3014657 false) 
	#(41 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3329025 false) 
	#(39 1 #liftFirstValue: 3014661 false) 
	#(39 1 #reduceActionForMethodPattern4: 3014660 false) 
	#(65 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4859905 false) 
	#(63 1 #reduceActionForKeywordPattern1: 4841473 false) 
	#(39 1 #reduceActionForMethodPattern1: 3014658 false) 
	#(58 1 #nil 4470785 false) 
	#(97 1 #reduceActionForVariable1: 7079937 false) 
	#(97 1 #reduceActionForVariable2: 7079938 false) 
	#(97 1 #reduceActionForVariable3: 7079939 false) 
	#(122 1 #reduceActionForBooleanLiteral1: 9884673 false) 
	#(122 1 #reduceActionForBooleanLiteral1: 9884674 false) 
	#(123 1 #reduceActionForNilLiteral1: 9951233 false) 
	#(99 1 #reduceActionForNamedVariable1: 7315457 false) 
	#(98 1 #reduceActionForGemStonePath1: 7268353 false) 
	#(70 0 #reduceActionForVariable__variable__1: 5274625 false) 
	#(112 1 #reduceActionForStringLiteral1: 8596481 false) 
	#(121 1 #reduceActionForSymbolLiteral1: 9841665 false) 
	#(120 1 #reduceActionForCharacterLiteral1: 9792513 false) 
	#(113 1 #reduceActionForNumberLiteral1: 8639489 false) 
	#(113 1 #reduceActionForNumberLiteral1: 8639490 false) 
	#(110 0 #reduceActionForBlockArgs1: 8370177 false) 
	#(118 0 #reduceActionForVariable__variable__1: 9649153 false) 
	#(67 1 #reduceActionFor_period___period__1: 4998145 false) 
	#(66 1 #reduceActionForMethodSequence9: 4951049 false) 
	#(53 1 #reduceActionForKeywordPattern1: 4125697 false) 
	#(54 1 #reduceActionFor_period___period__1: 4136961 false) 
	#(55 1 #liftFirstValue: 4157443 false) 
	#(68 1 #reduceActionForSequence3: 5175299 false) 
	#(66 1 #liftFirstValue: 4951057 false) 
	#(68 1 #reduceActionForSequence5: 5175301 false) 
	#(68 1 #reduceActionForSequence2: 5175298 false) 
	#(71 1 #reduceActionForKeywordPattern1: 5316609 false) 
	#(72 1 #reduceActionForStatementList1: 5368833 false) 
	#(73 1 #liftFirstValue: 5471234 false) 
	#(74 1 #liftFirstValue: 5552130 false) 
	#(75 1 #liftFirstValue: 5653508 false) 
	#(80 1 #reduceActionForKeywordMessageSend1: 5981185 false) 
	#(80 1 #liftFirstValue: 5981186 false) 
	#(90 1 #reduceActionForKeywordMessageSend1: 6509569 false) 
	#(90 1 #liftFirstValue: 6509570 false) 
	#(93 1 #reduceActionForKeywordMessageSend1: 6753281 false) 
	#(103 1 #liftFirstValue: 7709697 false) 
	#(97 1 #liftFirstValue: 7079942 false) 
	#(97 1 #liftFirstValue: 7079940 false) 
	#(97 1 #liftFirstValue: 7079941 false) 
	#(93 1 #liftFirstValue: 6753282 false) 
	#(103 1 #liftFirstValue: 7709699 false) 
	#(103 1 #liftFirstValue: 7709700 false) 
	#(103 1 #liftFirstValue: 7709698 false) 
	#(111 1 #liftFirstValue: 8442881 false) 
	#(111 1 #liftFirstValue: 8442882 false) 
	#(111 1 #liftFirstValue: 8442883 false) 
	#(111 1 #liftFirstValue: 8442884 false) 
	#(111 1 #liftFirstValue: 8442885 false) 
	#(111 1 #liftFirstValue: 8442886 false) 
	#(111 1 #liftFirstValue: 8442887 false) 
	#(111 1 #liftFirstValue: 8442888 false) 
	#(99 1 #reduceActionForNamedVariable1: 7315458 false) 
	#(103 1 #reduceActionForValue8: 7709704 false) 
	#(64 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4859905 false) 
	#(40 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 3329025 false) 
	#(39 2 #reduceActionForMethodPattern7: 3014663 false) 
	#(39 2 #reduceActionForMethodPattern3: 3014659 false) 
	#(39 2 #reduceActionForMethodPattern7: 3014662 false) 
	#(38 2 #reduceActionForMethod1: 2949121 false) 
	#(41 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3329026 false) 
	#(52 1 #reduceActionForTemplateNamePart1: 4066305 false) 
	#(44 1 #reduceActionForKeywordPattern1: 3531777 false) 
	#(42 2 #reduceActionForTemplatePattern2: 3443714 false) 
	#(42 2 #reduceActionForTemplatePattern1: 3443713 false) 
	#(43 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern__1: 3531777 false) 
	#(48 0 #reduceActionForVariable__variable__1: 3750913 false) 
	#(65 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4859906 false) 
	#(64 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4859906 false) 
	#(73 2 #reduceActionForStatement1: 5471233 false) 
	#(57 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4250625 false) 
	#(55 2 #reduceActionForPragma4: 4157444 false) 
	#(104 2 #reduceActionForArray1: 8005633 false) 
	#(106 0 #reduceActionFor__period___period___Assignment__value___1: 8059905 false) 
	#(109 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 8291329 false) 
	#(66 2 #reduceActionForMethodSequence11: 4951051 false) 
	#(66 2 #reduceActionForMethodSequence13: 4951053 false) 
	#(66 2 #reduceActionForMethodSequence10: 4951050 false) 
	#(54 2 #reduceActionForPragma__pragma__2: 4136962 false) 
	#(100 2 #reduceActionForTemplateVariable1: 7401473 false) 
	#(67 2 #reduceActionForPragma__pragma__2: 4998146 false) 
	#(68 2 #reduceActionForSequence4: 5175300 false) 
	#(66 2 #reduceActionForMethodSequence5: 4951045 false) 
	#(68 2 #reduceActionForSequence7: 5175303 false) 
	#(68 2 #reduceActionForSequence6: 5175302 false) 
	#(71 2 #reduceActionForStatements2: 5316610 false) 
	#(75 2 #reduceActionForCascade1: 5653505 false) 
	#(78 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5852161 false) 
	#(76 1 #reduceActionForKeywordPattern1: 5831681 false) 
	#(81 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6068225 false) 
	#(84 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 6172673 false) 
	#(82 1 #reduceActionForKeywordMessage1: 6154241 false) 
	#(82 1 #liftFirstValue: 6154242 false) 
	#(91 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6593537 false) 
	#(75 2 #reduceActionForCascade1: 5653506 false) 
	#(95 1 #reduceActionForUnaryMessage1: 6904833 false) 
	#(94 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6823937 false) 
	#(95 1 #liftFirstValue: 6904835 false) 
	#(95 1 #reduceActionForUnaryMessage1: 6904834 false) 
	#(75 2 #reduceActionForCascade1: 5653507 false) 
	#(115 0 #reduceActionForVariable__variable__1: 8787969 false) 
	#(39 3 #reduceActionForMethodPattern8: 3014664 false) 
	#(44 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 3531778 false) 
	#(50 2 #reduceActionForTemplateKeyword2: 3880962 false) 
	#(50 2 #reduceActionForTemplateKeyword2: 3880961 false) 
	#(43 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern__2: 3531778 false) 
	#(49 2 #reduceActionForTemplateKeywordPattern1: 3814401 false) 
	#(47 1 #reduceActionForKeywordPattern1: 3628033 false) 
	#(45 2 #reduceActionForTemplateWithName1: 3582977 false) 
	#(46 1 #reduceActionFor_period___period__1: 3628033 false) 
	#(42 3 #reduceActionForTemplatePattern3: 3443715 false) 
	#(45 2 #reduceActionForTemplateWithName1: 3582978 false) 
	#(51 1 #reduceActionForTemplateNamePart1: 3982337 false) 
	#(69 3 #reduceActionForTemporaries1: 5241857 false) 
	#(70 2 #reduceActionForPragma__pragma__2: 5274626 false) 
	#(55 3 #reduceActionForPragma1: 4157441 false) 
	#(56 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 4250625 false) 
	#(59 1 #liftFirstValue: 4507650 false) 
	#(59 1 #liftFirstValue: 4507649 false) 
	#(55 3 #reduceActionForPragma2: 4157442 false) 
	#(57 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4250626 false) 
	#(55 3 #reduceActionForPragma5: 4157445 false) 
	#(104 3 #reduceActionForArray2: 8005634 false) 
	#(108 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 8291329 false) 
	#(110 2 #reduceActionForBlockArgs2: 8370178 false) 
	#(107 3 #reduceActionForBlock2: 8159234 false) 
	#(109 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 8291330 false) 
	#(103 3 #reduceActionForValue5: 7709701 false) 
	#(117 3 #reduceActionForByteArrayLiteral1: 9597953 false) 
	#(119 1 #liftFirstValue: 9716737 false) 
	#(118 2 #reduceActionForPragma__pragma__2: 9649154 false) 
	#(119 1 #reduceActionForValue8: 9716738 false) 
	#(66 3 #reduceActionForMethodSequence12: 4951052 false) 
	#(66 3 #reduceActionForMethodSequence1: 4951041 false) 
	#(66 3 #reduceActionForMethodSequence15: 4951055 false) 
	#(66 3 #reduceActionForMethodSequence14: 4951054 false) 
	#(62 1 #reduceActionForKeywordPattern1: 4733953 false) 
	#(66 3 #reduceActionForMethodSequence7: 4951047 false) 
	#(66 3 #reduceActionForMethodSequence6: 4951046 false) 
	#(68 3 #reduceActionForSequence8: 5175304 false) 
	#(72 3 #reduceActionForStatementList2: 5368834 false) 
	#(77 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 5852161 false) 
	#(79 1 #liftFirstValue: 5909505 false) 
	#(79 1 #liftFirstValue: 5909506 false) 
	#(79 1 #liftFirstValue: 5909507 false) 
	#(78 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5852162 false) 
	#(83 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6172673 false) 
	#(92 2 #reduceActionForBinaryMessage1: 6677505 false) 
	#(87 1 #reduceActionForKeywordPattern1: 6398977 false) 
	#(85 2 #reduceActionForTemplateKeywordMessage1: 6302721 false) 
	#(89 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 6443009 false) 
	#(84 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 6172674 false) 
	#(83 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6172674 false) 
	#(96 2 #reduceActionForTemplateUnaryMessage1: 7016449 false) 
	#(74 3 #reduceActionForAssignment1: 5552129 false) 
	#(125 0 #reduceActionForEndLiteralArray1: 10052609 true) 
	#(47 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: 3628034 false) 
	#(46 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part___2: 3628034 false) 
	#(48 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: 3750914 false) 
	#(45 3 #reduceActionForTemplateWithName3: 3582979 false) 
	#(102 3 #reduceActionForStartTemplate1: 7581697 false) 
	#(104 4 #reduceActionForArray3: 8005635 false) 
	#(106 2 #reduceActionFor__period___period___Assignment__value___2: 8059906 false) 
	#(107 4 #reduceActionForBlock1: 8159233 false) 
	#(66 4 #reduceActionForMethodSequence3: 4951043 false) 
	#(66 4 #reduceActionForMethodSequence2: 4951042 false) 
	#(66 4 #reduceActionForMethodSequence16: 4951056 false) 
	#(60 4 #reduceActionForTemplatePragma1: 4566017 false) 
	#(61 2 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: 4733953 false) 
	#(60 4 #reduceActionForTemplatePragma2: 4566018 false) 
	#(62 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 4733954 false) 
	#(66 4 #reduceActionForMethodSequence8: 4951048 false) 
	#(88 2 #reduceActionFor___keyword___selectorPart_____rbKeywordPattern___selectorPart___Variable__variable__1: 6443009 false) 
	#(86 2 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: 6398977 false) 
	#(87 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 6398978 false) 
	#(85 3 #reduceActionForTemplateKeywordMessage2: 6302722 false) 
	#(89 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 6443010 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865796 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865794 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865800 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865803 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865805 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865802 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865806 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865804 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865798 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865801 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865799 false) 
	#(116 1 #liftFirstValue: 8865793 false) 
	#(115 2 #reduceActionForPragma__pragma__2: 8787970 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865795 false) 
	#(116 1 #reduceActionForSymbolLiteral1: 8865797 false) 
	#(116 1 #reduceActionForValue8: 8865808 false) 
	#(103 4 #reduceActionForValue6: 7709702 false) 
	#(101 3 #reduceActionForStartTemplate1: 7460865 false) 
	#(104 5 #reduceActionForArray4: 8005636 false) 
	#(105 2 #reduceActionForTemplateKeyword2: 8059905 false) 
	#(66 5 #reduceActionForMethodSequence4: 4951044 false) 
	#(61 3 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: 4733954 false) 
	#(60 5 #reduceActionForTemplatePragma3: 4566019 false) 
	#(86 3 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: 6398978 false) 
	#(103 5 #reduceActionForValue7: 7709703 false) 
	#(114 5 #reduceActionForArrayLiteral1: 8716289 false) 
	#(116 3 #reduceActionForArrayLiteralValue15: 8865807 false)
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
	^ #('"self"' '"super"' '"thisContext"' '<true>' '<false>' '<nil>' '<name>' '<gsPath>' '<nameAssignment>' '<bar>' '<string>' '<symbol>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' 'B e g i n' 'Method' 'MethodPattern' '(<keyword> ''selectorPart'' Variable ''variable'')' '(<keyword> ''selectorPart'' Variable ''variable'')+' 'TemplatePattern' '(TemplateKeywordPattern KeywordPattern?)' '(TemplateKeywordPattern KeywordPattern?)+' 'TemplateWithName' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)+' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)*' 'TemplateKeywordPattern' 'TemplateKeyword' 'TemplateNameContinuationPart' 'TemplateNamePart' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(<keyword> ''selectorPart'' PragmaArgument)' '(<keyword> ''selectorPart'' PragmaArgument)+' 'OnlyTemplate' 'PragmaArgument' 'TemplatePragma' '(TemplateKeyword PragmaArgument (<keyword> ''selectorPart'' PragmaArgument)+?)' '(TemplateKeyword PragmaArgument (<keyword> ''selectorPart'' PragmaArgument)+?)+' 'KeywordPattern' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'') Variable ''variable'')' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'') Variable ''variable'')+' 'MethodSequence' '<period> ''period''+' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'')  BinaryMessageSend ''value'')' '((<keyword> ''selectorPart'' | <rbKeywordPattern> ''selectorPart'')  BinaryMessageSend ''value'')+' 'TemplateKeywordMessage' '(TemplateKeyword BinaryMessageSend ''value'' (<keyword> ''selectorPart'' BinaryMessageSend ''value'')+?)' '(TemplateKeyword BinaryMessageSend ''value'' (<keyword> ''selectorPart'' BinaryMessageSend ''value'')+?)+' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'TemplateUnaryMessage' 'Variable' 'GemStonePath' 'NamedVariable' 'TemplateVariable' 'MidTemplate' 'StartTemplate' 'Value' 'Array' '(<period> ''period''+ Assignment ''value'')' '(<period> ''period''+ Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' '<doubleLeftBrace>' '<doubleLeftBraceStart>' '<doubleRightBrace>' '<rbKeywordPattern>' '<rbLiteralArrayKeywordPattern>' '<rbNamePattern>' '<rbPatternBlock>' '<template>' '<templateKeyword>' '<templateNamePart>' 'E O F' 'error')
]

{ #category : #generated }
GtPharoParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #GtPharoTemplatePatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoTemplateNamePartNode #GtPharoTemplateNamePartNode #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection nil #GtPharoValueNode #GtPharoTemplatePragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoTemplateKeywordMessageNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoTemplateUnaryMessageNode #GtPharoValueNode #GtPharoGSPathNode #GtPharoNamedVariableNode #GtPharoTemplateVariableNode #GtPharoTemplateNode #GtPharoTemplateNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoParser class >> transitionTable [
^#(
#[1 0 33 0 7 0 37 0 29 0 41 0 30 0 45 0 38 0 49 0 39 0 53 0 40 0 57 0 41 0 49 0 42 0 65 0 58 0 69 0 63 0 73 0 64 0 77 0 65 0 81 0 129 0 85 0 131 0 89 0 133] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 153 0 18 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 173 0 33 0 177 0 53 0 181 0 54 0 185 0 55 0 189 0 58 0 185 0 60 0 197 0 66 0 201 0 67 0 197 0 68 0 209 0 69 0 213 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 0 10 0 136 1 77 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 1 85 0 73 1 85 0 74 1 85 0 75 1 85 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 0 33 0 7 0 37 0 29 0 41 0 30 1 89 0 39 0 53 0 40 0 57 0 41 1 89 0 42 0 65 0 58 0 69 0 63 0 73 0 64 0 77 0 65 0 81 0 129 0 85 0 131 0 89 0 133] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 1 93 0 80 1 97 0 81 0 241 0 90 1 101 0 91 0 249 0 93 1 105 0 94 0 249 0 97 0 249 0 98 0 249 0 99 0 249 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 1 81 0 58 1 113 0 97 1 113 0 98 1 113 0 99 1 113 0 100 1 69 0 131 0 89 0 133] 
#[1 0 153 0 18 1 117 0 55 1 121 0 58 1 117 0 60 0 89 0 133] 
#[0 0 14 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 1 81 0 58 1 125 0 97 1 125 0 98 1 125 0 99 1 125 0 100 1 69 0 131 0 89 0 133 1 129 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 1 81 0 58 1 133 0 97 1 133 0 98 1 133 0 99 1 133 0 100 1 69 0 131 0 89 0 133 1 137 0 137] 
#[0 0 0 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 153 0 18 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 173 0 33 0 177 0 53 0 181 0 54 0 185 0 55 0 189 0 58 0 185 0 60 1 141 0 66 0 201 0 67 1 141 0 68 0 209 0 69 0 213 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 0 10 0 136 1 77 0 137] 
#[0 0 18 0 29] 
#[1 1 145 0 29 1 149 0 40] 
#[0 0 22 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[1 1 153 0 7 1 157 0 29 1 161 0 43 1 165 0 44 1 169 0 45 1 173 0 49 1 177 0 50 1 181 0 52 1 185 0 63 0 73 0 64 0 77 0 65 1 189 0 102 1 193 0 127 0 81 0 129] 
#[0 0 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 0 30 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 29 0 33 0 127 0 129 0 131 0 132 0 133 0 136 0 137] 
#[1 0 34 0 1 0 34 0 2 0 34 0 3 0 34 0 4 0 34 0 5 0 34 0 6 0 34 0 7 0 34 0 8 0 34 0 10 0 34 0 11 0 34 0 12 0 34 0 13 0 34 0 14 0 34 0 15 0 34 0 17 0 34 0 18 0 34 0 20 0 34 0 21 0 34 0 23 0 34 0 24 0 34 0 25 1 157 0 29 0 34 0 33 1 197 0 64 0 34 0 127 0 81 0 129 0 34 0 131 0 34 0 132 0 34 0 133 0 34 0 136 0 34 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 1 81 0 58 1 201 0 97 1 201 0 98 1 201 0 99 1 201 0 100 1 69 0 131 0 89 0 133] 
#[0 0 38 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 0 42 0 7 0 18 0 29 0 127 0 129] 
#[0 0 46 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 0 50 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 0 54 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 0 58 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 62 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 66 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 70 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 0 74 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[1 0 78 0 1 0 78 0 2 0 78 0 3 0 78 0 7 0 78 0 8 0 78 0 10 1 205 0 70 0 78 0 131 0 78 0 133] 
#[0 0 82 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 86 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 90 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 94 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 98 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 1 209 0 74 1 209 0 75 1 209 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 1 213 0 7 1 217 0 29 1 221 0 56 1 225 0 57 1 229 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 233 0 28 0 173 0 33 1 81 0 58 1 237 0 67 1 241 0 74 1 241 0 75 1 241 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 5 0 102 0 6 0 102 0 7 0 102 0 8 0 102 0 10 0 102 0 11 0 102 0 12 0 102 0 13 0 102 0 14 0 102 0 15 0 102 0 17 0 102 0 20 0 102 0 21 1 245 0 22 0 102 0 23 0 102 0 24 0 102 0 25 0 102 0 27 0 102 0 33 1 249 0 108 1 253 0 109 2 1 0 110 0 102 0 131 0 102 0 132 0 102 0 133 0 102 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 2 5 0 74 2 5 0 75 2 5 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 0 106 0 14 0 106 0 15 0 106 0 27 2 9 0 118 0 106 0 137] 
#[0 0 110 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 11 0 12 0 13 0 14 0 15 0 17 0 20 0 21 0 23 0 24 0 25 0 27 0 28 0 33 0 131 0 132 0 133 0 136 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 173 0 33 1 81 0 58 2 13 0 67 2 17 0 69 2 21 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 0 114 0 136 1 77 0 137] 
#[1 0 118 0 1 0 118 0 2 0 118 0 3 0 118 0 4 0 118 0 5 0 118 0 6 0 118 0 7 0 118 0 8 0 118 0 10 0 118 0 11 0 118 0 12 0 118 0 13 0 118 0 14 0 118 0 15 0 118 0 17 0 153 0 18 0 118 0 20 0 118 0 21 0 118 0 23 0 118 0 24 0 118 0 25 0 118 0 33 2 25 0 55 1 121 0 58 2 25 0 60 0 118 0 131 0 118 0 132 0 7 0 133 0 118 0 136 0 118 0 137] 
#[0 0 122 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[1 1 153 0 7 2 29 0 18 2 33 0 45 1 181 0 52 1 189 0 102 1 193 0 127] 
#[0 0 126 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 0 0 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 130 0 27 0 130 0 28 2 37 0 33 1 81 0 58 2 41 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 0 130 0 136 1 77 0 137] 
#[0 0 134 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 153 0 18 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 173 0 33 2 45 0 53 0 181 0 54 0 185 0 55 0 189 0 58 0 185 0 60 2 49 0 67 2 53 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 0 138 0 136 1 77 0 137] 
#[0 0 142 0 27 0 28 0 136] 
#[1 0 146 0 27 0 146 0 28 0 173 0 33 2 57 0 67 0 146 0 136] 
#[0 0 150 0 27 0 28 0 33 0 136] 
#[0 0 154 0 27 0 28 0 33 0 136] 
#[0 0 158 0 26 0 27 0 28 0 33 0 128 0 136] 
#[0 0 162 0 26 0 27 0 28 0 33 0 128 0 136] 
#[1 0 166 0 26 0 166 0 27 0 166 0 28 2 61 0 31 0 166 0 33 2 65 0 76 2 69 0 77 2 73 0 78 0 166 0 128 0 166 0 136] 
#[1 0 170 0 26 0 170 0 27 0 170 0 28 2 77 0 29 2 81 0 30 0 170 0 33 2 85 0 58 2 89 0 82 2 93 0 83 2 97 0 84 2 89 0 85 2 105 0 92 0 170 0 128 2 109 0 129 0 89 0 133 0 170 0 136] 
#[1 0 174 0 26 0 174 0 27 0 174 0 28 0 174 0 29 0 174 0 30 2 61 0 31 0 174 0 33 2 113 0 76 2 69 0 77 2 73 0 78 0 174 0 128 0 174 0 129 0 174 0 133 0 174 0 136] 
#[1 0 11 0 7 0 178 0 26 0 178 0 27 0 178 0 28 0 178 0 29 0 178 0 30 0 178 0 31 0 178 0 33 2 121 0 58 2 125 0 95 2 125 0 96 0 178 0 127 0 178 0 128 0 178 0 129 2 133 0 131 2 137 0 132 0 15 0 133 0 178 0 136] 
#[1 0 182 0 7 0 182 0 26 0 182 0 27 0 182 0 28 0 182 0 29 0 182 0 30 2 61 0 31 0 182 0 33 2 141 0 76 2 69 0 77 2 73 0 78 0 182 0 128 0 182 0 129 0 182 0 131 0 182 0 132 0 182 0 133 0 182 0 136] 
#[1 0 186 0 7 0 186 0 26 0 186 0 27 0 186 0 28 0 186 0 29 0 186 0 30 2 145 0 32 0 186 0 33 0 186 0 128 0 186 0 129 0 186 0 131 0 186 0 132 0 186 0 133 0 186 0 136] 
#[0 0 190 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 0 194 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 0 198 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 0 202 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 0 206 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 0 210 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 0 214 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 0 218 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 222 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 226 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 230 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 234 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 238 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 242 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 0 246 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 2 149 0 24] 
#[0 0 250 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 5 0 102 0 6 0 102 0 7 0 102 0 8 0 102 0 10 0 102 0 11 0 102 0 12 0 102 0 13 0 102 0 14 0 102 0 15 0 102 0 17 0 102 0 20 0 102 0 21 1 245 0 22 0 102 0 23 0 102 0 24 0 102 0 25 0 102 0 28 0 102 0 33 1 249 0 108 2 153 0 109 2 157 0 110 0 102 0 131 0 102 0 132 0 102 0 133 0 102 0 137] 
#[0 0 254 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 1 153 0 7 2 33 0 45 1 181 0 52 1 189 0 102 1 193 0 127] 
#[0 0 0 0 136] 
#[0 0 0 0 136] 
#[0 0 0 0 136] 
#[0 0 166 0 136] 
#[0 0 174 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 133 0 136] 
#[0 0 182 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 0 186 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 0 0 0 136] 
#[0 0 0 0 136] 
#[0 2 29 0 18] 
#[1 1 2 0 1 1 2 0 2 1 2 0 3 1 2 0 4 1 2 0 5 1 2 0 6 1 2 0 7 1 2 0 8 1 2 0 10 1 2 0 11 1 2 0 12 1 2 0 13 1 2 0 14 1 2 0 15 1 2 0 17 1 2 0 18 1 2 0 20 1 2 0 21 1 2 0 23 1 2 0 24 1 2 0 25 0 19 0 29 1 2 0 33 1 2 0 129 1 2 0 131 1 2 0 132 1 2 0 133 1 2 0 136 1 2 0 137] 
#[0 1 10 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 1 14 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 1 18 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 1 22 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 1 81 0 58 2 161 0 97 2 161 0 98 2 161 0 99 2 161 0 100 1 69 0 131 0 89 0 133 2 165 0 137] 
#[0 1 26 0 29] 
#[0 1 30 0 126] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 1 81 0 58 2 169 0 97 2 169 0 98 2 169 0 99 2 169 0 100 1 69 0 131 0 89 0 133] 
#[0 1 34 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 127 0 131 0 132 0 133 0 136 0 137] 
#[1 1 38 0 1 1 38 0 2 1 38 0 3 1 38 0 4 1 38 0 5 1 38 0 6 0 23 0 7 1 38 0 8 1 38 0 10 1 38 0 11 1 38 0 12 1 38 0 13 1 38 0 14 1 38 0 15 1 38 0 17 1 38 0 18 1 38 0 20 1 38 0 21 1 38 0 23 1 38 0 24 1 38 0 25 1 38 0 33 2 173 0 43 2 177 0 45 1 173 0 49 1 177 0 50 1 181 0 52 1 189 0 102 1 193 0 127 1 38 0 131 1 38 0 132 1 38 0 133 1 38 0 136 1 38 0 137] 
#[1 1 42 0 1 1 42 0 2 1 42 0 3 1 42 0 4 1 42 0 5 1 42 0 6 1 42 0 7 1 42 0 8 1 42 0 10 1 42 0 11 1 42 0 12 1 42 0 13 1 42 0 14 1 42 0 15 1 42 0 17 1 42 0 18 1 42 0 20 1 42 0 21 2 181 0 22 1 42 0 23 1 42 0 24 1 42 0 25 1 42 0 33 1 42 0 131 1 42 0 132 1 42 0 133 2 185 0 134 1 42 0 136 1 42 0 137] 
#[1 1 46 0 1 1 46 0 2 1 46 0 3 1 46 0 4 1 46 0 5 1 46 0 6 1 46 0 7 1 46 0 8 1 46 0 10 1 46 0 11 1 46 0 12 1 46 0 13 1 46 0 14 1 46 0 15 1 46 0 17 1 46 0 18 1 46 0 20 1 46 0 21 1 46 0 23 1 46 0 24 1 46 0 25 1 157 0 29 1 46 0 33 2 189 0 63 0 73 0 64 0 77 0 65 1 46 0 127 0 81 0 129 1 46 0 131 1 46 0 132 1 46 0 133 1 46 0 136 1 46 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 1 81 0 58 2 193 0 97 2 193 0 98 2 193 0 99 2 193 0 100 1 69 0 131 0 89 0 133] 
#[1 2 197 0 46 2 201 0 47 2 205 0 101 2 209 0 126] 
#[1 1 153 0 7 1 161 0 43 2 213 0 44 2 177 0 45 1 173 0 49 1 177 0 50 1 181 0 52 1 189 0 102 1 193 0 127] 
#[1 1 50 0 1 1 50 0 2 1 50 0 3 1 50 0 4 1 50 0 5 1 50 0 6 1 50 0 7 1 50 0 8 1 50 0 10 1 50 0 11 1 50 0 12 1 50 0 13 1 50 0 14 1 50 0 15 1 50 0 17 1 50 0 18 1 50 0 19 1 50 0 20 1 50 0 21 1 50 0 22 1 50 0 23 1 50 0 24 1 50 0 25 1 50 0 26 1 50 0 27 1 50 0 28 1 50 0 29 1 50 0 30 1 50 0 31 1 50 0 32 1 50 0 33 2 217 0 48 2 221 0 51 1 50 0 126 1 50 0 127 1 50 0 128 1 50 0 129 1 50 0 131 1 50 0 132 1 50 0 133 1 50 0 134 2 225 0 135 1 50 0 136 1 50 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 2 229 0 74 2 229 0 75 2 229 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[0 1 54 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 29 0 33 0 127 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 1 58 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 29 0 33 0 127 0 129 0 131 0 132 0 133 0 136 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 2 233 0 10 1 81 0 58 2 237 0 97 2 237 0 98 2 237 0 99 2 237 0 100 1 69 0 131 0 89 0 133] 
#[0 1 62 0 27 0 28 0 33 0 136] 
#[0 2 241 0 19] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 6 0 24 0 169 0 25 1 81 0 58 2 245 0 59 2 245 0 97 2 245 0 98 2 245 0 99 2 245 0 100 2 245 0 111 2 245 0 112 2 245 0 113 2 245 0 114 2 245 0 117 2 245 0 120 2 245 0 121 2 245 0 122 2 245 0 123 1 65 0 124 1 69 0 131 0 89 0 133] 
#[0 1 66 0 7 0 19 0 29 0 127] 
#[1 3 1 0 19 1 217 0 29 3 5 0 56] 
#[1 1 70 0 1 1 70 0 2 1 70 0 3 1 70 0 4 1 70 0 5 1 70 0 6 1 70 0 7 1 70 0 8 1 70 0 10 1 70 0 11 1 70 0 12 1 70 0 13 1 70 0 14 1 70 0 15 1 70 0 17 1 70 0 18 3 9 0 19 1 70 0 20 1 70 0 21 1 70 0 23 1 70 0 24 1 70 0 25 1 70 0 33 1 70 0 131 1 70 0 132 1 70 0 133 1 70 0 136 1 70 0 137] 
#[0 1 74 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 3 13 0 28 2 37 0 33] 
#[1 1 78 0 28 1 78 0 33 3 17 0 106] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 117 0 7 0 121 0 8 1 81 0 58 3 21 0 97 3 21 0 98 3 21 0 99 3 21 0 100 1 69 0 131 0 89 0 133] 
#[0 1 82 0 10 0 22 0 27] 
#[1 3 25 0 10 1 245 0 22 3 29 0 27 3 33 0 108] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 10 0 27 0 173 0 33 1 81 0 58 0 201 0 67 3 37 0 68 3 41 0 69 0 213 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[0 3 45 0 26] 
#[1 0 141 0 14 0 145 0 15 3 49 0 27 3 57 0 113 3 57 0 119 3 61 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 2 37 0 33 1 81 0 58 3 65 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 86 0 136 1 77 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 153 0 18 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 173 0 33 3 69 0 53 0 181 0 54 0 185 0 55 0 189 0 58 0 185 0 60 3 73 0 67 3 77 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 90 0 136 1 77 0 137] 
#[0 1 94 0 136] 
#[0 1 98 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[1 1 153 0 7 1 217 0 29 3 81 0 45 3 85 0 50 1 181 0 52 1 221 0 56 3 89 0 57 3 93 0 61 3 97 0 62 1 189 0 102 1 193 0 127] 
#[0 1 102 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 1 106 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 11 0 12 0 13 0 14 0 15 0 17 0 20 0 21 0 23 0 24 0 25 0 27 0 28 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 1 110 0 27 0 28 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 173 0 33 1 81 0 58 3 101 0 67 3 105 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 114 0 136 1 77 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 118 0 27 1 118 0 28 2 37 0 33 1 81 0 58 3 109 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 118 0 136 1 77 0 137] 
#[0 1 122 0 27 0 28 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 126 0 27 1 126 0 28 2 37 0 33 1 81 0 58 3 113 0 73 3 113 0 74 3 113 0 75 3 113 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 126 0 136 1 77 0 137] 
#[1 2 117 0 7 2 77 0 29 2 81 0 30 3 117 0 58 3 121 0 79 3 121 0 82 2 93 0 83 2 97 0 84 3 121 0 85 3 121 0 92 3 121 0 95 3 121 0 96 2 109 0 129 2 133 0 131 0 89 0 133] 
#[0 1 130 0 26 0 27 0 28 0 33 0 128 0 136] 
#[0 1 134 0 26 0 27 0 28 0 31 0 33 0 128 0 136] 
#[1 1 138 0 26 1 138 0 27 1 138 0 28 2 61 0 31 1 138 0 33 3 137 0 77 1 138 0 128 1 138 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 3 141 0 90 1 101 0 91 0 249 0 93 1 105 0 94 0 249 0 97 0 249 0 98 0 249 0 99 0 249 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 3 145 0 93 1 105 0 94 3 145 0 97 3 145 0 98 3 145 0 99 3 145 0 100 3 145 0 103 3 145 0 104 3 145 0 107 3 145 0 111 3 145 0 112 3 145 0 113 3 145 0 114 3 145 0 117 3 145 0 120 3 145 0 121 3 145 0 122 3 145 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 1 153 0 7 3 149 0 29 2 177 0 45 3 153 0 50 1 181 0 52 3 157 0 86 3 161 0 87 3 165 0 88 3 169 0 89 1 189 0 102 1 193 0 127] 
#[0 1 142 0 26 0 27 0 28 0 31 0 33 0 128 0 136] 
#[0 1 146 0 26 0 27 0 28 0 29 0 31 0 33 0 128 0 129 0 136] 
#[1 1 150 0 26 1 150 0 27 1 150 0 28 2 77 0 29 1 150 0 31 1 150 0 33 3 173 0 83 1 150 0 128 2 109 0 129 1 150 0 136] 
#[0 1 154 0 26 0 27 0 28 0 31 0 33 0 128 0 136] 
#[0 1 158 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 133 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 3 177 0 90 1 101 0 91 0 249 0 93 1 105 0 94 0 249 0 97 0 249 0 98 0 249 0 99 0 249 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[0 1 162 0 26 0 27 0 28 0 33 0 128 0 136] 
#[0 1 166 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 1 153 0 7 3 181 0 45 1 181 0 52 1 189 0 102 1 193 0 127] 
#[0 1 170 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 1 174 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 1 178 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 5 0 102 0 6 0 102 0 7 0 102 0 8 0 102 0 10 0 102 0 11 0 102 0 12 0 102 0 13 0 102 0 14 0 102 0 15 0 102 0 17 0 102 0 20 0 102 0 21 1 245 0 22 0 102 0 23 0 102 0 24 0 102 0 25 0 102 0 28 0 102 0 33 1 249 0 108 2 153 0 109 3 185 0 110 0 102 0 131 0 102 0 132 0 102 0 133 0 102 0 137] 
#[0 1 182 0 26 0 27 0 28 0 33 0 128 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 3 189 0 74 3 189 0 75 3 189 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 1 186 0 4 1 186 0 5 1 186 0 6 1 186 0 7 1 186 0 11 1 186 0 12 1 186 0 13 1 186 0 14 1 186 0 15 1 186 0 16 1 186 0 17 1 186 0 20 1 186 0 21 1 186 0 22 1 186 0 23 1 186 0 24 1 186 0 25 1 186 0 26 1 186 0 27 1 186 0 28 1 186 0 30 1 186 0 31 1 186 0 33 3 193 0 115 1 186 0 130 1 186 0 131 1 186 0 137] 
#[1 3 25 0 10 1 245 0 22 3 33 0 108] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 10 0 28 0 173 0 33 1 81 0 58 0 201 0 67 3 197 0 68 3 41 0 69 0 213 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[0 1 6 0 29] 
#[0 1 190 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 1 2 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 29 0 33 0 127 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 1 194 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 127 0 131 0 132 0 133 0 136 0 137] 
#[1 2 181 0 22 2 185 0 134] 
#[0 1 198 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 11 0 12 0 13 0 14 0 15 0 20 0 21 0 23 0 24 0 25 0 131 0 132 0 133 0 137] 
#[0 1 202 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 11 0 12 0 13 0 14 0 15 0 20 0 21 0 23 0 24 0 25 0 131 0 132 0 133 0 137] 
#[0 1 206 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 127 0 131 0 132 0 133 0 136 0 137] 
#[0 1 210 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 29 0 33 0 127 0 129 0 131 0 132 0 133 0 136 0 137] 
#[0 1 214 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 126 0 127 0 128 0 129 0 131 0 132 0 133 0 134 0 136 0 137] 
#[1 1 218 0 1 1 218 0 2 1 218 0 3 1 218 0 4 1 218 0 5 1 218 0 6 1 218 0 7 1 218 0 8 1 218 0 10 1 218 0 11 1 218 0 12 1 218 0 13 1 218 0 14 1 218 0 15 1 218 0 17 1 218 0 18 1 218 0 19 1 218 0 20 1 218 0 21 1 218 0 22 1 218 0 23 1 218 0 24 1 218 0 25 1 218 0 26 1 218 0 27 1 218 0 28 1 218 0 29 1 218 0 30 1 218 0 31 1 218 0 32 1 218 0 33 3 201 0 46 2 205 0 101 2 209 0 126 1 218 0 127 1 218 0 128 1 218 0 129 1 218 0 131 1 218 0 132 1 218 0 133 1 218 0 134 1 218 0 136 1 218 0 137] 
#[1 1 222 0 1 1 222 0 2 1 222 0 3 1 222 0 4 1 222 0 5 1 222 0 6 1 222 0 7 1 222 0 8 1 222 0 10 1 222 0 11 1 222 0 12 1 222 0 13 1 222 0 14 1 222 0 15 1 222 0 17 1 222 0 18 1 222 0 19 1 222 0 20 1 222 0 21 1 222 0 22 1 222 0 23 1 222 0 24 1 222 0 25 1 222 0 26 1 222 0 27 1 222 0 28 1 222 0 29 1 222 0 30 1 222 0 31 1 222 0 32 1 222 0 33 3 205 0 51 1 222 0 126 1 222 0 127 1 222 0 128 1 222 0 129 1 222 0 131 1 222 0 132 1 222 0 133 1 222 0 134 2 225 0 135 1 222 0 136 1 222 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 3 209 0 74 3 209 0 75 3 209 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 1 226 0 1 1 226 0 2 1 226 0 3 1 226 0 4 1 226 0 5 1 226 0 6 0 27 0 7 1 226 0 8 1 226 0 10 1 226 0 11 1 226 0 12 1 226 0 13 1 226 0 14 1 226 0 15 1 226 0 17 1 226 0 18 1 226 0 20 1 226 0 21 1 226 0 23 1 226 0 24 1 226 0 25 1 226 0 33 2 173 0 43 2 177 0 45 1 173 0 49 1 177 0 50 1 181 0 52 1 189 0 102 1 193 0 127 1 226 0 131 1 226 0 132 1 226 0 133 1 226 0 136 1 226 0 137] 
#[1 1 230 0 1 1 230 0 2 1 230 0 3 1 230 0 4 1 230 0 5 1 230 0 6 1 230 0 7 1 230 0 8 1 230 0 10 1 230 0 11 1 230 0 12 1 230 0 13 1 230 0 14 1 230 0 15 1 230 0 17 1 230 0 18 1 230 0 19 1 230 0 20 1 230 0 21 1 230 0 22 1 230 0 23 1 230 0 24 1 230 0 25 1 230 0 26 1 230 0 27 1 230 0 28 1 230 0 29 1 230 0 30 1 230 0 31 1 230 0 32 1 230 0 33 3 213 0 46 2 205 0 101 2 209 0 126 1 230 0 127 1 230 0 128 1 230 0 129 1 230 0 131 1 230 0 132 1 230 0 133 1 230 0 134 1 230 0 136 1 230 0 137] 
#[1 1 50 0 1 1 50 0 2 1 50 0 3 1 50 0 4 1 50 0 5 1 50 0 6 1 50 0 7 1 50 0 8 1 50 0 10 1 50 0 11 1 50 0 12 1 50 0 13 1 50 0 14 1 50 0 15 1 50 0 17 1 50 0 18 1 50 0 19 1 50 0 20 1 50 0 21 1 50 0 22 1 50 0 23 1 50 0 24 1 50 0 25 1 50 0 26 1 50 0 27 1 50 0 28 1 50 0 29 1 50 0 30 1 50 0 31 1 50 0 32 1 50 0 33 3 217 0 48 1 50 0 126 1 50 0 127 1 50 0 128 1 50 0 129 1 50 0 131 1 50 0 132 1 50 0 133 1 50 0 134 1 50 0 136 1 50 0 137] 
#[0 1 234 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 126 0 127 0 128 0 129 0 131 0 132 0 133 0 134 0 136 0 137] 
#[0 3 221 0 128] 
#[0 1 238 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 27 0 28 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 1 242 0 1 0 2 0 3 0 7 0 8 0 10 0 131 0 133] 
#[0 1 246 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 1 250 0 7 0 19 0 29 0 127] 
#[0 1 254 0 7 0 19 0 29 0 127] 
#[0 2 2 0 7 0 19 0 29 0 127] 
#[0 2 6 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 2 10 0 7 0 19 0 29 0 127] 
#[0 2 14 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 2 18 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 3 225 0 28 0 173 0 33 3 229 0 67 3 233 0 105] 
#[0 2 22 0 10 0 22 0 27] 
#[0 2 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 20 0 21 0 23 0 24 0 25 0 27 0 28 0 33 0 131 0 132 0 133 0 137] 
#[0 2 30 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 2 34 0 10 0 22 0 27] 
#[0 3 237 0 27] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 138 0 27 0 138 0 28 0 173 0 33 1 81 0 58 2 49 0 67 2 53 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[0 2 38 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 2 42 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 2 46 0 14 0 15 0 27 0 137] 
#[0 2 50 0 14 0 15 0 27 0 137] 
#[0 2 54 0 14 0 15 0 27 0 137] 
#[0 2 58 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 173 0 33 1 81 0 58 3 241 0 67 3 245 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 2 62 0 136 1 77 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 2 37 0 33 1 81 0 58 3 249 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 2 66 0 136 1 77 0 137] 
#[0 2 70 0 136] 
#[1 3 253 0 19 2 181 0 22 2 185 0 134] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 6 0 24 0 169 0 25 1 81 0 58 4 1 0 59 4 1 0 97 4 1 0 98 4 1 0 99 4 1 0 100 4 1 0 111 4 1 0 112 4 1 0 113 4 1 0 114 4 1 0 117 4 1 0 120 4 1 0 121 4 1 0 122 4 1 0 123 1 65 0 124 1 69 0 131 0 89 0 133] 
#[1 1 153 0 7 1 217 0 29 2 177 0 45 3 85 0 50 1 181 0 52 3 5 0 56 3 93 0 61 4 5 0 62 1 189 0 102 1 193 0 127] 
#[0 2 74 0 7 0 19 0 127] 
#[1 1 153 0 7 4 9 0 19 2 177 0 45 3 85 0 50 1 181 0 52 4 13 0 61 1 189 0 102 1 193 0 127] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 2 37 0 33 1 81 0 58 4 17 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 2 78 0 136 1 77 0 137] 
#[0 2 82 0 136] 
#[0 2 86 0 27 0 28 0 136] 
#[0 2 90 0 27 0 28 0 33 0 136] 
#[1 1 153 0 7 3 149 0 29 4 21 0 45 3 153 0 50 1 181 0 52 3 157 0 86 3 161 0 87 3 165 0 88 3 169 0 89 1 189 0 102 1 193 0 127] 
#[0 2 94 0 26 0 27 0 28 0 31 0 33 0 128 0 136] 
#[0 2 98 0 26 0 27 0 28 0 31 0 33 0 128 0 136] 
#[0 2 102 0 26 0 27 0 28 0 31 0 33 0 128 0 136] 
#[0 2 106 0 26 0 27 0 28 0 31 0 33 0 128 0 136] 
#[0 2 110 0 26 0 27 0 28 0 31 0 33 0 128 0 136] 
#[1 2 114 0 26 2 114 0 27 2 114 0 28 2 114 0 29 2 81 0 30 2 114 0 31 2 114 0 33 2 105 0 92 2 114 0 128 2 114 0 129 2 114 0 136] 
#[1 0 31 0 7 2 118 0 26 2 118 0 27 2 118 0 28 2 118 0 29 2 118 0 30 2 118 0 31 2 118 0 33 2 121 0 58 2 125 0 95 2 125 0 96 2 118 0 127 2 118 0 128 2 118 0 129 2 133 0 131 2 137 0 132 0 35 0 133 2 118 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 4 25 0 90 1 101 0 91 0 249 0 93 1 105 0 94 0 249 0 97 0 249 0 98 0 249 0 99 0 249 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 1 81 0 58 4 29 0 90 1 101 0 91 0 249 0 93 1 105 0 94 0 249 0 97 0 249 0 98 0 249 0 99 0 249 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[0 2 122 0 7 0 26 0 27 0 28 0 31 0 33 0 127 0 128 0 136] 
#[1 1 153 0 7 2 126 0 26 2 126 0 27 2 126 0 28 2 126 0 31 2 126 0 33 2 177 0 45 3 153 0 50 1 181 0 52 4 33 0 86 1 189 0 102 1 193 0 127 2 126 0 128 2 126 0 136] 
#[0 2 130 0 7 0 26 0 27 0 28 0 29 0 31 0 33 0 127 0 128 0 136] 
#[1 1 153 0 7 3 149 0 29 2 177 0 45 3 153 0 50 1 181 0 52 3 157 0 86 4 37 0 87 4 41 0 88 1 189 0 102 1 193 0 127] 
#[0 2 134 0 26 0 27 0 28 0 29 0 31 0 33 0 128 0 129 0 136] 
#[1 2 138 0 26 2 138 0 27 2 138 0 28 2 138 0 29 2 81 0 30 2 138 0 31 2 138 0 33 2 105 0 92 2 138 0 128 2 138 0 129 2 138 0 136] 
#[0 2 142 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 125 0 10 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 0 10 0 28 0 173 0 33 1 81 0 58 0 201 0 67 4 45 0 68 3 41 0 69 0 213 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[0 2 146 0 26 0 27 0 28 0 33 0 128 0 136] 
#[1 0 105 0 4 0 109 0 5 0 113 0 6 4 49 0 7 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 4 53 0 16 4 57 0 17 4 61 0 20 4 65 0 21 4 69 0 22 4 73 0 23 0 6 0 24 0 169 0 25 2 150 0 26 4 77 0 27 4 81 0 28 4 85 0 30 4 89 0 31 4 93 0 33 4 101 0 111 4 101 0 112 4 101 0 113 4 101 0 114 4 101 0 116 4 101 0 117 4 101 0 120 4 101 0 121 4 101 0 122 4 101 0 123 1 65 0 124 4 105 0 125 4 109 0 130 4 113 0 131 4 117 0 137] 
#[0 4 121 0 28] 
#[0 2 154 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 126 0 127 0 128 0 129 0 131 0 132 0 133 0 134 0 136 0 137] 
#[0 2 158 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 126 0 127 0 128 0 129 0 131 0 132 0 133 0 134 0 136 0 137] 
#[0 4 125 0 128] 
#[0 2 162 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 126 0 127 0 128 0 129 0 131 0 132 0 133 0 134 0 136 0 137] 
#[1 2 166 0 1 2 166 0 2 2 166 0 3 2 166 0 4 2 166 0 5 2 166 0 6 2 166 0 7 2 166 0 8 2 166 0 10 2 166 0 11 2 166 0 12 2 166 0 13 2 166 0 14 2 166 0 15 2 166 0 17 2 166 0 18 2 166 0 19 2 166 0 20 2 166 0 21 2 166 0 22 2 166 0 23 2 166 0 24 2 166 0 25 2 166 0 26 2 166 0 27 2 166 0 28 2 166 0 29 2 166 0 30 2 166 0 31 2 166 0 32 2 166 0 33 3 213 0 46 2 205 0 101 2 209 0 126 2 166 0 127 2 166 0 128 2 166 0 129 2 166 0 131 2 166 0 132 2 166 0 133 2 166 0 134 2 166 0 136 2 166 0 137] 
#[0 2 170 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 126 0 127 0 128 0 129 0 131 0 132 0 133 0 134 0 135 0 136 0 137] 
#[0 2 174 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 4 129 0 28 2 37 0 33 1 81 0 58 4 133 0 74 4 133 0 75 4 133 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 1 77 0 137] 
#[0 2 178 0 28 0 33] 
#[0 2 182 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 0 93 0 1 0 97 0 2 0 101 0 3 0 105 0 4 0 109 0 5 0 113 0 6 0 117 0 7 0 121 0 8 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 0 149 0 17 0 157 0 20 0 161 0 21 0 165 0 23 0 6 0 24 0 169 0 25 2 37 0 33 1 81 0 58 4 137 0 71 0 217 0 72 0 221 0 73 0 221 0 74 0 221 0 75 0 221 0 80 0 237 0 81 0 241 0 90 0 245 0 91 0 249 0 93 0 253 0 94 1 1 0 97 1 1 0 98 1 1 0 99 1 1 0 100 0 249 0 103 0 249 0 104 0 249 0 107 0 249 0 111 0 249 0 112 0 249 0 113 0 249 0 114 0 249 0 117 0 249 0 120 0 249 0 121 0 249 0 122 0 249 0 123 1 65 0 124 1 69 0 131 1 73 0 132 0 89 0 133 2 186 0 136 1 77 0 137] 
#[0 2 190 0 136] 
#[0 2 194 0 136] 
#[0 2 198 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[1 2 202 0 7 2 202 0 19 1 217 0 29 1 221 0 56 4 141 0 57 2 202 0 127] 
#[1 1 153 0 7 4 145 0 19 2 177 0 45 3 85 0 50 1 181 0 52 4 13 0 61 1 189 0 102 1 193 0 127] 
#[0 2 206 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[0 2 210 0 7 0 19 0 127] 
#[0 2 214 0 136] 
#[1 2 181 0 22 2 142 0 26 2 142 0 27 2 142 0 28 2 142 0 31 2 142 0 33 2 142 0 128 2 185 0 134 2 142 0 136] 
#[1 2 218 0 7 2 218 0 26 2 218 0 27 2 218 0 28 2 218 0 29 2 81 0 30 2 218 0 31 2 218 0 33 2 105 0 92 2 218 0 127 2 218 0 128 2 218 0 136] 
#[1 2 222 0 7 2 222 0 26 2 222 0 27 2 222 0 28 3 149 0 29 2 81 0 30 2 222 0 31 2 222 0 33 3 165 0 88 4 149 0 89 2 105 0 92 2 222 0 127 2 222 0 128 2 222 0 136] 
#[0 2 226 0 7 0 26 0 27 0 28 0 31 0 33 0 127 0 128 0 136] 
#[1 1 153 0 7 2 230 0 26 2 230 0 27 2 230 0 28 2 230 0 31 2 230 0 33 2 177 0 45 3 153 0 50 1 181 0 52 4 33 0 86 1 189 0 102 1 193 0 127 2 230 0 128 2 230 0 136] 
#[0 2 234 0 7 0 26 0 27 0 28 0 29 0 31 0 33 0 127 0 128 0 136] 
#[0 4 153 0 28] 
#[0 2 238 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 2 242 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 2 246 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 2 250 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 2 254 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 2 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[1 1 186 0 4 1 186 0 5 1 186 0 6 1 186 0 7 1 186 0 11 1 186 0 12 1 186 0 13 1 186 0 14 1 186 0 15 1 186 0 16 1 186 0 17 1 186 0 20 1 186 0 21 1 186 0 22 1 186 0 23 1 186 0 24 1 186 0 25 1 186 0 26 1 186 0 27 1 186 0 28 1 186 0 30 1 186 0 31 1 186 0 33 4 157 0 115 1 186 0 130 1 186 0 131 1 186 0 137] 
#[0 3 6 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 10 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 14 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 18 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 22 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 26 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 30 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 4 161 0 26] 
#[0 3 34 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 38 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 42 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137] 
#[0 3 46 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 3 50 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 126 0 127 0 128 0 129 0 131 0 132 0 133 0 134 0 135 0 136 0 137] 
#[0 3 54 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[0 3 58 0 28 0 33] 
#[0 3 62 0 136] 
#[1 3 66 0 7 3 66 0 19 1 217 0 29 3 5 0 56 3 66 0 127] 
#[0 3 70 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 17 0 18 0 20 0 21 0 23 0 24 0 25 0 33 0 131 0 132 0 133 0 136 0 137] 
#[1 3 74 0 7 3 74 0 26 3 74 0 27 3 74 0 28 3 149 0 29 3 74 0 31 3 74 0 33 4 41 0 88 3 74 0 127 3 74 0 128 3 74 0 136] 
#[0 3 78 0 7 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 131 0 132 0 133 0 136] 
#[1 0 105 0 4 0 109 0 5 0 113 0 6 4 49 0 7 0 129 0 11 0 133 0 12 0 137 0 13 0 141 0 14 0 145 0 15 4 53 0 16 4 57 0 17 4 61 0 20 4 65 0 21 4 69 0 22 4 73 0 23 0 6 0 24 0 169 0 25 4 165 0 26 4 77 0 27 4 81 0 28 4 85 0 30 4 89 0 31 4 93 0 33 4 101 0 111 4 101 0 112 4 101 0 113 4 101 0 114 4 101 0 116 4 101 0 117 4 101 0 120 4 101 0 121 4 101 0 122 4 101 0 123 1 65 0 124 4 109 0 130 4 113 0 131 4 117 0 137] 
#[0 3 82 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 127 0 128 0 129 0 130 0 131 0 132 0 133 0 136 0 137] 
#[0 3 86 0 4 0 5 0 6 0 7 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 30 0 31 0 33 0 130 0 131 0 137]
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
GtPharoParser >> defaultScope [
	^ #default
]

{ #category : #private }
GtPharoParser >> endLiteralArray [
	(nodeStack
		inject: 0
		into: [ :sum :each | sum + (each == #array ifTrue: [ 1 ] ifFalse: [ 0 ]) ])
		= 1 ifTrue: [ self scope: self defaultScope ]
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
GtPharoParser >> reduceActionForGemStonePath1: nodes [
	| result |
	result := GtPharoGSPathNode new.
	result name: (nodes at: 1).
	^ result
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

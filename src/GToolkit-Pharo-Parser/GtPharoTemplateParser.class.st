Class {
	#name : #GtPharoTemplateParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoTemplateParser class >> ambiguousTransitions [
^#(
#[ 0 10 1 93] 
#[ 0 21 0 30] 
#[ 0 30 0 33] 
#[ 0 21 0 42] 
#[ 0 33 0 42] 
#[ 0 78 1 181] 
#[ 0 102 1 233] 
#[ 0 10 1 253] 
#[ 0 122 2 13] 
#[ 0 146 2 41] 
#[ 0 154 2 53] 
#[ 0 162 2 65] 
#[ 0 10 2 73] 
#[ 0 10 1 61] 
#[ 0 10 2 85] 
#[ 0 10 2 97] 
#[ 1 14 1 18] 
#[ 0 10 2 201] 
#[ 1 42 2 237] 
#[ 0 10 2 249] 
#[ 1 58 1 121] 
#[ 0 21 1 66] 
#[ 0 102 1 70] 
#[ 0 102 1 70 3 9] 
#[ 0 102 3 29] 
#[ 0 102 3 45] 
#[ 1 74 3 53] 
#[ 0 10 3 65] 
#[ 0 10 3 81] 
#[ 0 10 3 93] 
#[ 1 86 3 105] 
#[ 1 61 1 86] 
#[ 0 10 1 201] 
#[ 0 110 1 46] 
#[ 0 10 3 213] 
#[ 1 146 1 150] 
#[ 1 178 1 182] 
#[ 0 10 4 33] 
#[ 0 10 4 57] 
#[ 0 102 1 70 3 45] 
#[ 0 102 4 89] 
#[ 0 102 4 121] 
#[ 0 10 4 153] 
#[ 0 10 4 165] 
#[ 0 10 4 173] 
#[ 0 10 4 185] 
#[ 1 254 4 197] 
#[ 1 61 1 254] 
#[ 2 30 2 53] 
#[ 1 46 1 214] 
#[ 1 118 1 218] 
#[ 0 102 5 173] 
#[ 0 102 5 197] 
#[ 0 10 5 237] 
#[ 0 10 5 249] 
#[ 0 10 6 9] 
#[ 2 158 6 29] 
#[ 2 53 2 162] 
#[ 2 54 2 98] 
#[ 0 102 6 129] 
#[ 0 10 6 205] 
#[ 3 74 6 225] 
#[ 3 186 6 225] 
#[ 4 26 6 29] 
#[ 4 34 6 29]
	).
]

{ #category : #'generated-accessing' }
GtPharoTemplateParser class >> cacheId [
	^'2021-04-21T09:50:00.977539+02:00'
]

{ #category : #generated }
GtPharoTemplateParser class >> definitionComment [
"%glr;
%prefix GtPharo;
%suffix Node;
%root Program;
%start Method MethodSequence Statement MethodPattern;
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
literalArray <keyword>
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
	: (\s | \x0)* \"" [^\""]* \"" (\s | \x0)*
	;
literalArray <whitespace>
	: (\s | \x0)+
	;
default <space>
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
<symbolHash>
	: \#{1,2}
	;
default <doubleLeftBrace>
	: \{\{
	;
default <doubleRightBrace>
	: \}\}
	;
Method
	: <space>?MethodPattern 'pattern' <space>? MethodSequence 'body' <space>?{{}}
	;
MethodPattern
	: Name 'selectorPart' {{}}
	| <binary> 'selectorPart' <space>? Variable 'variable' {{}}
	| KeywordPattern {{}}
	| <binary> 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| Keyword 'selectorPart' error 'smaccError' {{ErrorPattern}}
	| (Keyword 'selectorPart' <space>?Variable 'variable')+ Keyword 'selectorPart' error 'smaccError' {{ErrorPattern}}
	;
Pragmas
	: Pragma 'pragma' (<space>? Pragma 'pragma')*
	;
Pragma
	:  <lt> 'lessThan' Name 'selectorPart' <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' Keyword 'selectorPart' <space>?(Literal 'value' | Variable 'value') (<space> Keyword 'selectorPart' <space>?(Literal 'value' | Variable 'value'))* <gt> 'greaterThan' {{}}
	| <lt> 'lessThan' error 'smaccError' {{PragmaError}}
	| <lt> 'lessThan' error 'smaccError' <gt> 'greaterThan' {{PragmaError}}
	;
KeywordPattern
	: (Keyword 'selectorPart' <space>? Variable 'variable')+
	;
MethodSequence
	: Pragmas <space>? Temporaries <space>?Pragmas <space>?Period 'period'? <space>?Statements? {{}}
	| Temporaries <space>? Pragmas <space>?Period 'period'? <space>?Statements? {{}}
	| Pragmas <space>?Temporaries? <space>?Period 'period'? <space>?Statements? {{}}
	| Sequence
	;
Sequence
	: Temporaries? <space>? Period 'period'? <space>? Statements? {{}}
	;
Temporaries
	:  <bar> 'leftBar' <space>? <bar> 'rightBar'
	| <bar> 'leftBar' <space>? Variable 'variable' (<space>? Variable 'variable')* <space>?<bar> 'rightBar'
	;
Statements
	: StatementList <space>? Period 'period'?
	;
StatementList
	: Statement 'statement'
	| StatementList <space>?Period 'period' <space>? Statement 'statement'
	;
Statement
	: <return> 'upArrow' <space>? Assignment 'value' {{Return}}
	| Assignment
	;
Assignment
	: Variable 'variable' <space>? <assign> 'assignmentToken' <space>? Assignment 'value' {{}}
	| Cascade
	;
Cascade
	: KeywordMessageSendVars CascadedMessages {{}}
	| BinaryMessageSendVars CascadedMessages {{}}
	| UnaryMessageSendVars CascadedMessages {{}}
	| KeywordMessageSend
	;
CascadedMessages
	: (<semicolon> 'semicolon' <space>? CascadedMessage 'message')+
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
	: BinaryMessageSend 'receiver' <space>KeywordMessage 'message' 
	;
KeywordMessage
	: Keyword 'selectorPart' <space>? BinaryMessageSend 'value' (<space>Keyword 'selectorPart' <space>? BinaryMessageSend 'value')* {{}}
	;
BinaryMessageSend
	: BinaryMessageSendVars {{MessageSend}}
	| UnaryMessageSend
	;
BinaryMessageSendVars
	: BinaryMessageSend 'receiver' <space>? BinaryMessage 'message' 
	;
BinaryMessage
	: <binary> 'selectorPart' <space>? UnaryMessageSend 'value' {{}}
	;
UnaryMessageSend
	: UnaryMessageSendVars {{MessageSend}}
	| Value
	;
UnaryMessageSendVars
	: UnaryMessageSend 'receiver' <space> UnaryMessage 'message' 
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
	: <leftBrace> 'leftBrace' <space>(Assignment 'value' (<period> 'period' Assignment 'value')*)? <period> 'period'? <space><rightBrace> 'rightBrace' {{}}
	;
Block
	: <leftBracket> 'leftBracket' <space>? BlockArgs <space>? Sequence 'body' <space>? <rightBracket> 'rightBracket' {{}}
	| <leftBracket> 'leftBracket' <space>? <colon> 'colon' Variable 'variable' (<space><colon> 'colon' Variable 'variable')* <space>? <rightBracket> 'rightBracket' {{}}
	| <leftBracket> 'leftBracket' <space>? BlockArgs <space>? Sequence 'body' error 'smaccError' {{BlockError}}
	;
BlockArgs
	: 
	| <colon> 'colon' Variable 'variable' (<space> <colon> 'colon' Variable 'variable')* <space>? <bar> 'bar'
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
	: (<name> 'namePart'| Template 'namePart')+ {{}}
	;
Keyword
	: Name 'selectorPart'<colon> 'selectorPart' {{}}
	;
Symbol
	: <symbolHash> 'hash'( Name 'symbolPart'(<colon>'symbolPart'<colon> 'symbolPart'Name'symbolPart')* | <binary> 'symbolPart'| Keyword'symbolPart'+ | <string> 'symbolPart') {{}}
	;
Period
	: <period> 'period' (<space>? <period> 'period')*
	;
Template
	: <doubleLeftBrace> 'leftBraces' Assignment 'expression' <doubleRightBrace>'rightBraces' {{}}
	;"
]

{ #category : #generated }
GtPharoTemplateParser class >> reduceTable [
^#(
	#(104 0 #reduceActionForSwitchToLiteralArray1: 7881729 false ) 
	#(55 0 #reduceActionForStatements_1: 3767297 false ) 
	#(111 1 #liftFirstValue: 8176641 false ) 
	#(43 1 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___1: 3012609 false ) 
	#(41 1 #reduceActionForMethodPattern4: 2752516 false ) 
	#(52 1 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___1: 3609601 false ) 
	#(50 1 #reduceActionForKeywordPattern1: 3591169 false ) 
	#(41 1 #reduceActionForMethodPattern1: 2752513 false ) 
	#(112 1 #reduceActionFor__name___namePart___Template__namePart___1: 8176641 false ) 
	#(110 1 #reduceActionForName1: 8168449 false ) 
	#(111 1 #liftFirstValue: 8176642 false ) 
	#(102 1 #reduceActionForBooleanLiteral1: 7778305 false ) 
	#(102 1 #reduceActionForBooleanLiteral1: 7778306 false ) 
	#(103 1 #reduceActionForNilLiteral1: 7844865 false ) 
	#(92 1 #reduceActionForStringLiteral1: 6850561 false ) 
	#(100 1 #reduceActionForCharacterLiteral1: 7688193 false ) 
	#(93 1 #reduceActionForNumberLiteral1: 6893569 false ) 
	#(93 1 #reduceActionForNumberLiteral1: 6893570 false ) 
	#(88 0 #reduceActionForBlockArgs1: 6569985 false ) 
	#(98 0 #reduceActionForByteArrayLiteralValue__value__1: 7544833 false ) 
	#(120 0 #nil 8509441 false ) 
	#(106 1 #reduceActionForSelfVariable1: 7997441 false ) 
	#(107 1 #reduceActionForSuperVariable1: 8036353 false ) 
	#(109 1 #reduceActionForThisContextVariable1: 8115201 false ) 
	#(54 0 #nil 3759105 false ) 
	#(46 0 #reduceActionForByteArrayLiteralValue__value__1: 3159041 false ) 
	#(56 1 #reduceActionForSequence1: 3968001 false ) 
	#(53 1 #liftFirstValue: 3669041 false ) 
	#(55 1 #reduceActionForKeywordPattern1: 3767298 false ) 
	#(60 1 #reduceActionForKeywordPattern1: 4219905 false ) 
	#(61 1 #reduceActionForStatementList1: 4278273 false ) 
	#(62 1 #liftFirstValue: 4395011 false ) 
	#(63 1 #liftFirstValue: 4485125 false ) 
	#(64 1 #liftFirstValue: 4604932 false ) 
	#(69 1 #reduceActionForKeywordMessageSend1: 4941825 false ) 
	#(69 1 #liftFirstValue: 4941826 false ) 
	#(74 1 #reduceActionForKeywordMessageSend1: 5277697 false ) 
	#(74 1 #liftFirstValue: 5277698 false ) 
	#(77 1 #reduceActionForKeywordMessageSend1: 5539841 false ) 
	#(81 1 #liftFirstValue: 5831681 false ) 
	#(77 1 #liftFirstValue: 5539842 false ) 
	#(81 1 #liftFirstValue: 5831683 false ) 
	#(81 1 #liftFirstValue: 5831684 false ) 
	#(81 1 #liftFirstValue: 5831682 false ) 
	#(91 1 #liftFirstValue: 6696961 false ) 
	#(91 1 #liftFirstValue: 6696962 false ) 
	#(91 1 #liftFirstValue: 6696963 false ) 
	#(91 1 #liftFirstValue: 6696964 false ) 
	#(91 1 #liftFirstValue: 6696965 false ) 
	#(91 1 #liftFirstValue: 6696966 false ) 
	#(91 1 #liftFirstValue: 6696967 false ) 
	#(91 1 #liftFirstValue: 6696968 false ) 
	#(80 1 #liftFirstValue: 5744641 false ) 
	#(80 1 #liftFirstValue: 5744642 false ) 
	#(80 1 #liftFirstValue: 5744644 false ) 
	#(80 1 #liftFirstValue: 5744643 false ) 
	#(108 1 #reduceActionForNamedVariable1: 8077313 false ) 
	#(101 1 #reduceActionForSymbolLiteral1: 7737345 false ) 
	#(81 1 #reduceActionForValue6: 5831686 false ) 
	#(41 2 #reduceActionForMethodPattern2: 2752514 false ) 
	#(41 2 #reduceActionForMethodPattern5: 2752517 false ) 
	#(40 2 #reduceActionForMethod1: 2661377 false ) 
	#(43 2 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: 3012610 false ) 
	#(52 2 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: 3609602 false ) 
	#(113 2 #reduceActionForKeyword1: 8227841 false ) 
	#(112 2 #reduceActionFor__name___namePart___Template__namePart___2: 8176642 false ) 
	#(51 2 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__1: 3609601 false ) 
	#(42 2 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__1: 3012609 false ) 
	#(41 2 #reduceActionForMethodPattern5: 2752518 false ) 
	#(57 2 #reduceActionForTemporaries1: 4049921 false ) 
	#(59 0 #reduceActionForByteArrayLiteralValue__value__1: 4158465 false ) 
	#(62 2 #reduceActionForStatement1: 4395009 false ) 
	#(47 2 #reduceActionForPragma6: 3190790 false ) 
	#(118 2 #liftSecondValue: 8480769 false ) 
	#(56 2 #reduceActionForSequence2: 3968002 false ) 
	#(114 2 #reduceActionForSymbol4: 8290308 false ) 
	#(114 2 #reduceActionForSymbol4: 8290306 false ) 
	#(116 0 #reduceActionForByteArrayLiteralValue__value__1: 8339457 false ) 
	#(117 1 #reduceActionFor__name___namePart___Template__namePart___1: 8425473 false ) 
	#(114 2 #reduceActionForSymbol3: 8290307 false ) 
	#(54 1 #liftFirstValue: 3759106 false ) 
	#(44 2 #reduceActionForPragmas1: 3131393 false ) 
	#(56 2 #reduceActionForSequence9: 3968009 false ) 
	#(60 2 #reduceActionForKeywordPattern1: 4219907 false ) 
	#(60 2 #reduceActionForStatements2: 4219906 false ) 
	#(64 2 #reduceActionForCascade1: 4604929 false ) 
	#(67 1 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___1: 4803585 false ) 
	#(65 1 #reduceActionForKeywordPattern1: 4783105 false ) 
	#(75 2 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__1: 5361665 false ) 
	#(64 2 #reduceActionForCascade1: 4604930 false ) 
	#(64 2 #reduceActionForCascade1: 4604931 false ) 
	#(95 0 #reduceActionForByteArrayLiteralValue__value__1: 7042049 false ) 
	#(56 2 #reduceActionForSequence3: 3968003 false ) 
	#(41 3 #reduceActionForMethodPattern3: 2752515 false ) 
	#(40 3 #reduceActionForMethod5: 2661381 false ) 
	#(121 3 #reduceActionForTemplate1: 8543233 false ) 
	#(40 3 #reduceActionForMethod3: 2661379 false ) 
	#(40 3 #reduceActionForMethod1: 2661378 false ) 
	#(41 3 #reduceActionForMethodPattern7: 2752519 false ) 
	#(51 3 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__2: 3609602 false ) 
	#(42 3 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__2: 3012610 false ) 
	#(57 3 #reduceActionForTemporaries2: 4049922 false ) 
	#(62 3 #reduceActionForStatement2: 4395010 false ) 
	#(47 3 #reduceActionForPragma1: 3190785 false ) 
	#(49 0 #reduceActionForStatements_1: 3352577 false ) 
	#(47 3 #reduceActionForPragma7: 3190791 false ) 
	#(84 0 #reduceActionForStatements_1: 6052865 false ) 
	#(90 0 #reduceActionForStatements_1: 6624257 false ) 
	#(87 0 #reduceActionForStatements_1: 6363137 false ) 
	#(81 3 #reduceActionForValue5: 5831685 false ) 
	#(97 3 #reduceActionForByteArrayLiteral1: 7493633 false ) 
	#(99 1 #liftFirstValue: 7612417 false ) 
	#(98 2 #reduceActionFor__name___namePart___Template__namePart___2: 7544834 false ) 
	#(99 1 #reduceActionForValue6: 7612418 false ) 
	#(119 1 #liftFirstValue: 8509441 false ) 
	#(120 2 #liftFirstValue: 8509442 false ) 
	#(56 3 #reduceActionForSequence6: 3968006 false ) 
	#(56 3 #reduceActionForSequence7: 3968007 false ) 
	#(114 3 #reduceActionForSymbol1: 8290305 false ) 
	#(117 2 #reduceActionFor__name___namePart___Template__namePart___2: 8425474 false ) 
	#(53 3 #reduceActionForMethodSequence33: 3669025 false ) 
	#(46 2 #reduceActionFor__name___namePart___Template__namePart___2: 3159042 false ) 
	#(45 1 #liftFirstValue: 3159041 false ) 
	#(56 3 #reduceActionForSequence10: 3968010 false ) 
	#(53 3 #reduceActionForMethodSequence17: 3669009 false ) 
	#(56 3 #reduceActionForSequence11: 3968011 false ) 
	#(60 3 #reduceActionForStatements4: 4219908 false ) 
	#(61 3 #reduceActionForStatementList2: 4278274 false ) 
	#(66 2 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__1: 4803585 false ) 
	#(68 1 #liftFirstValue: 4870145 false ) 
	#(68 1 #liftFirstValue: 4870146 false ) 
	#(68 1 #liftFirstValue: 4870147 false ) 
	#(79 1 #reduceActionForUnaryMessage1: 5699585 false ) 
	#(67 2 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: 4803586 false ) 
	#(76 2 #reduceActionForBinaryMessage1: 5454849 false ) 
	#(70 3 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__2: 5028865 false ) 
	#(75 3 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__2: 5361666 false ) 
	#(78 3 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__2: 5610497 false ) 
	#(63 3 #reduceActionForAssignment1: 4485121 false ) 
	#(105 0 #reduceActionForEndLiteralArray1: 7946241 false ) 
	#(56 3 #reduceActionForSequence4: 3968004 false ) 
	#(40 4 #reduceActionForMethod7: 2661383 false ) 
	#(40 4 #reduceActionForMethod5: 2661382 false ) 
	#(40 4 #reduceActionForMethod3: 2661380 false ) 
	#(57 4 #reduceActionForTemporaries3: 4049923 false ) 
	#(59 2 #reduceActionFor__name___namePart___Template__namePart___2: 4158466 false ) 
	#(58 1 #liftFirstValue: 4158465 false ) 
	#(82 4 #reduceActionForArray1: 5991425 false ) 
	#(85 4 #reduceActionForBlock1: 6157313 false ) 
	#(85 4 #reduceActionForBlock13: 6157325 false ) 
	#(119 2 #liftFirstValue: 8509442 false ) 
	#(56 4 #reduceActionForSequence8: 3968008 false ) 
	#(116 2 #reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart___2: 8339458 false ) 
	#(53 4 #reduceActionForMethodSequence35: 3669027 false ) 
	#(53 4 #reduceActionForMethodSequence37: 3669029 false ) 
	#(53 4 #reduceActionForMethodSequence34: 3669026 false ) 
	#(45 2 #liftSecondValue: 3159042 false ) 
	#(56 4 #reduceActionForSequence14: 3968014 false ) 
	#(53 4 #reduceActionForMethodSequence25: 3669017 false ) 
	#(56 4 #reduceActionForSequence15: 3968015 false ) 
	#(53 4 #reduceActionForMethodSequence18: 3669010 false ) 
	#(53 4 #reduceActionForMethodSequence19: 3669011 false ) 
	#(56 4 #reduceActionForSequence12: 3968012 false ) 
	#(61 4 #reduceActionForStatementList4: 4278276 false ) 
	#(61 4 #reduceActionForStatementList3: 4278275 false ) 
	#(66 3 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__2: 4803586 false ) 
	#(73 0 #reduceActionForStatements_1: 5199873 false ) 
	#(76 3 #reduceActionForBinaryMessage2: 5454850 false ) 
	#(63 4 #reduceActionForAssignment2: 4485122 false ) 
	#(63 4 #reduceActionForAssignment3: 4485123 false ) 
	#(96 1 #reduceActionForSymbolLiteral1: 7119875 false ) 
	#(96 1 #reduceActionForSymbolLiteral1: 7119874 false ) 
	#(96 1 #reduceActionForSymbolLiteral1: 7119876 false ) 
	#(96 1 #reduceActionForSymbolLiteral1: 7119878 false ) 
	#(96 1 #reduceActionForSymbolLiteral1: 7119877 false ) 
	#(96 1 #liftFirstValue: 7119873 false ) 
	#(95 2 #reduceActionFor__name___namePart___Template__namePart___2: 7042050 false ) 
	#(96 1 #reduceActionForValue6: 7119880 false ) 
	#(40 5 #reduceActionForMethod7: 2661384 false ) 
	#(57 5 #reduceActionForTemporaries5: 4049925 false ) 
	#(57 5 #reduceActionForTemporaries4: 4049924 false ) 
	#(58 2 #liftSecondValue: 4158466 false ) 
	#(47 5 #reduceActionForPragma3: 3190787 false ) 
	#(49 2 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: 3352578 false ) 
	#(47 5 #reduceActionForPragma3: 3190786 false ) 
	#(82 5 #reduceActionForArray2: 5991426 false ) 
	#(84 2 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: 6052866 false ) 
	#(85 5 #reduceActionForBlock9: 6157321 false ) 
	#(87 2 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: 6363138 false ) 
	#(88 4 #reduceActionForBlockArgs2: 6569986 false ) 
	#(90 2 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: 6624258 false ) 
	#(85 5 #reduceActionForBlock5: 6157317 false ) 
	#(85 5 #reduceActionForBlock15: 6157327 false ) 
	#(85 5 #reduceActionForBlock3: 6157315 false ) 
	#(85 5 #reduceActionForBlock14: 6157326 false ) 
	#(85 5 #reduceActionForBlock2: 6157314 false ) 
	#(53 5 #reduceActionForMethodSequence43: 3669035 false ) 
	#(53 5 #reduceActionForMethodSequence45: 3669037 false ) 
	#(53 5 #reduceActionForMethodSequence36: 3669028 false ) 
	#(53 5 #reduceActionForMethodSequence39: 3669031 false ) 
	#(53 5 #reduceActionForMethodSequence1: 3668993 false ) 
	#(53 5 #reduceActionForMethodSequence38: 3669030 false ) 
	#(53 5 #reduceActionForMethodSequence26: 3669018 false ) 
	#(53 5 #reduceActionForMethodSequence27: 3669019 false ) 
	#(56 5 #reduceActionForSequence16: 3968016 false ) 
	#(53 5 #reduceActionForMethodSequence22: 3669014 false ) 
	#(53 5 #reduceActionForMethodSequence23: 3669015 false ) 
	#(53 5 #reduceActionForMethodSequence20: 3669012 false ) 
	#(61 5 #reduceActionForStatementList5: 4278277 false ) 
	#(71 3 #reduceActionForKeywordMessage1: 5122049 false ) 
	#(63 5 #reduceActionForAssignment4: 4485124 false ) 
	#(94 5 #reduceActionForArrayLiteral1: 6970369 false ) 
	#(57 6 #reduceActionForTemporaries6: 4049926 false ) 
	#(47 6 #reduceActionForPragma5: 3190789 false ) 
	#(47 6 #reduceActionForPragma5: 3190788 false ) 
	#(83 2 #reduceActionFor_Keyword__selectorPart___space___Variable__variable__1: 6052865 false ) 
	#(82 6 #reduceActionForArray3: 5991427 false ) 
	#(85 6 #reduceActionForBlock10: 6157322 false ) 
	#(88 5 #reduceActionForBlockArgs3: 6569987 false ) 
	#(85 6 #reduceActionForBlock11: 6157323 false ) 
	#(85 6 #reduceActionForBlock7: 6157319 false ) 
	#(85 6 #reduceActionForBlock16: 6157328 false ) 
	#(85 6 #reduceActionForBlock6: 6157318 false ) 
	#(85 6 #reduceActionForBlock4: 6157316 false ) 
	#(115 3 #reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart__1: 8339457 false ) 
	#(53 6 #reduceActionForMethodSequence44: 3669036 false ) 
	#(53 6 #reduceActionForMethodSequence47: 3669039 false ) 
	#(53 6 #reduceActionForMethodSequence9: 3669001 false ) 
	#(53 6 #reduceActionForMethodSequence46: 3669038 false ) 
	#(53 6 #reduceActionForMethodSequence5: 3668997 false ) 
	#(53 6 #reduceActionForMethodSequence40: 3669032 false ) 
	#(53 6 #reduceActionForMethodSequence3: 3668995 false ) 
	#(53 6 #reduceActionForMethodSequence2: 3668994 false ) 
	#(53 6 #reduceActionForMethodSequence30: 3669022 false ) 
	#(53 6 #reduceActionForMethodSequence31: 3669023 false ) 
	#(53 6 #reduceActionForMethodSequence28: 3669020 false ) 
	#(53 6 #reduceActionForMethodSequence24: 3669016 false ) 
	#(71 4 #reduceActionForKeywordMessage2: 5122050 false ) 
	#(73 2 #reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: 5199874 false ) 
	#(96 3 #reduceActionForArrayLiteralValue7: 7119879 false ) 
	#(48 3 #reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___2: 3352578 false ) 
	#(48 3 #reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___2: 3352577 false ) 
	#(82 7 #reduceActionForArray4: 5991428 false ) 
	#(86 3 #reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___2: 6363137 false ) 
	#(89 3 #reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___2: 6624257 false ) 
	#(85 7 #reduceActionForBlock12: 6157324 false ) 
	#(85 7 #reduceActionForBlock8: 6157320 false ) 
	#(53 7 #reduceActionForMethodSequence13: 3669005 false ) 
	#(53 7 #reduceActionForMethodSequence48: 3669040 false ) 
	#(53 7 #reduceActionForMethodSequence11: 3669003 false ) 
	#(53 7 #reduceActionForMethodSequence10: 3669002 false ) 
	#(53 7 #reduceActionForMethodSequence7: 3668999 false ) 
	#(53 7 #reduceActionForMethodSequence6: 3668998 false ) 
	#(53 7 #reduceActionForMethodSequence4: 3668996 false ) 
	#(53 7 #reduceActionForMethodSequence32: 3669024 false ) 
	#(48 4 #reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___4: 3352580 false ) 
	#(48 4 #reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___4: 3352579 false ) 
	#(53 8 #reduceActionForMethodSequence15: 3669007 false ) 
	#(53 8 #reduceActionForMethodSequence14: 3669006 false ) 
	#(53 8 #reduceActionForMethodSequence12: 3669004 false ) 
	#(53 8 #reduceActionForMethodSequence8: 3669000 false ) 
	#(72 3 #reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___2: 5199873 false ) 
	#(53 9 #reduceActionForMethodSequence16: 3669008 false ) 
	#(72 4 #reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___4: 5199874 false )
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
GtPharoTemplateParser class >> symbolNames [
	^ #('<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<space>' '<patternToken>' '<self>' '<super>' '<thisContext>' '<symbolHash>' '<doubleLeftBrace>' '<doubleRightBrace>' 'B e g i n' 'Method' 'MethodPattern' '(Keyword ''selectorPart'' <space>?Variable ''variable'')' '(Keyword ''selectorPart'' <space>?Variable ''variable'')+' 'Pragmas' '(<space>? Pragma ''pragma'')' '(<space>? Pragma ''pragma'')*' 'Pragma' '(<space> Keyword ''selectorPart'' <space>?(Literal ''value'' | Variable ''value''))' '(<space> Keyword ''selectorPart'' <space>?(Literal ''value'' | Variable ''value''))*' 'KeywordPattern' '(Keyword ''selectorPart'' <space>? Variable ''variable'')' '(Keyword ''selectorPart'' <space>? Variable ''variable'')+' 'MethodSequence' '<space>?' 'Statements?' 'Sequence' 'Temporaries' '(<space>? Variable ''variable'')' '(<space>? Variable ''variable'')*' 'Statements' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' <space>? CascadedMessage ''message'')' '(<semicolon> ''semicolon'' <space>? CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '(<space>Keyword ''selectorPart'' <space>? BinaryMessageSend ''value'')' '(<space>Keyword ''selectorPart'' <space>? BinaryMessageSend ''value'')*' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'Variable' 'Value' 'Array' '(<period> ''period'' Assignment ''value'')' '(<period> ''period'' Assignment ''value'')*' 'Block' '(<space><colon> ''colon'' Variable ''variable'')' '(<space><colon> ''colon'' Variable ''variable'')*' 'BlockArgs' '(<space> <colon> ''colon'' Variable ''variable'')' '(<space> <colon> ''colon'' Variable ''variable'')*' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' 'SelfVariable' 'SuperVariable' 'NamedVariable' 'ThisContextVariable' 'Name' '(<name> ''namePart''| Template ''namePart'')' '(<name> ''namePart''| Template ''namePart'')+' 'Keyword' 'Symbol' '(<colon>''symbolPart''<colon> ''symbolPart''Name''symbolPart'')' '(<colon>''symbolPart''<colon> ''symbolPart''Name''symbolPart'')*' 'Keyword''symbolPart''+' 'Period' '(<space>? <period> ''period'')' '(<space>? <period> ''period'')*' 'Template' 'E O F' 'error')
]

{ #category : #generated }
GtPharoTemplateParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #SmaCCToken #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoVariableNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoVariableNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #GtPharoSelfVariableNode #GtPharoSuperVariableNode #GtPharoNamedVariableNode #GtPharoThisContextVariableNode #GtPharoNameNode #Object #OrderedCollection #GtPharoKeywordNode #GtPharoSymbolNode #OrderedCollection #OrderedCollection #OrderedCollection nil #SmaCCToken nil #GtPharoTemplateNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoTemplateParser class >> transitionTable [
^#(
#[1 0 69 0 4 0 25 0 25 0 29 0 31 0 33 0 37 0 37 0 40 0 41 0 41 0 45 0 42 0 49 0 43 0 53 0 50 0 57 0 51 0 61 0 52 0 65 0 110 0 69 0 111 0 73 0 112 0 77 0 113 0 69 0 121] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 121 0 13 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 145 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 0 165 0 44 0 169 0 47 0 173 0 53 0 177 0 55 0 173 0 56 0 185 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 1 57 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 1 65 0 62 1 65 0 63 1 65 0 64 1 65 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 0 69 0 4 0 25 0 25 0 33 0 37 1 69 0 41 0 45 0 42 0 49 0 43 0 53 0 50 0 57 0 51 0 61 0 52 0 65 0 110 0 69 0 111 0 73 0 112 0 77 0 113 0 69 0 121] 
#[0 0 14 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[1 0 69 0 4 1 73 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 1 77 0 80 1 77 0 106 1 77 0 107 1 77 0 108 1 77 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121 1 81 0 123] 
#[1 0 69 0 4 0 25 0 25 0 33 0 37 1 85 0 41 0 45 0 42 0 49 0 43 0 53 0 50 0 57 0 51 0 61 0 52 0 65 0 110 0 69 0 111 0 73 0 112 0 77 0 113 0 69 0 121] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 1 89 0 63 1 89 0 64 1 89 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 0 0 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 121 0 13 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 7 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 0 165 0 44 0 169 0 47 1 97 0 53 0 177 0 55 1 97 0 56 0 185 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 1 57 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 0 18 0 4 0 37] 
#[1 0 69 0 4 0 33 0 37 1 101 0 42 1 105 0 110 0 69 0 111 0 73 0 112 1 109 0 113 0 69 0 121] 
#[0 0 22 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 0 26 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 30 0 1 0 30 0 2 0 30 0 3 0 11 0 4 0 30 0 6 0 30 0 7 0 30 0 8 0 30 0 9 0 30 0 10 0 30 0 12 0 30 0 13 0 30 0 15 0 30 0 16 0 30 0 18 0 30 0 19 0 30 0 20 0 30 0 28 0 30 0 31 0 30 0 33 0 30 0 34 0 30 0 35 0 30 0 36 0 15 0 37 1 113 0 51 1 105 0 110 0 69 0 111 0 73 0 112 1 117 0 113 0 69 0 121 0 30 0 122 0 30 0 123] 
#[1 0 34 0 1 0 34 0 2 0 34 0 3 0 34 0 4 0 34 0 6 0 34 0 7 0 34 0 8 0 34 0 9 0 34 0 10 0 34 0 12 0 34 0 13 0 34 0 15 0 34 0 16 1 121 0 17 0 34 0 18 0 34 0 19 0 34 0 20 0 34 0 28 0 34 0 31 0 34 0 33 0 34 0 34 0 34 0 35 0 34 0 36 0 34 0 37 0 34 0 122 0 34 0 123] 
#[0 0 38 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[1 0 42 0 1 0 42 0 2 0 42 0 3 0 19 0 4 0 42 0 6 0 42 0 7 0 42 0 8 0 42 0 9 0 42 0 10 0 42 0 11 0 42 0 12 0 42 0 13 0 42 0 14 0 42 0 15 0 42 0 16 0 42 0 17 0 42 0 18 0 42 0 19 0 42 0 20 0 42 0 21 0 42 0 22 0 42 0 25 0 42 0 26 0 42 0 27 0 42 0 28 0 42 0 31 0 42 0 33 0 42 0 34 0 42 0 35 0 42 0 36 0 23 0 37 0 42 0 38 1 125 0 111 1 125 0 121 0 42 0 122 0 42 0 123] 
#[1 0 69 0 4 1 129 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 1 133 0 80 1 133 0 106 1 133 0 107 1 133 0 108 1 133 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121 1 137 0 123] 
#[0 0 46 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 0 50 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 54 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 58 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[1 0 69 0 4 1 141 0 6 1 145 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 1 149 0 80 1 149 0 106 1 149 0 107 1 149 0 108 1 149 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 0 62 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 66 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 70 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 74 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 1 153 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 1 157 0 63 1 157 0 64 1 157 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 0 69 0 4 0 33 0 37 1 161 0 110 0 69 0 111 0 73 0 112 1 165 0 113 0 69 0 121 1 169 0 123] 
#[0 1 173 0 31] 
#[1 0 78 0 1 0 78 0 2 0 78 0 3 0 78 0 4 0 78 0 6 0 78 0 7 0 78 0 8 0 78 0 9 0 78 0 10 0 78 0 12 0 78 0 15 0 78 0 16 1 177 0 17 0 78 0 18 0 78 0 19 0 78 0 20 0 78 0 22 0 78 0 28 0 27 0 31 0 78 0 33 0 78 0 34 0 78 0 35 0 78 0 36 0 78 0 37 1 185 0 88 0 78 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 1 189 0 63 1 189 0 64 1 189 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 0 82 0 9 0 82 0 10 0 82 0 22 1 193 0 98 0 82 0 123] 
#[1 0 86 0 1 0 86 0 2 0 86 0 3 0 86 0 4 0 86 0 7 0 86 0 8 0 86 0 9 0 86 0 10 0 86 0 12 0 86 0 15 0 86 0 16 0 86 0 18 0 86 0 19 0 86 0 20 0 86 0 22 0 86 0 28 0 86 0 31 0 86 0 33 0 86 0 34 0 86 0 35 0 86 0 36 0 86 0 37 1 197 0 120 0 86 0 122 0 86 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 1 201 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 1 205 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 1 209 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 0 90 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 0 94 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 0 98 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[1 0 69 0 4 1 213 0 7 1 217 0 25 0 33 0 37 1 221 0 110 0 69 0 111 0 73 0 112 1 225 0 113 1 229 0 117 0 69 0 121] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 97 0 6 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 141 0 28 0 31 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 1 237 0 54 1 241 0 57 1 245 0 118 0 102 0 122 0 102 0 123] 
#[1 0 106 0 1 0 106 0 2 0 106 0 3 0 106 0 4 0 106 0 6 0 106 0 7 0 106 0 8 0 106 0 9 0 106 0 10 0 106 0 12 0 106 0 13 0 106 0 15 0 106 0 16 0 106 0 18 0 106 0 19 0 106 0 20 0 106 0 28 0 106 0 31 0 106 0 33 0 106 0 34 0 106 0 35 0 106 0 36 0 106 0 37 1 249 0 46 0 106 0 122 0 106 0 123] 
#[0 0 0 0 122] 
#[0 0 110 0 22 0 31 0 122 0 123] 
#[0 0 114 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 121 0 13 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 35 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 1 0 44 0 169 0 47 2 5 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 2 9 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 0 118 0 22 0 31 0 122 0 123] 
#[1 0 122 0 22 0 141 0 28 0 39 0 31 2 17 0 118 0 122 0 122 0 122 0 123] 
#[0 0 126 0 22 0 28 0 31 0 122 0 123] 
#[0 0 130 0 22 0 28 0 31 0 122 0 123] 
#[0 0 134 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[0 0 138 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[1 0 142 0 21 0 142 0 22 2 21 0 26 0 142 0 28 0 142 0 31 0 142 0 38 2 25 0 65 2 29 0 66 2 33 0 67 0 142 0 122 0 142 0 123] 
#[1 0 146 0 21 0 146 0 22 2 37 0 25 0 146 0 28 0 43 0 31 0 146 0 38 2 45 0 76 0 146 0 122 0 146 0 123] 
#[1 0 150 0 21 0 150 0 22 0 150 0 25 2 21 0 26 0 150 0 28 0 150 0 31 0 150 0 38 2 49 0 65 2 29 0 66 2 33 0 67 0 150 0 122 0 150 0 123] 
#[1 0 154 0 21 0 154 0 22 0 154 0 25 0 154 0 26 0 154 0 28 0 47 0 31 0 154 0 38 0 154 0 122 0 154 0 123] 
#[1 0 158 0 21 0 158 0 22 0 158 0 25 2 21 0 26 0 158 0 28 0 158 0 31 0 158 0 38 2 57 0 65 2 29 0 66 2 33 0 67 0 158 0 122 0 158 0 123] 
#[1 0 162 0 21 0 162 0 22 0 162 0 25 2 61 0 27 0 162 0 28 0 51 0 31 0 162 0 38 0 162 0 122 0 162 0 123] 
#[0 0 166 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 0 170 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 0 174 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 0 178 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 0 182 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 186 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 190 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 194 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 198 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 202 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 206 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 0 210 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 2 69 0 19] 
#[0 0 214 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 0 218 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 0 222 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 0 226 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 0 230 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 0 234 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 55 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 77 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 0 238 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 0 0 0 122] 
#[0 0 0 0 122] 
#[1 0 69 0 4 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 2 81 0 80 2 81 0 106 2 81 0 107 2 81 0 108 2 81 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 0 242 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 0 246 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 121 0 13 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 63 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 0 165 0 44 0 169 0 47 2 89 0 53 0 177 0 55 2 89 0 56 0 185 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 1 57 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 2 93 0 38] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 121 0 13 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 67 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 0 165 0 44 0 169 0 47 2 101 0 53 2 105 0 55 2 101 0 56 0 185 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 2 109 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 2 113 0 31 0 250 0 122] 
#[0 0 254 0 4 0 37] 
#[0 1 121 0 17] 
#[1 0 69 0 4 2 117 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 2 121 0 80 2 121 0 106 2 121 0 107 2 121 0 108 2 121 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121 2 125 0 123] 
#[0 1 2 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 69 0 4 2 129 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 2 133 0 80 2 133 0 106 2 133 0 107 2 133 0 108 2 133 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 1 6 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[0 1 10 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[1 0 69 0 4 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 2 137 0 80 2 137 0 106 2 137 0 107 2 137 0 108 2 137 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[1 1 14 0 1 1 14 0 2 1 14 0 3 0 71 0 4 1 14 0 6 1 14 0 7 1 14 0 8 1 14 0 9 1 14 0 10 1 14 0 12 1 14 0 13 1 14 0 15 1 14 0 16 1 14 0 18 1 14 0 19 1 14 0 20 1 14 0 28 1 14 0 31 1 14 0 33 1 14 0 34 1 14 0 35 1 14 0 36 0 71 0 37 1 14 0 122 1 14 0 123] 
#[0 1 22 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 1 26 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 69 0 4 2 141 0 6 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 2 145 0 80 2 145 0 106 2 145 0 107 2 145 0 108 2 145 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[1 1 30 0 4 1 30 0 6 1 30 0 31 1 30 0 33 1 30 0 34 1 30 0 35 1 30 0 37 2 149 0 59] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 153 0 63 2 153 0 64 2 153 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 1 34 0 22 0 28 0 31 0 122 0 123] 
#[1 2 157 0 14 1 121 0 17] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 6 0 19 0 137 0 20 2 161 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 165 0 80 2 169 0 91 2 169 0 92 2 169 0 93 2 169 0 94 2 169 0 97 2 169 0 100 2 169 0 101 2 169 0 102 2 169 0 103 1 29 0 104 2 165 0 106 2 165 0 107 2 165 0 108 2 165 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121] 
#[1 1 38 0 1 1 38 0 2 1 38 0 3 1 38 0 4 1 38 0 6 1 38 0 7 1 38 0 8 1 38 0 9 1 38 0 10 1 38 0 12 1 38 0 13 2 173 0 14 1 38 0 15 1 38 0 16 1 38 0 18 1 38 0 19 1 38 0 20 1 38 0 28 1 38 0 31 1 38 0 33 1 38 0 34 1 38 0 35 1 38 0 36 1 38 0 37 1 38 0 122 1 38 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 2 177 0 28 2 181 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 185 0 63 2 185 0 64 2 185 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 0 69 0 4 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 2 189 0 80 2 189 0 106 2 189 0 107 2 189 0 108 2 189 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[1 0 78 0 1 0 78 0 2 0 78 0 3 0 78 0 4 0 78 0 6 0 78 0 7 0 78 0 8 0 78 0 9 0 78 0 10 0 78 0 12 0 78 0 15 0 78 0 16 2 193 0 17 0 78 0 18 0 78 0 19 0 78 0 20 0 78 0 22 0 78 0 28 0 78 0 31 0 78 0 33 0 78 0 34 0 78 0 35 0 78 0 36 0 78 0 37 2 197 0 88 0 78 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 141 0 28 0 75 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 0 177 0 55 2 205 0 56 2 209 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 1 57 0 118 0 69 0 121 0 59 0 123] 
#[0 2 213 0 21] 
#[1 0 109 0 9 0 113 0 10 2 217 0 22 2 225 0 93 2 225 0 99 2 229 0 123] 
#[1 1 42 0 1 1 42 0 2 1 42 0 3 1 42 0 4 1 42 0 7 1 42 0 8 1 42 0 9 1 42 0 10 1 42 0 12 1 42 0 15 1 42 0 16 1 42 0 18 1 42 0 19 1 42 0 20 1 42 0 22 2 241 0 28 0 79 0 31 1 42 0 33 1 42 0 34 1 42 0 35 1 42 0 36 1 42 0 37 2 241 0 119 1 42 0 122 1 42 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 245 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 1 46 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 83 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 253 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 1 50 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 1 54 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[1 1 58 0 1 1 58 0 2 1 58 0 3 1 58 0 4 1 58 0 7 1 58 0 8 1 58 0 9 1 58 0 10 1 58 0 11 1 58 0 14 0 87 0 17 1 58 0 18 1 58 0 19 1 58 0 20 1 58 0 21 1 58 0 22 1 58 0 25 1 58 0 26 1 58 0 28 1 58 0 31 1 58 0 36 1 58 0 38 3 1 0 116 1 58 0 122 1 58 0 123] 
#[0 1 62 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 37 0 38 0 122 0 123] 
#[1 1 66 0 1 1 66 0 2 1 66 0 3 0 91 0 4 1 66 0 7 1 66 0 8 1 66 0 9 1 66 0 10 1 66 0 11 1 66 0 14 1 66 0 18 1 66 0 19 1 66 0 20 1 66 0 21 1 66 0 22 1 66 0 25 1 66 0 26 1 66 0 28 1 66 0 31 1 66 0 36 0 33 0 37 1 66 0 38 1 105 0 110 0 69 0 111 0 73 0 112 3 5 0 113 0 69 0 121 1 66 0 122 1 66 0 123] 
#[1 0 95 0 1 0 95 0 2 0 95 0 3 0 95 0 4 0 97 0 6 0 95 0 7 0 95 0 8 0 95 0 9 0 95 0 10 0 95 0 12 0 95 0 15 0 95 0 16 0 95 0 18 0 95 0 19 0 95 0 20 0 141 0 28 0 99 0 31 0 95 0 33 0 95 0 34 0 95 0 35 0 95 0 36 0 95 0 37 3 13 0 54 3 17 0 57 3 21 0 118 0 95 0 122 0 95 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 25 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 121 0 13 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 141 0 28 0 103 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 3 33 0 44 0 169 0 47 3 37 0 54 3 41 0 118 0 102 0 122 0 102 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 3 49 0 54 0 102 0 122 0 102 0 123] 
#[1 1 74 0 1 1 74 0 2 1 74 0 3 1 74 0 4 1 74 0 6 1 74 0 7 1 74 0 8 1 74 0 9 1 74 0 10 1 74 0 12 0 121 0 13 1 74 0 15 1 74 0 16 1 74 0 18 1 74 0 19 1 74 0 20 1 74 0 28 0 111 0 31 1 74 0 33 1 74 0 34 1 74 0 35 1 74 0 36 1 74 0 37 3 57 0 45 3 57 0 47 1 74 0 122 1 74 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 121 0 13 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 115 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 69 0 44 0 169 0 47 3 73 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 3 77 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 119 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 85 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 3 89 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 1 78 0 22 0 31 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 123 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 97 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[1 1 82 0 22 0 141 0 28 1 82 0 31 3 101 0 118 1 82 0 122 1 82 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 1 86 0 22 0 127 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 109 0 62 3 109 0 63 3 109 0 64 3 109 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 86 0 122 0 131 0 123] 
#[1 0 69 0 4 2 37 0 25 3 113 0 31 0 33 0 37 3 117 0 68 3 117 0 71 3 117 0 76 3 117 0 79 3 133 0 110 0 69 0 111 0 73 0 112 3 137 0 113 0 69 0 121] 
#[0 1 90 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[0 1 94 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 1 98 0 21 1 98 0 22 2 21 0 26 1 98 0 28 1 98 0 31 1 98 0 38 3 141 0 66 1 98 0 122 1 98 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 3 145 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 149 0 77 3 153 0 78 3 149 0 80 3 149 0 81 3 149 0 82 3 149 0 85 3 149 0 91 3 149 0 92 3 149 0 93 3 149 0 94 3 149 0 97 3 149 0 100 3 149 0 101 3 149 0 102 3 149 0 103 1 29 0 104 3 149 0 106 3 149 0 107 3 149 0 108 3 149 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 0 69 0 4 2 37 0 25 0 33 0 37 3 161 0 71 3 165 0 76 1 105 0 110 0 69 0 111 0 73 0 112 3 137 0 113 0 69 0 121] 
#[0 1 102 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 1 106 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[1 0 69 0 4 0 33 0 37 3 169 0 79 3 173 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 1 110 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 3 177 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 181 0 63 3 181 0 64 3 181 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 3 185 0 27] 
#[1 1 114 0 1 1 114 0 2 1 114 0 3 1 114 0 4 1 114 0 7 1 114 0 8 1 114 0 9 1 114 0 10 1 114 0 11 1 114 0 18 1 114 0 19 1 114 0 20 1 114 0 21 1 114 0 25 1 114 0 26 1 114 0 28 1 114 0 36 3 189 0 95 1 114 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 193 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 1 118 0 22 0 31 0 122 0 123] 
#[0 1 122 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 121 0 13 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 67 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 0 165 0 44 0 169 0 47 3 197 0 53 2 105 0 55 3 197 0 56 0 185 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 2 109 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 3 201 0 31 1 126 0 122] 
#[0 1 130 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 27 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 141 0 28 0 135 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 205 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 1 209 0 118 0 69 0 121 0 10 0 122 0 59 0 123] 
#[1 3 209 0 31 1 134 0 122] 
#[0 0 139 0 22 0 31 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 143 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 217 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 1 138 0 122] 
#[1 0 69 0 4 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 3 221 0 80 3 221 0 106 3 221 0 107 3 221 0 108 3 221 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 1 18 0 4 0 37] 
#[0 1 142 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 69 0 4 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 3 225 0 80 3 225 0 106 3 225 0 107 3 225 0 108 3 225 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 1 14 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 1 146 0 1 1 146 0 2 1 146 0 3 0 147 0 4 1 146 0 6 1 146 0 7 1 146 0 8 1 146 0 9 1 146 0 10 1 146 0 12 1 146 0 13 1 146 0 15 1 146 0 16 1 146 0 18 1 146 0 19 1 146 0 20 1 146 0 28 1 146 0 31 1 146 0 33 1 146 0 34 1 146 0 35 1 146 0 36 0 147 0 37 1 146 0 122 1 146 0 123] 
#[0 1 154 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 1 30 0 4 1 30 0 6 1 30 0 31 1 30 0 33 1 30 0 34 1 30 0 35 1 30 0 37 3 229 0 59] 
#[1 0 69 0 4 3 233 0 6 3 237 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 3 241 0 58 3 241 0 80 3 241 0 106 3 241 0 107 3 241 0 108 3 241 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 1 158 0 22 0 28 0 31 0 122 0 123] 
#[0 1 162 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 249 0 80 3 253 0 91 3 253 0 92 3 253 0 93 3 253 0 94 3 253 0 97 3 253 0 100 3 253 0 101 3 253 0 102 3 253 0 103 1 29 0 104 3 249 0 106 3 249 0 107 3 249 0 108 3 249 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121] 
#[1 1 166 0 14 1 166 0 31 4 1 0 49] 
#[1 1 166 0 14 1 166 0 31 4 5 0 49] 
#[0 1 170 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 4 9 0 31] 
#[0 4 13 0 23] 
#[1 1 174 0 28 1 174 0 31 4 17 0 84] 
#[1 1 178 0 6 1 182 0 22 0 151 0 31 4 21 0 87 4 25 0 90] 
#[1 0 69 0 4 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 4 29 0 80 4 29 0 106 4 29 0 107 4 29 0 108 4 29 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 141 0 28 0 155 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 0 177 0 55 4 37 0 56 2 209 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 1 57 0 118 0 69 0 121 0 59 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 141 0 28 0 67 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 105 0 55 4 41 0 56 2 209 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 2 109 0 118 0 69 0 121 0 59 0 123] 
#[1 4 45 0 22 4 49 0 31 4 53 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 141 0 28 0 159 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 5 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 2 9 0 118 0 69 0 121 0 59 0 123] 
#[0 1 186 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 1 190 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 1 194 0 9 0 10 0 22 0 123] 
#[0 1 198 0 9 0 10 0 22 0 123] 
#[0 1 202 0 9 0 10 0 22 0 123] 
#[0 1 206 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 4 61 0 28] 
#[0 1 210 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 1 214 0 22 0 31 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 65 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 1 218 0 22 0 31 0 122 0 123] 
#[1 1 222 0 1 1 222 0 2 1 222 0 3 1 222 0 4 1 222 0 7 1 222 0 8 1 222 0 9 1 222 0 10 1 222 0 11 1 222 0 14 4 69 0 17 1 222 0 18 1 222 0 19 1 222 0 20 1 222 0 21 1 222 0 22 1 222 0 25 1 222 0 26 1 222 0 28 1 222 0 31 1 222 0 36 1 222 0 38 4 73 0 115 1 222 0 122 1 222 0 123] 
#[0 1 226 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 37 0 38 0 122 0 123] 
#[1 0 95 0 1 0 95 0 2 0 95 0 3 0 95 0 4 0 95 0 7 0 95 0 8 0 95 0 9 0 95 0 10 0 95 0 12 0 95 0 15 0 95 0 16 0 95 0 18 0 95 0 19 0 95 0 20 0 141 0 28 0 163 0 31 0 95 0 33 0 95 0 34 0 95 0 35 0 95 0 36 0 95 0 37 4 77 0 54 4 81 0 118 0 95 0 122 0 95 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 85 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 121 0 13 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 141 0 28 0 167 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 4 93 0 44 0 169 0 47 4 97 0 54 4 101 0 118 0 102 0 122 0 102 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 4 105 0 54 0 102 0 122 0 102 0 123] 
#[0 1 230 0 31 0 122] 
#[1 0 95 0 1 0 95 0 2 0 95 0 3 0 95 0 4 0 95 0 7 0 95 0 8 0 95 0 9 0 95 0 10 0 95 0 12 0 121 0 13 0 95 0 15 0 95 0 16 0 95 0 18 0 95 0 19 0 95 0 20 0 141 0 28 0 163 0 31 0 95 0 33 0 95 0 34 0 95 0 35 0 95 0 36 0 95 0 37 4 109 0 44 0 169 0 47 4 113 0 54 4 117 0 118 0 95 0 122 0 95 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 141 0 28 0 171 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 4 125 0 54 4 129 0 118 0 102 0 122 0 102 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 133 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 4 137 0 54 0 102 0 122 0 102 0 123] 
#[0 1 70 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 141 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 121 0 13 4 145 0 47] 
#[0 1 234 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 1 238 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 149 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 175 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 157 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 4 161 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 1 242 0 22 0 31 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 179 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 169 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 183 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 177 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 4 181 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 1 246 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 187 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 189 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 193 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 1 250 0 22 0 31 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 1 254 0 22 0 191 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 201 0 62 4 201 0 63 4 201 0 64 4 201 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 254 0 122 0 195 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 205 0 62 4 205 0 63 4 205 0 64 4 205 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 2 2 0 22 0 28 0 31 0 122 0 123] 
#[1 0 69 0 4 2 37 0 25 0 33 0 37 4 209 0 68 4 209 0 71 4 209 0 76 4 209 0 79 3 133 0 110 0 69 0 111 0 73 0 112 3 137 0 113 0 69 0 121] 
#[0 2 6 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 2 10 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 2 14 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 2 18 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 1 121 0 17 2 22 0 21 2 22 0 22 2 22 0 26 2 22 0 28 2 22 0 31 2 22 0 38 2 22 0 122 2 22 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 4 213 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 217 0 74 4 221 0 75 0 225 0 77 3 153 0 78 0 225 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 225 0 106 0 225 0 107 0 225 0 108 0 225 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 2 26 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 225 0 77 3 153 0 78 4 225 0 80 4 225 0 81 4 225 0 82 4 225 0 85 4 225 0 91 4 225 0 92 4 225 0 93 4 225 0 94 4 225 0 97 4 225 0 100 4 225 0 101 4 225 0 102 4 225 0 103 1 29 0 104 4 225 0 106 4 225 0 107 4 225 0 108 4 225 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 2 30 0 21 2 30 0 22 2 30 0 25 2 30 0 26 2 30 0 28 0 199 0 31 2 30 0 38 2 30 0 122 2 30 0 123] 
#[0 0 158 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 0 162 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 2 34 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 2 38 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 2 42 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 2 22 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 229 0 63 4 229 0 64 4 229 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 2 46 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 4 233 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 4 237 0 63 4 237 0 64 4 237 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 4 241 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 4 245 0 11 4 249 0 18 0 6 0 19 0 137 0 20 2 50 0 21 4 253 0 25 5 1 0 26 5 5 0 28 0 161 0 36 5 13 0 91 5 13 0 92 5 13 0 93 5 13 0 94 5 13 0 96 5 13 0 97 5 13 0 100 5 13 0 101 5 13 0 102 5 13 0 103 1 29 0 104 5 17 0 105 1 53 0 114 5 21 0 123] 
#[0 2 54 0 22 0 31 0 122 0 123] 
#[1 5 25 0 31 2 58 0 122] 
#[0 2 62 0 122] 
#[0 0 203 0 22 0 31 0 122 0 123] 
#[0 2 66 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 29 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 0 207 0 22 0 31 0 122 0 123] 
#[0 1 150 0 4 0 37] 
#[0 1 146 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 69 0 4 5 33 0 6 5 37 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 3 241 0 58 3 241 0 80 3 241 0 106 3 241 0 107 3 241 0 108 3 241 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 2 70 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 69 0 4 5 41 0 6 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 5 45 0 80 5 45 0 106 5 45 0 107 5 45 0 108 5 45 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 2 74 0 4 0 6 0 31 0 33 0 34 0 35 0 37] 
#[0 2 78 0 4 0 6 0 31 0 33 0 34 0 35 0 37] 
#[1 1 166 0 14 1 166 0 31 5 49 0 49] 
#[1 1 166 0 14 1 166 0 31 5 53 0 49] 
#[1 5 57 0 14 5 61 0 31 5 65 0 48] 
#[1 5 69 0 14 5 61 0 31 5 65 0 48] 
#[0 5 73 0 23] 
#[0 2 82 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 5 77 0 28 5 81 0 31 5 85 0 83] 
#[1 5 89 0 22 5 93 0 31 5 97 0 86] 
#[1 5 101 0 6 5 105 0 31 5 109 0 89] 
#[1 1 178 0 6 1 182 0 22 0 151 0 31 5 113 0 87 4 25 0 90] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 97 0 6 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 141 0 28 0 67 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 2 105 0 55 5 117 0 56 2 209 0 57 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 2 109 0 118 0 69 0 121 0 59 0 123] 
#[1 5 121 0 22 5 125 0 31 5 129 0 123] 
#[1 5 133 0 22 5 137 0 31 5 141 0 123] 
#[0 2 86 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 5 145 0 22] 
#[0 2 90 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 141 0 28 0 115 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 3 73 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 3 77 0 118 0 69 0 121 0 59 0 123] 
#[0 2 94 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 2 98 0 22 0 31 0 122 0 123] 
#[0 5 149 0 17] 
#[0 2 102 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 17 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 153 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 5 157 0 54 0 102 0 122 0 102 0 123] 
#[0 2 106 0 31 0 122] 
#[1 0 95 0 1 0 95 0 2 0 95 0 3 0 95 0 4 0 95 0 7 0 95 0 8 0 95 0 9 0 95 0 10 0 95 0 12 0 121 0 13 0 95 0 15 0 95 0 16 0 95 0 18 0 95 0 19 0 95 0 20 0 141 0 28 0 163 0 31 0 95 0 33 0 95 0 34 0 95 0 35 0 95 0 36 0 95 0 37 5 161 0 44 0 169 0 47 5 165 0 54 5 169 0 118 0 95 0 122 0 95 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 141 0 28 0 211 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 5 177 0 54 5 181 0 118 0 102 0 122 0 102 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 185 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 5 189 0 54 0 102 0 122 0 102 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 193 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 141 0 28 0 215 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 5 201 0 54 5 205 0 118 0 102 0 122 0 102 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 209 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 5 213 0 54 0 102 0 122 0 102 0 123] 
#[1 0 95 0 1 0 95 0 2 0 95 0 3 0 95 0 4 0 95 0 7 0 95 0 8 0 95 0 9 0 95 0 10 0 95 0 12 0 95 0 15 0 95 0 16 0 95 0 18 0 95 0 19 0 95 0 20 0 141 0 28 0 163 0 31 0 95 0 33 0 95 0 34 0 95 0 35 0 95 0 36 0 95 0 37 5 217 0 54 5 221 0 118 0 95 0 122 0 95 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 225 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 5 229 0 54 0 102 0 122 0 102 0 123] 
#[0 2 110 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 233 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 2 114 0 31 0 122] 
#[0 2 118 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 2 122 0 22 0 31 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 141 0 28 0 219 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 241 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 5 245 0 118 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 2 126 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 223 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 5 253 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 22 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 1 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 0 59 0 123] 
#[0 2 130 0 22 0 31 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 5 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 2 134 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 227 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 13 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 17 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 2 138 0 31 0 122] 
#[0 2 142 0 22 0 31 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 21 0 62 6 21 0 63 6 21 0 64 6 21 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 2 146 0 22 0 28 0 31 0 122 0 123] 
#[0 2 150 0 22 0 28 0 31 0 122 0 123] 
#[0 2 154 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 25 0 74 4 221 0 75 0 225 0 77 3 153 0 78 0 225 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 225 0 106 0 225 0 107 0 225 0 108 0 225 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 2 158 0 21 2 158 0 22 2 37 0 25 2 158 0 26 2 158 0 28 0 231 0 31 2 158 0 38 6 33 0 73 2 45 0 76 2 158 0 122 2 158 0 123] 
#[0 0 150 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 2 162 0 21 2 162 0 22 2 162 0 25 2 162 0 26 2 162 0 28 0 235 0 31 2 162 0 38 2 162 0 122 2 162 0 123] 
#[0 2 166 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 37 0 63 6 37 0 64 6 37 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 2 170 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[0 2 174 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[0 2 178 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[1 1 114 0 1 1 114 0 2 1 114 0 3 1 114 0 4 1 114 0 7 1 114 0 8 1 114 0 9 1 114 0 10 1 114 0 11 1 114 0 18 1 114 0 19 1 114 0 20 1 114 0 21 1 114 0 25 1 114 0 26 1 114 0 28 1 114 0 36 6 41 0 95 1 114 0 123] 
#[0 2 182 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[0 2 186 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[0 2 190 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[0 2 194 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[0 2 198 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[0 6 45 0 21] 
#[0 2 202 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[0 2 206 0 122] 
#[0 0 239 0 22 0 31 0 122 0 123] 
#[0 2 210 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 69 0 4 6 49 0 6 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 5 45 0 80 5 45 0 106 5 45 0 107 5 45 0 108 5 45 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 2 214 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 2 218 0 4 0 6 0 31 0 33 0 34 0 35 0 37] 
#[1 6 53 0 14 5 61 0 31 5 65 0 48] 
#[1 6 57 0 14 5 61 0 31 5 65 0 48] 
#[0 2 222 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 69 0 4 0 33 0 37 1 105 0 110 0 69 0 111 0 73 0 112 6 61 0 113 0 69 0 121] 
#[0 2 226 0 14 0 31] 
#[0 2 230 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 2 234 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 6 65 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 69 0 63 6 69 0 64 6 69 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 6 73 0 23] 
#[0 2 238 0 28 0 31] 
#[0 2 242 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 6 77 0 17 6 81 0 22] 
#[0 2 246 0 22 0 31] 
#[0 2 250 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 123] 
#[1 6 85 0 6 6 89 0 17] 
#[0 2 254 0 6 0 31] 
#[1 6 93 0 22 6 97 0 31 5 97 0 86] 
#[1 6 101 0 22 6 105 0 31 6 109 0 123] 
#[0 3 2 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 6 113 0 22] 
#[0 3 6 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 10 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 6 117 0 22] 
#[0 3 14 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 18 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 0 69 0 4 0 33 0 37 6 121 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 3 22 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 125 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 141 0 28 0 243 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 6 133 0 54 6 137 0 118 0 102 0 122 0 102 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 141 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 6 145 0 54 0 102 0 122 0 102 0 123] 
#[1 0 95 0 1 0 95 0 2 0 95 0 3 0 95 0 4 0 95 0 7 0 95 0 8 0 95 0 9 0 95 0 10 0 95 0 12 0 95 0 15 0 95 0 16 0 95 0 18 0 95 0 19 0 95 0 20 0 141 0 28 0 163 0 31 0 95 0 33 0 95 0 34 0 95 0 35 0 95 0 36 0 95 0 37 6 149 0 54 6 153 0 118 0 95 0 122 0 95 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 157 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 6 161 0 54 0 102 0 122 0 102 0 123] 
#[0 3 26 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 165 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 30 0 31 0 122] 
#[1 0 95 0 1 0 95 0 2 0 95 0 3 0 95 0 4 0 95 0 7 0 95 0 8 0 95 0 9 0 95 0 10 0 95 0 12 0 95 0 15 0 95 0 16 0 95 0 18 0 95 0 19 0 95 0 20 0 141 0 28 0 163 0 31 0 95 0 33 0 95 0 34 0 95 0 35 0 95 0 36 0 95 0 37 6 169 0 54 6 173 0 118 0 95 0 122 0 95 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 177 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 6 181 0 54 0 102 0 122 0 102 0 123] 
#[0 3 34 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 185 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 189 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 6 193 0 54 0 102 0 122 0 102 0 123] 
#[0 3 38 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 197 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 42 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 201 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 46 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 247 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 209 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 213 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 50 0 31 0 122] 
#[0 3 54 0 22 0 31 0 122 0 123] 
#[0 3 58 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 217 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 62 0 31 0 122] 
#[0 3 66 0 31 0 122] 
#[0 3 70 0 22 0 28 0 31 0 122 0 123] 
#[1 2 158 0 21 2 158 0 22 2 37 0 25 2 158 0 26 2 158 0 28 0 231 0 31 2 158 0 38 6 221 0 73 2 45 0 76 2 158 0 122 2 158 0 123] 
#[1 2 37 0 25 3 165 0 76] 
#[1 3 74 0 21 3 74 0 22 3 74 0 26 3 74 0 28 0 251 0 31 3 74 0 38 6 229 0 72 3 74 0 122 3 74 0 123] 
#[0 3 78 0 21 0 22 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 4 241 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 4 245 0 11 4 249 0 18 0 6 0 19 0 137 0 20 6 233 0 21 4 253 0 25 5 1 0 26 5 5 0 28 0 161 0 36 5 13 0 91 5 13 0 92 5 13 0 93 5 13 0 94 5 13 0 96 5 13 0 97 5 13 0 100 5 13 0 101 5 13 0 102 5 13 0 103 1 29 0 104 1 53 0 114 5 21 0 123] 
#[0 3 82 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 3 86 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 3 90 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[0 3 94 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 6 0 19 0 137 0 20 6 237 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 6 241 0 80 6 245 0 91 6 245 0 92 6 245 0 93 6 245 0 94 6 245 0 97 6 245 0 100 6 245 0 101 6 245 0 102 6 245 0 103 1 29 0 104 6 241 0 106 6 241 0 107 6 241 0 108 6 241 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121] 
#[0 6 249 0 23] 
#[0 3 98 0 28 0 31] 
#[0 3 102 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 0 69 0 4 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 6 253 0 80 6 253 0 106 6 253 0 107 6 253 0 108 6 253 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 3 106 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 110 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 31 0 33 0 34 0 35 0 36 0 37 0 123] 
#[1 0 69 0 4 0 149 0 33 0 153 0 34 0 157 0 35 0 33 0 37 7 1 0 80 7 1 0 106 7 1 0 107 7 1 0 108 7 1 0 109 1 49 0 110 0 69 0 111 0 73 0 112 0 69 0 121] 
#[0 3 114 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 6 77 0 17 7 5 0 22] 
#[0 3 118 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 7 9 0 22] 
#[0 3 122 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 126 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 130 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 134 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 17 0 18 0 19 0 20 0 21 0 22 0 25 0 26 0 28 0 31 0 36 0 38 0 122 0 123] 
#[0 3 138 0 31 0 122] 
#[1 0 95 0 1 0 95 0 2 0 95 0 3 0 95 0 4 0 95 0 7 0 95 0 8 0 95 0 9 0 95 0 10 0 95 0 12 0 95 0 15 0 95 0 16 0 95 0 18 0 95 0 19 0 95 0 20 0 141 0 28 0 163 0 31 0 95 0 33 0 95 0 34 0 95 0 35 0 95 0 36 0 95 0 37 7 13 0 54 7 17 0 118 0 95 0 122 0 95 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 21 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 7 25 0 54 0 102 0 122 0 102 0 123] 
#[0 3 142 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 29 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 33 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 7 37 0 54 0 102 0 122 0 102 0 123] 
#[0 3 146 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 41 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 150 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 45 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 7 49 0 54 0 102 0 122 0 102 0 123] 
#[0 3 154 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 53 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 158 0 31 0 122] 
#[0 3 162 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 57 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 166 0 31 0 122] 
#[0 3 170 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 61 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 174 0 31 0 122] 
#[0 3 178 0 31 0 122] 
#[0 3 182 0 31 0 122] 
#[1 3 186 0 21 3 186 0 22 3 186 0 26 3 186 0 28 0 255 0 31 3 186 0 38 6 229 0 72 3 186 0 122 3 186 0 123] 
#[1 0 69 0 4 0 33 0 37 1 105 0 110 0 69 0 111 0 73 0 112 7 65 0 113 0 69 0 121] 
#[0 3 190 0 21 0 22 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 194 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 36 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 69 0 80 7 73 0 91 7 73 0 92 7 73 0 93 7 73 0 94 7 73 0 97 7 73 0 100 7 73 0 101 7 73 0 102 7 73 0 103 1 29 0 104 7 69 0 106 7 69 0 107 7 69 0 108 7 69 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121] 
#[0 3 198 0 14 0 31] 
#[0 3 202 0 14 0 31] 
#[0 3 206 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 210 0 22 0 31] 
#[0 3 214 0 6 0 31] 
#[0 3 218 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[0 3 222 0 21 0 22 0 25 0 26 0 28 0 31 0 38 0 122 0 123] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 77 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[1 0 102 0 1 0 102 0 2 0 102 0 3 0 102 0 4 0 102 0 7 0 102 0 8 0 102 0 9 0 102 0 10 0 102 0 12 0 102 0 15 0 102 0 16 0 102 0 18 0 102 0 19 0 102 0 20 0 107 0 31 0 102 0 33 0 102 0 34 0 102 0 35 0 102 0 36 0 102 0 37 7 81 0 54 0 102 0 122 0 102 0 123] 
#[0 3 226 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 85 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 230 0 31 0 122] 
#[0 3 234 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 89 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 238 0 31 0 122] 
#[0 3 242 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 93 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 3 246 0 31 0 122] 
#[0 3 250 0 31 0 122] 
#[0 3 254 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 7 97 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 101 0 74 4 221 0 75 0 225 0 77 3 153 0 78 0 225 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 225 0 106 0 225 0 107 0 225 0 108 0 225 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[0 4 2 0 14 0 31] 
#[0 4 6 0 14 0 31] 
#[0 4 10 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 117 0 12 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 10 0 31 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 105 0 55 0 189 0 60 0 193 0 61 0 197 0 62 0 197 0 63 0 197 0 64 0 197 0 69 0 213 0 70 0 217 0 74 0 221 0 75 0 225 0 77 0 229 0 78 0 233 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 233 0 106 0 233 0 107 0 233 0 108 0 233 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 0 10 0 122 1 61 0 123] 
#[0 4 14 0 31 0 122] 
#[0 4 18 0 31 0 122] 
#[0 4 22 0 31 0 122] 
#[1 0 85 0 1 0 89 0 2 0 93 0 3 0 69 0 4 0 101 0 7 0 105 0 8 0 109 0 9 0 113 0 10 0 125 0 15 0 129 0 16 0 133 0 18 0 6 0 19 0 137 0 20 0 149 0 33 0 153 0 34 0 157 0 35 0 161 0 36 0 33 0 37 7 109 0 74 4 221 0 75 0 225 0 77 3 153 0 78 0 225 0 80 0 225 0 81 0 225 0 82 0 225 0 85 0 225 0 91 0 225 0 92 0 225 0 93 0 225 0 94 0 225 0 97 0 225 0 100 0 225 0 101 0 225 0 102 0 225 0 103 1 29 0 104 0 225 0 106 0 225 0 107 0 225 0 108 0 225 0 109 1 49 0 110 0 69 0 111 0 73 0 112 1 53 0 114 0 69 0 121 1 61 0 123] 
#[1 4 26 0 21 4 26 0 22 2 37 0 25 4 26 0 26 4 26 0 28 1 3 0 31 4 26 0 38 2 45 0 76 4 26 0 122 4 26 0 123] 
#[0 4 30 0 31 0 122] 
#[1 4 34 0 21 4 34 0 22 2 37 0 25 4 34 0 26 4 34 0 28 1 7 0 31 4 34 0 38 2 45 0 76 4 34 0 122 4 34 0 123]
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
	result rightBrace: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArray2: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addToken: (nodes at: 3) to: result periods.
	result rightBrace: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArray3: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addNode: (nodes at: 3) to: result values.
	result addTokens: ((nodes at: 4) at: 1) to: result periods.
	result addNodes: ((nodes at: 4) at: 2) to: result values.
	result rightBrace: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForArray4: nodes [
	| result |
	result := GtPharoArrayNode new.
	result leftBrace: (nodes at: 1).
	result addNode: (nodes at: 3) to: result values.
	result addTokens: ((nodes at: 4) at: 1) to: result periods.
	result addNodes: ((nodes at: 4) at: 2) to: result values.
	result addToken: (nodes at: 5) to: result periods.
	result rightBrace: (nodes at: 7).
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
GtPharoTemplateParser >> reduceActionForAssignment2: nodes [
	| result |
	result := GtPharoAssignmentNode new.
	result variable: (nodes at: 1).
	result assignmentToken: (nodes at: 2).
	result value: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForAssignment3: nodes [
	| result |
	result := GtPharoAssignmentNode new.
	result variable: (nodes at: 1).
	result assignmentToken: (nodes at: 3).
	result value: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForAssignment4: nodes [
	| result |
	result := GtPharoAssignmentNode new.
	result variable: (nodes at: 1).
	result assignmentToken: (nodes at: 3).
	result value: (nodes at: 5).
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
GtPharoTemplateParser >> reduceActionForBinaryMessage2: nodes [
	| result |
	result := GtPharoBinaryMessageNode new.
	result selectorPart: (nodes at: 1).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock10: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addToken: (nodes at: 2) to: result colons.
	result addNode: (nodes at: 3) to: result variables.
	result addTokens: ((nodes at: 4) at: 1) to: result colons.
	result addNodes: ((nodes at: 4) at: 2) to: result variables.
	result rightBracket: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock11: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addToken: (nodes at: 3) to: result colons.
	result addNode: (nodes at: 4) to: result variables.
	result addTokens: ((nodes at: 5) at: 1) to: result colons.
	result addNodes: ((nodes at: 5) at: 2) to: result variables.
	result rightBracket: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock12: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addToken: (nodes at: 3) to: result colons.
	result addNode: (nodes at: 4) to: result variables.
	result addTokens: ((nodes at: 5) at: 1) to: result colons.
	result addNodes: ((nodes at: 5) at: 2) to: result variables.
	result rightBracket: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock13: nodes [
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
GtPharoTemplateParser >> reduceActionForBlock14: nodes [
	| result |
	result := GtPharoBlockErrorNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 4).
	result smaccError: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock15: nodes [
	| result |
	result := GtPharoBlockErrorNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 3) at: 1) to: result colons.
	result addNodes: ((nodes at: 3) at: 2) to: result variables.
	result bar: ((nodes at: 3) at: 3).
	result body: (nodes at: 4).
	result smaccError: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock16: nodes [
	| result |
	result := GtPharoBlockErrorNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 3) at: 1) to: result colons.
	result addNodes: ((nodes at: 3) at: 2) to: result variables.
	result bar: ((nodes at: 3) at: 3).
	result body: (nodes at: 5).
	result smaccError: (nodes at: 6).
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
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 3).
	result rightBracket: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock3: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 4).
	result rightBracket: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock4: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 2) at: 1) to: result colons.
	result addNodes: ((nodes at: 2) at: 2) to: result variables.
	result bar: ((nodes at: 2) at: 3).
	result body: (nodes at: 4).
	result rightBracket: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock5: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 3) at: 1) to: result colons.
	result addNodes: ((nodes at: 3) at: 2) to: result variables.
	result bar: ((nodes at: 3) at: 3).
	result body: (nodes at: 4).
	result rightBracket: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock6: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 3) at: 1) to: result colons.
	result addNodes: ((nodes at: 3) at: 2) to: result variables.
	result bar: ((nodes at: 3) at: 3).
	result body: (nodes at: 4).
	result rightBracket: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock7: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 3) at: 1) to: result colons.
	result addNodes: ((nodes at: 3) at: 2) to: result variables.
	result bar: ((nodes at: 3) at: 3).
	result body: (nodes at: 5).
	result rightBracket: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock8: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addTokens: ((nodes at: 3) at: 1) to: result colons.
	result addNodes: ((nodes at: 3) at: 2) to: result variables.
	result bar: ((nodes at: 3) at: 3).
	result body: (nodes at: 5).
	result rightBracket: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlock9: nodes [
	| result |
	result := GtPharoBlockNode new.
	result leftBracket: (nodes at: 1).
	result addToken: (nodes at: 2) to: result colons.
	result addNode: (nodes at: 3) to: result variables.
	result addTokens: ((nodes at: 4) at: 1) to: result colons.
	result addNodes: ((nodes at: 4) at: 2) to: result variables.
	result rightBracket: (nodes at: 5).
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
	self add: (nodes at: 1) to: (result at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	self addAll: ((nodes at: 3) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 3) at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForBlockArgs3: nodes [
	| result |
	result := Array new: 3.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	self addAll: ((nodes at: 3) at: 1) to: (result at: 1).
	self addAll: ((nodes at: 3) at: 2) to: (result at: 2).
	result at: 3 put: (nodes at: 5).
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
GtPharoTemplateParser >> reduceActionForByteArrayLiteralValue__value__1: nodes [
	| result |
	result := OrderedCollection new: 2.
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
GtPharoTemplateParser >> reduceActionForKeyword1: nodes [
	| result |
	result := GtPharoKeywordNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result addObject: (nodes at: 2) to: result selectorParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForKeywordMessage1: nodes [
	| result |
	result := GtPharoKeywordMessageNode new.
	result addNode: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result values.
	result addNodes: ((nodes at: 3) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 3) at: 2) to: result values.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForKeywordMessage2: nodes [
	| result |
	result := GtPharoKeywordMessageNode new.
	result addNode: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 3) to: result values.
	result addNodes: ((nodes at: 4) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 4) at: 2) to: result values.
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
GtPharoTemplateParser >> reduceActionForMethod3: nodes [
	| result |
	result := GtPharoMethodNode new.
	result pattern: (nodes at: 1).
	result body: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethod5: nodes [
	| result |
	result := GtPharoMethodNode new.
	result pattern: (nodes at: 2).
	result body: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethod7: nodes [
	| result |
	result := GtPharoMethodNode new.
	result pattern: (nodes at: 2).
	result body: (nodes at: 4).
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
GtPharoTemplateParser >> reduceActionForMethodPattern2: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern3: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 3) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern4: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern5: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodPattern7: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addObject: (nodes at: 2) to: result selectorParts.
	result smaccError: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence10: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: (nodes at: 4) to: result pragmas.
	result addObject: (nodes at: 5) to: result periods.
	result addNodes: ((nodes at: 7) at: 1) to: result statements.
	result addObjects: ((nodes at: 7) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence11: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: (nodes at: 4) to: result pragmas.
	result addNodes: ((nodes at: 7) at: 1) to: result statements.
	result addObjects: ((nodes at: 7) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence12: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: (nodes at: 4) to: result pragmas.
	result addObject: (nodes at: 6) to: result periods.
	result addNodes: ((nodes at: 8) at: 1) to: result statements.
	result addObjects: ((nodes at: 8) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence13: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: (nodes at: 5) to: result pragmas.
	result addNodes: ((nodes at: 7) at: 1) to: result statements.
	result addObjects: ((nodes at: 7) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence14: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: (nodes at: 5) to: result pragmas.
	result addObject: (nodes at: 6) to: result periods.
	result addNodes: ((nodes at: 8) at: 1) to: result statements.
	result addObjects: ((nodes at: 8) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence15: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: (nodes at: 5) to: result pragmas.
	result addNodes: ((nodes at: 8) at: 1) to: result statements.
	result addObjects: ((nodes at: 8) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence16: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: (nodes at: 5) to: result pragmas.
	result addObject: (nodes at: 7) to: result periods.
	result addNodes: ((nodes at: 9) at: 1) to: result statements.
	result addObjects: ((nodes at: 9) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence17: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 2) to: result pragmas.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence18: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 2) to: result pragmas.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence19: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 2) to: result pragmas.
	result addObject: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence1: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence20: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 2) to: result pragmas.
	result addObject: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence22: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 2) to: result pragmas.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence23: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 2) to: result pragmas.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence24: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 2) to: result pragmas.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence25: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence26: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence27: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence28: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence2: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence30: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence31: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addObject: (nodes at: 5) to: result periods.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence32: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addObject: (nodes at: 5) to: result periods.
	result addNodes: ((nodes at: 7) at: 1) to: result statements.
	result addObjects: ((nodes at: 7) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence33: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence34: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addObject: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence35: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence36: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addObject: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence37: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence38: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addObject: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence39: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence3: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence40: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence43: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence44: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence45: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence46: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addObject: (nodes at: 4) to: result periods.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence47: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence48: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addObject: (nodes at: 5) to: result periods.
	result addNodes: ((nodes at: 7) at: 1) to: result statements.
	result addObjects: ((nodes at: 7) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence4: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: (nodes at: 3) to: result pragmas.
	result addObject: (nodes at: 5) to: result periods.
	result addNodes: ((nodes at: 7) at: 1) to: result statements.
	result addObjects: ((nodes at: 7) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence5: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: (nodes at: 4) to: result pragmas.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence6: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: (nodes at: 4) to: result pragmas.
	result addObject: (nodes at: 5) to: result periods.
	result addNodes: ((nodes at: 7) at: 1) to: result statements.
	result addObjects: ((nodes at: 7) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence7: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: (nodes at: 4) to: result pragmas.
	result addNodes: ((nodes at: 7) at: 1) to: result statements.
	result addObjects: ((nodes at: 7) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence8: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 2) at: 1).
	result rightBar: ((nodes at: 2) at: 2).
	result addNodes: ((nodes at: 2) at: 3) to: result variables.
	result addNodes: (nodes at: 4) to: result pragmas.
	result addObject: (nodes at: 6) to: result periods.
	result addNodes: ((nodes at: 8) at: 1) to: result statements.
	result addObjects: ((nodes at: 8) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForMethodSequence9: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result leftBar: ((nodes at: 3) at: 1).
	result rightBar: ((nodes at: 3) at: 2).
	result addNodes: ((nodes at: 3) at: 3) to: result variables.
	result addNodes: (nodes at: 4) to: result pragmas.
	result addNodes: ((nodes at: 6) at: 1) to: result statements.
	result addObjects: ((nodes at: 6) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForName1: nodes [
	| result |
	result := GtPharoNameNode new.
	result addObjects: (nodes at: 1) to: result nameParts.
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
	result addNode: (nodes at: 2) to: result selectorParts.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma3: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addNode: (nodes at: 2) to: result selectorParts.
	result addNode: (nodes at: 3) to: result values.
	result addNodes: ((nodes at: 4) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 4) at: 2) to: result values.
	result greaterThan: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma5: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addNode: (nodes at: 2) to: result selectorParts.
	result addNode: (nodes at: 4) to: result values.
	result addNodes: ((nodes at: 5) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 5) at: 2) to: result values.
	result greaterThan: (nodes at: 6).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma6: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragma7: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForPragmas1: nodes [
	| result |
	result := nodes at: 2.
	self addFirst: (nodes at: 1) to: result.
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
GtPharoTemplateParser >> reduceActionForSequence10: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence11: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addObject: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence12: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addObject: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence14: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence15: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addObject: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence16: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addObject: (nodes at: 3) to: result periods.
	result addNodes: ((nodes at: 5) at: 1) to: result statements.
	result addObjects: ((nodes at: 5) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence1: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result statements.
	result addObjects: ((nodes at: 1) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence2: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addObjects: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence3: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addObject: (nodes at: 1) to: result periods.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addObjects: ((nodes at: 2) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence4: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addObject: (nodes at: 1) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence6: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence7: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addObject: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addObjects: ((nodes at: 3) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence8: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addObject: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 4) at: 1) to: result statements.
	result addObjects: ((nodes at: 4) at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSequence9: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result rightBar: ((nodes at: 1) at: 2).
	result addNodes: ((nodes at: 1) at: 3) to: result variables.
	result addNodes: ((nodes at: 2) at: 1) to: result statements.
	result addObjects: ((nodes at: 2) at: 2) to: result periods.
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
GtPharoTemplateParser >> reduceActionForStatement2: nodes [
	| result |
	result := GtPharoReturnNode new.
	result upArrow: (nodes at: 1).
	result value: (nodes at: 3).
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
	self add: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatementList3: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 4) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatementList4: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 3) to: (result at: 2).
	self add: (nodes at: 4) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatementList5: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 3) to: (result at: 2).
	self add: (nodes at: 5) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatements2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatements4: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 3) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForStatements_1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
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
GtPharoTemplateParser >> reduceActionForSymbol1: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObject: (nodes at: 2) to: result symbolParts.
	result addObjects: (nodes at: 3) to: result symbolParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSymbol3: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObjects: (nodes at: 2) to: result symbolParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForSymbol4: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObject: (nodes at: 2) to: result symbolParts.
	^ result
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
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForTemporaries2: nodes [
	| result |
	result := Array new: 3.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForTemporaries3: nodes [
	| result |
	result := Array new: 3.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 3).
	self addAll: (nodes at: 3) to: (result at: 3).
	result at: 2 put: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForTemporaries4: nodes [
	| result |
	result := Array new: 3.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 2) to: (result at: 3).
	self addAll: (nodes at: 3) to: (result at: 3).
	result at: 2 put: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForTemporaries5: nodes [
	| result |
	result := Array new: 3.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 3) to: (result at: 3).
	self addAll: (nodes at: 4) to: (result at: 3).
	result at: 2 put: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionForTemporaries6: nodes [
	| result |
	result := Array new: 3.
	result at: 3 put: (OrderedCollection new: 2).
	result at: 1 put: (nodes at: 1).
	self add: (nodes at: 3) to: (result at: 3).
	self addAll: (nodes at: 4) to: (result at: 3).
	result at: 2 put: (nodes at: 6).
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
GtPharoTemplateParser >> reduceActionFor_Keyword__selectorPart___space__Variable__variable___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor_Keyword__selectorPart___space__Variable__variable___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor_Keyword__selectorPart___space___Variable__variable__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor_Keyword__selectorPart___space___Variable__variable__2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	self add: (nodes at: 2) to: result.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart___2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__name___namePart___Template__namePart___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__name___namePart___Template__namePart___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 2).
	result at: 2 put: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoTemplateParser >> reduceActionFor__space__Keyword__selectorPart___space___Literal__value____Variable__value___4: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 2).
	result at: 2 put: (nodes at: 4).
	^ result
]

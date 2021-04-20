Class {
	#name : #GtPharoParser,
	#superclass : #SmaCCGLRParser,
	#category : #'GToolkit-Pharo-Parser'
}

{ #category : #generated }
GtPharoParser class >> ambiguousTransitions [
^#(
#[ 0 21 0 22] 
#[ 0 34 1 77] 
#[ 0 21 0 150] 
#[ 0 234 1 37] 
#[ 0 10 1 37] 
#[ 1 54 1 73] 
#[ 0 21 1 62] 
#[ 1 37 1 90] 
#[ 1 37 1 94] 
#[ 0 110 1 37] 
#[ 0 21 2 34]
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> cacheId [
	^'2021-04-18T11:02:22.838088+02:00'
]

{ #category : #generated }
GtPharoParser class >> definitionComment [
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
<symbolHash>
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
	: <name> 'namePart' + {{}}
	;
Keyword
	: Name 'selectorPart'<colon> 'selectorPart' {{}}
	;
Symbol
	: <symbolHash> 'hash'( Name 'symbolPart'(<colon>'symbolPart'<colon> 'symbolPart'Name'symbolPart')* | <binary> 'symbolPart'| Keyword'symbolPart'+ | <string> 'symbolPart') {{}}
	;
Period
	: <period> 'period' +
	;"
]

{ #category : #generated }
GtPharoParser class >> reduceTable [
^#(
	#(93 0 #reduceActionForSwitchToLiteralArray1: 7040001 false ) 
	#(48 0 #reduceActionForSequence1: 3590145 false ) 
	#(100 1 #reduceActionFor_name___namePart___1: 7334913 false ) 
	#(40 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 2849793 false ) 
	#(46 1 #reduceActionForKeywordPattern1: 3306497 false ) 
	#(38 1 #reduceActionForMethodPattern3: 2598915 false ) 
	#(38 1 #reduceActionForMethodPattern1: 2598913 false ) 
	#(99 1 #reduceActionForName1: 7326721 false ) 
	#(91 1 #reduceActionForBooleanLiteral1: 6936577 false ) 
	#(91 1 #reduceActionForBooleanLiteral1: 6936578 false ) 
	#(92 1 #reduceActionForNilLiteral1: 7003137 false ) 
	#(50 0 #reduceActionForVariable__variable__1: 3686401 false ) 
	#(81 1 #reduceActionForStringLiteral1: 6008833 false ) 
	#(89 1 #reduceActionForCharacterLiteral1: 6846465 false ) 
	#(82 1 #reduceActionForNumberLiteral1: 6051841 false ) 
	#(82 1 #reduceActionForNumberLiteral1: 6051842 false ) 
	#(79 0 #reduceActionForBlockArgs1: 5782529 false ) 
	#(87 0 #reduceActionForVariable__variable__1: 6703105 false ) 
	#(107 1 #liftFirstValue: 7626753 false ) 
	#(95 1 #reduceActionForSelfVariable1: 7155713 false ) 
	#(96 1 #reduceActionForSuperVariable1: 7194625 false ) 
	#(98 1 #reduceActionForThisContextVariable1: 7273473 false ) 
	#(47 1 #reduceActionForMethodSequence9: 3375113 false ) 
	#(41 1 #reduceActionForKeywordPattern1: 2960385 false ) 
	#(42 1 #reduceActionFor_name___namePart___1: 2971649 false ) 
	#(47 1 #liftFirstValue: 3375121 false ) 
	#(48 1 #reduceActionForSequence5: 3590149 false ) 
	#(48 1 #reduceActionForSequence2: 3590146 false ) 
	#(51 1 #reduceActionForKeywordPattern1: 3728385 false ) 
	#(52 1 #reduceActionForStatementList1: 3777537 false ) 
	#(53 1 #liftFirstValue: 3876866 false ) 
	#(54 1 #liftFirstValue: 3957762 false ) 
	#(55 1 #liftFirstValue: 4059140 false ) 
	#(60 1 #reduceActionForKeywordMessageSend1: 4386817 false ) 
	#(60 1 #liftFirstValue: 4386818 false ) 
	#(65 1 #reduceActionForKeywordMessageSend1: 4639745 false ) 
	#(65 1 #liftFirstValue: 4639746 false ) 
	#(68 1 #reduceActionForKeywordMessageSend1: 4883457 false ) 
	#(72 1 #liftFirstValue: 5167105 false ) 
	#(68 1 #liftFirstValue: 4883458 false ) 
	#(72 1 #liftFirstValue: 5167107 false ) 
	#(72 1 #liftFirstValue: 5167108 false ) 
	#(72 1 #liftFirstValue: 5167106 false ) 
	#(80 1 #liftFirstValue: 5855233 false ) 
	#(80 1 #liftFirstValue: 5855234 false ) 
	#(80 1 #liftFirstValue: 5855235 false ) 
	#(80 1 #liftFirstValue: 5855236 false ) 
	#(80 1 #liftFirstValue: 5855237 false ) 
	#(80 1 #liftFirstValue: 5855238 false ) 
	#(80 1 #liftFirstValue: 5855239 false ) 
	#(80 1 #liftFirstValue: 5855240 false ) 
	#(71 1 #liftFirstValue: 5080065 false ) 
	#(71 1 #liftFirstValue: 5080066 false ) 
	#(71 1 #liftFirstValue: 5080068 false ) 
	#(71 1 #liftFirstValue: 5080067 false ) 
	#(97 1 #reduceActionForNamedVariable1: 7235585 false ) 
	#(90 1 #reduceActionForSymbolLiteral1: 6895617 false ) 
	#(48 1 #reduceActionForSequence3: 3590147 false ) 
	#(106 1 #liftFirstValue: 7616513 false ) 
	#(72 1 #reduceActionForValue6: 5167110 false ) 
	#(38 2 #reduceActionForMethodPattern2: 2598914 false ) 
	#(38 2 #reduceActionForMethodPattern4: 2598916 false ) 
	#(37 2 #reduceActionForMethod1: 2533377 false ) 
	#(40 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 2849794 false ) 
	#(101 2 #reduceActionForKeyword1: 7363585 false ) 
	#(100 2 #reduceActionFor_name___namePart___2: 7334914 false ) 
	#(39 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 2849793 false ) 
	#(38 2 #reduceActionForMethodPattern4: 2598917 false ) 
	#(53 2 #reduceActionForStatement1: 3876865 false ) 
	#(45 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 3084289 false ) 
	#(43 2 #reduceActionForPragma3: 2992131 false ) 
	#(73 2 #reduceActionForArray1: 5326849 false ) 
	#(75 0 #reduceActionFor__period___period__Assignment__value___1: 5381121 false ) 
	#(78 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 5610497 false ) 
	#(102 2 #reduceActionForSymbol4: 7426052 false ) 
	#(102 2 #reduceActionForSymbol4: 7426050 false ) 
	#(104 0 #reduceActionForVariable__variable__1: 7475201 false ) 
	#(105 1 #reduceActionFor_name___namePart___1: 7561217 false ) 
	#(102 2 #reduceActionForSymbol3: 7426051 false ) 
	#(47 2 #reduceActionForMethodSequence13: 3375117 false ) 
	#(47 2 #reduceActionForMethodSequence10: 3375114 false ) 
	#(47 2 #reduceActionForMethodSequence11: 3375115 false ) 
	#(42 2 #reduceActionFor_name___namePart___2: 2971650 false ) 
	#(47 2 #reduceActionForMethodSequence5: 3375109 false ) 
	#(48 2 #reduceActionForSequence6: 3590150 false ) 
	#(48 2 #reduceActionForSequence7: 3590151 false ) 
	#(51 2 #reduceActionForStatements2: 3728386 false ) 
	#(55 2 #reduceActionForCascade1: 4059137 false ) 
	#(58 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 4257793 false ) 
	#(56 1 #reduceActionForKeywordPattern1: 4237313 false ) 
	#(61 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4473857 false ) 
	#(64 1 #reduceActionFor_Keyword__selectorPart__Variable__variable___1: 4578305 false ) 
	#(62 1 #reduceActionForKeywordMessage1: 4559873 false ) 
	#(66 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4723713 false ) 
	#(55 2 #reduceActionForCascade1: 4059138 false ) 
	#(69 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4954113 false ) 
	#(70 1 #reduceActionForUnaryMessage1: 5035009 false ) 
	#(55 2 #reduceActionForCascade1: 4059139 false ) 
	#(84 0 #reduceActionForVariable__variable__1: 6200321 false ) 
	#(48 2 #reduceActionForSequence4: 3590148 false ) 
	#(107 2 #liftFirstValue: 7626754 false ) 
	#(38 3 #reduceActionForMethodPattern6: 2598918 false ) 
	#(49 3 #reduceActionForTemporaries1: 3653633 false ) 
	#(50 2 #reduceActionFor_name___namePart___2: 3686402 false ) 
	#(43 3 #reduceActionForPragma2: 2992130 false ) 
	#(45 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 3084290 false ) 
	#(43 3 #reduceActionForPragma1: 2992129 false ) 
	#(44 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 3084290 false ) 
	#(44 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 3084289 false ) 
	#(43 3 #reduceActionForPragma4: 2992132 false ) 
	#(73 3 #reduceActionForArray2: 5326850 false ) 
	#(77 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 5610497 false ) 
	#(79 2 #reduceActionForBlockArgs2: 5782530 false ) 
	#(76 3 #reduceActionForBlock2: 5478402 false ) 
	#(78 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 5610498 false ) 
	#(72 3 #reduceActionForValue5: 5167109 false ) 
	#(86 3 #reduceActionForByteArrayLiteral1: 6651905 false ) 
	#(88 1 #liftFirstValue: 6770689 false ) 
	#(87 2 #reduceActionFor_name___namePart___2: 6703106 false ) 
	#(88 1 #reduceActionForValue6: 6770690 false ) 
	#(102 3 #reduceActionForSymbol1: 7426049 false ) 
	#(105 2 #reduceActionFor_name___namePart___2: 7561218 false ) 
	#(47 3 #reduceActionForMethodSequence1: 3375105 false ) 
	#(47 3 #reduceActionForMethodSequence14: 3375118 false ) 
	#(47 3 #reduceActionForMethodSequence15: 3375119 false ) 
	#(47 3 #reduceActionForMethodSequence12: 3375116 false ) 
	#(47 3 #reduceActionForMethodSequence6: 3375110 false ) 
	#(47 3 #reduceActionForMethodSequence7: 3375111 false ) 
	#(48 3 #reduceActionForSequence8: 3590152 false ) 
	#(52 3 #reduceActionForStatementList2: 3777538 false ) 
	#(57 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4257793 false ) 
	#(59 1 #liftFirstValue: 4315137 false ) 
	#(59 1 #liftFirstValue: 4315138 false ) 
	#(59 1 #liftFirstValue: 4315139 false ) 
	#(58 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 4257794 false ) 
	#(67 2 #reduceActionForBinaryMessage1: 4807681 false ) 
	#(64 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 4578306 false ) 
	#(63 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 4578305 false ) 
	#(54 3 #reduceActionForAssignment1: 3957761 false ) 
	#(94 0 #reduceActionForEndLiteralArray1: 7104513 false ) 
	#(73 4 #reduceActionForArray3: 5326851 false ) 
	#(75 2 #reduceActionFor_Keyword__selectorPart__Variable__variable___2: 5381122 false ) 
	#(76 4 #reduceActionForBlock1: 5478401 false ) 
	#(76 4 #reduceActionForBlock3: 5478403 false ) 
	#(104 2 #reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart___2: 7475202 false ) 
	#(47 4 #reduceActionForMethodSequence2: 3375106 false ) 
	#(47 4 #reduceActionForMethodSequence3: 3375107 false ) 
	#(47 4 #reduceActionForMethodSequence16: 3375120 false ) 
	#(47 4 #reduceActionForMethodSequence8: 3375112 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6278147 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6278146 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6278148 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6278150 false ) 
	#(85 1 #reduceActionForSymbolLiteral1: 6278149 false ) 
	#(85 1 #liftFirstValue: 6278145 false ) 
	#(84 2 #reduceActionFor_name___namePart___2: 6200322 false ) 
	#(85 1 #reduceActionForValue6: 6278152 false ) 
	#(73 5 #reduceActionForArray4: 5326852 false ) 
	#(74 2 #reduceActionFor_Keyword__selectorPart__Variable__variable__1: 5381121 false ) 
	#(47 5 #reduceActionForMethodSequence4: 3375108 false ) 
	#(83 5 #reduceActionForArrayLiteral1: 6128641 false ) 
	#(103 3 #reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart__1: 7475201 false ) 
	#(85 3 #reduceActionForArrayLiteralValue7: 6278151 false )
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> scannerClass [
	^GtPharoScanner
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
GtPharoParser class >> startingStateForStatement [
	^ 3
]

{ #category : #generated }
GtPharoParser class >> symbolNames [
	^ #('<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' '<self>' '<super>' '<thisContext>' '<symbolHash>' 'B e g i n' 'Method' 'MethodPattern' '(Keyword ''selectorPart'' Variable ''variable'')' '(Keyword ''selectorPart'' Variable ''variable'')+' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(Keyword ''selectorPart'' (Literal ''value'' | Variable ''value''))' '(Keyword ''selectorPart'' (Literal ''value'' | Variable ''value''))+' 'KeywordPattern' 'MethodSequence' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '(Keyword ''selectorPart'' BinaryMessageSend ''value'')' '(Keyword ''selectorPart'' BinaryMessageSend ''value'')+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'Variable' 'Value' 'Array' '(<period> ''period'' Assignment ''value'')' '(<period> ''period'' Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' 'SelfVariable' 'SuperVariable' 'NamedVariable' 'ThisContextVariable' 'Name' '<name> ''namePart'' +' 'Keyword' 'Symbol' '(<colon>''symbolPart''<colon> ''symbolPart''Name''symbolPart'')' '(<colon>''symbolPart''<colon> ''symbolPart''Name''symbolPart'')*' 'Keyword''symbolPart''+' 'Period' '<period> ''period'' +' 'E O F' 'error')
]

{ #category : #generated }
GtPharoParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoVariableNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #GtPharoSelfVariableNode #GtPharoSuperVariableNode #GtPharoNamedVariableNode #GtPharoThisContextVariableNode #GtPharoNameNode #OrderedCollection #GtPharoKeywordNode #GtPharoSymbolNode #OrderedCollection #OrderedCollection #OrderedCollection #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoParser class >> transitionTable [
^#(
#[1 0 21 0 4 0 25 0 25 0 29 0 37 0 33 0 38 0 37 0 39 0 41 0 40 0 45 0 46 0 49 0 99 0 53 0 100 0 57 0 101] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 73 0 6 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 97 0 13 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 0 137 0 41 0 141 0 42 0 145 0 43 0 149 0 47 0 149 0 48 0 157 0 49 0 161 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 29 0 106 1 33 0 107 0 10 0 108 1 37 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 1 41 0 53 1 41 0 54 1 41 0 55 1 41 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 37 0 109] 
#[1 0 21 0 4 0 25 0 25 1 45 0 38 0 37 0 39 0 41 0 40 0 45 0 46 0 49 0 99 0 53 0 100 0 57 0 101] 
#[0 0 14 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[1 0 21 0 4 0 121 0 32 0 125 0 33 0 129 0 34 1 49 0 71 1 49 0 95 1 49 0 96 1 49 0 97 1 49 0 98 1 21 0 99 0 53 0 100 1 53 0 109] 
#[0 0 0 0 108] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 73 0 6 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 97 0 13 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 0 137 0 41 0 141 0 42 0 145 0 43 1 57 0 47 1 57 0 48 0 157 0 49 0 161 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 29 0 106 1 33 0 107 0 10 0 108 1 37 0 109] 
#[0 0 18 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[1 0 22 0 1 0 22 0 2 0 22 0 3 0 7 0 4 0 22 0 6 0 22 0 7 0 22 0 8 0 22 0 9 0 22 0 10 0 22 0 12 0 22 0 13 0 22 0 15 0 22 0 16 0 22 0 18 0 22 0 19 0 22 0 20 0 22 0 28 0 22 0 32 0 22 0 33 0 22 0 34 0 22 0 35 1 61 0 39 1 65 0 99 0 53 0 100 1 69 0 101 0 22 0 108 0 22 0 109] 
#[0 0 26 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[1 0 30 0 1 0 30 0 2 0 30 0 3 0 30 0 4 0 30 0 6 0 30 0 7 0 30 0 8 0 30 0 9 0 30 0 10 0 30 0 12 0 30 0 13 0 30 0 15 0 30 0 16 1 73 0 17 0 30 0 18 0 30 0 19 0 30 0 20 0 30 0 28 0 30 0 32 0 30 0 33 0 30 0 34 0 30 0 35 0 30 0 108 0 30 0 109] 
#[1 0 34 0 1 0 34 0 2 0 34 0 3 0 11 0 4 0 34 0 6 0 34 0 7 0 34 0 8 0 34 0 9 0 34 0 10 0 34 0 11 0 34 0 12 0 34 0 13 0 34 0 14 0 34 0 15 0 34 0 16 0 34 0 17 0 34 0 18 0 34 0 19 0 34 0 20 0 34 0 21 0 34 0 22 0 34 0 23 0 34 0 25 0 34 0 26 0 34 0 27 0 34 0 28 0 34 0 32 0 34 0 33 0 34 0 34 0 34 0 35 0 34 0 108 0 34 0 109] 
#[1 0 21 0 4 0 121 0 32 0 125 0 33 0 129 0 34 1 81 0 71 1 81 0 95 1 81 0 96 1 81 0 97 1 81 0 98 1 21 0 99 0 53 0 100 1 85 0 109] 
#[0 0 38 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 42 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 46 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[1 0 50 0 4 0 50 0 6 0 50 0 32 0 50 0 33 0 50 0 34 1 89 0 50] 
#[0 0 54 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 58 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 62 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 66 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 1 93 0 54 1 93 0 55 1 93 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 37 0 109] 
#[1 0 21 0 4 1 97 0 44 1 101 0 45 1 105 0 99 0 53 0 100 1 109 0 101 1 113 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 117 0 23 1 121 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 1 125 0 54 1 125 0 55 1 125 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 37 0 109] 
#[1 0 70 0 1 0 70 0 2 0 70 0 3 0 70 0 4 0 70 0 6 0 70 0 7 0 70 0 8 0 70 0 9 0 70 0 10 0 70 0 12 0 70 0 15 0 70 0 16 1 129 0 17 0 70 0 18 0 70 0 19 0 70 0 20 0 70 0 22 0 70 0 28 0 70 0 32 0 70 0 33 0 70 0 34 0 70 0 35 1 133 0 77 1 137 0 78 1 141 0 79 0 70 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 1 145 0 54 1 145 0 55 1 145 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 37 0 109] 
#[1 0 74 0 9 0 74 0 10 0 74 0 22 1 149 0 87 0 74 0 109] 
#[0 0 78 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 82 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 86 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 90 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[1 0 21 0 4 1 153 0 7 1 157 0 25 1 161 0 99 0 53 0 100 1 165 0 101 1 169 0 105] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 73 0 6 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 1 173 0 49 1 177 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 181 0 106 1 33 0 107 0 94 0 108 1 37 0 109] 
#[1 0 98 0 1 0 98 0 2 0 98 0 3 0 98 0 4 0 98 0 6 0 98 0 7 0 98 0 8 0 98 0 9 0 98 0 10 0 98 0 12 0 97 0 13 0 98 0 15 0 98 0 16 0 98 0 18 0 98 0 19 0 98 0 20 0 98 0 28 0 98 0 32 0 98 0 33 0 98 0 34 0 98 0 35 1 185 0 43 0 98 0 108 0 98 0 109] 
#[0 0 102 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 0 0 108] 
#[0 0 106 0 108] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 97 0 13 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 1 189 0 41 0 141 0 42 0 145 0 43 1 193 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 197 0 106 1 33 0 107 0 110 0 108 1 37 0 109] 
#[0 0 114 0 22 0 108 0 109] 
#[1 0 118 0 22 1 33 0 28 1 201 0 106 1 33 0 107 0 118 0 108 0 118 0 109] 
#[0 0 122 0 22 0 28 0 108 0 109] 
#[0 0 126 0 22 0 28 0 108 0 109] 
#[0 0 130 0 21 0 22 0 23 0 28 0 108 0 109] 
#[0 0 134 0 21 0 22 0 23 0 28 0 108 0 109] 
#[1 0 138 0 21 0 138 0 22 0 138 0 23 1 205 0 26 0 138 0 28 1 209 0 56 1 213 0 57 1 217 0 58 0 138 0 108 0 138 0 109] 
#[1 0 21 0 4 0 142 0 21 0 142 0 22 0 142 0 23 1 221 0 25 0 142 0 28 1 225 0 62 1 229 0 63 1 233 0 64 1 237 0 67 1 65 0 99 0 53 0 100 1 241 0 101 0 142 0 108 0 142 0 109] 
#[1 0 146 0 4 0 146 0 21 0 146 0 22 0 146 0 23 0 146 0 25 1 205 0 26 0 146 0 28 1 245 0 56 1 213 0 57 1 217 0 58 0 146 0 108 0 146 0 109] 
#[1 0 15 0 4 0 150 0 21 0 150 0 22 0 150 0 23 0 150 0 25 0 150 0 26 0 150 0 28 1 249 0 70 1 253 0 99 0 53 0 100 0 150 0 108 0 150 0 109] 
#[1 0 154 0 4 0 154 0 21 0 154 0 22 0 154 0 23 0 154 0 25 1 205 0 26 0 154 0 28 2 1 0 56 1 213 0 57 1 217 0 58 0 154 0 108 0 154 0 109] 
#[1 0 158 0 4 0 158 0 21 0 158 0 22 0 158 0 23 0 158 0 25 2 5 0 27 0 158 0 28 0 158 0 108 0 158 0 109] 
#[0 0 162 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 0 166 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 0 170 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 0 174 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 0 178 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 182 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 186 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 190 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 194 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 198 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 202 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 0 206 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 2 9 0 19] 
#[0 0 210 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 214 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 218 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 222 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 226 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 230 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 234 0 22 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 13 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 0 234 0 108 0 19 0 109] 
#[1 0 238 0 1 0 238 0 2 0 238 0 3 0 238 0 4 0 238 0 7 0 238 0 8 0 238 0 9 0 238 0 10 0 238 0 12 0 238 0 15 0 238 0 16 0 238 0 18 0 238 0 19 0 238 0 20 0 238 0 22 2 17 0 28 0 238 0 32 0 238 0 33 0 238 0 34 0 238 0 35 0 238 0 108 0 238 0 109] 
#[0 0 242 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 0 0 0 108] 
#[0 0 0 0 108] 
#[0 0 246 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 250 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 0 254 0 108] 
#[0 1 2 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 73 0 17] 
#[1 0 21 0 4 0 121 0 32 0 125 0 33 0 129 0 34 1 81 0 71 1 81 0 95 1 81 0 96 1 81 0 97 1 81 0 98 1 21 0 99 0 53 0 100 2 21 0 109] 
#[0 1 6 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 15 0 16 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 10 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 27 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 14 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 18 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[1 0 21 0 4 2 25 0 6 0 121 0 32 0 125 0 33 0 129 0 34 2 29 0 71 2 29 0 95 2 29 0 96 2 29 0 97 2 29 0 98 1 21 0 99 0 53 0 100] 
#[0 1 22 0 22 0 28 0 108 0 109] 
#[0 1 26 0 4 0 14] 
#[1 0 21 0 4 2 33 0 14 2 37 0 44 1 65 0 99 0 53 0 100 1 109 0 101] 
#[1 2 41 0 14 1 73 0 17] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 45 0 71 2 49 0 80 2 49 0 81 2 49 0 82 2 49 0 83 2 49 0 86 2 49 0 89 2 49 0 90 2 49 0 91 2 49 0 92 1 1 0 93 2 45 0 95 2 45 0 96 2 45 0 97 2 45 0 98 1 21 0 99 0 53 0 100 1 25 0 102] 
#[1 1 30 0 1 1 30 0 2 1 30 0 3 1 30 0 4 1 30 0 6 1 30 0 7 1 30 0 8 1 30 0 9 1 30 0 10 1 30 0 12 1 30 0 13 2 53 0 14 1 30 0 15 1 30 0 16 1 30 0 18 1 30 0 19 1 30 0 20 1 30 0 28 1 30 0 32 1 30 0 33 1 30 0 34 1 30 0 35 1 30 0 108 1 30 0 109] 
#[0 1 34 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 2 57 0 23] 
#[1 1 38 0 23 1 38 0 28 2 61 0 75] 
#[1 0 21 0 4 0 121 0 32 0 125 0 33 0 129 0 34 2 65 0 71 2 65 0 95 2 65 0 96 2 65 0 97 2 65 0 98 1 21 0 99 0 53 0 100] 
#[0 1 42 0 6 0 17 0 22] 
#[1 2 69 0 6 1 129 0 17 2 73 0 22 2 77 0 77] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 73 0 6 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 10 0 22 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 81 0 48 2 85 0 49 0 161 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 29 0 106 1 33 0 107 0 23 0 109] 
#[0 2 89 0 21] 
#[1 0 85 0 9 0 89 0 10 2 93 0 22 2 101 0 82 2 101 0 88 2 105 0 109] 
#[0 1 46 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 1 50 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[1 1 54 0 1 1 54 0 2 1 54 0 3 1 54 0 4 1 54 0 7 1 54 0 8 1 54 0 9 1 54 0 10 1 54 0 11 1 54 0 14 0 27 0 17 1 54 0 18 1 54 0 19 1 54 0 20 1 54 0 21 1 54 0 22 1 54 0 23 1 54 0 25 1 54 0 26 1 54 0 28 1 54 0 35 2 109 0 104 1 54 0 108 1 54 0 109] 
#[0 1 58 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[1 1 62 0 1 1 62 0 2 1 62 0 3 0 31 0 4 1 62 0 7 1 62 0 8 1 62 0 9 1 62 0 10 1 62 0 11 1 62 0 14 1 62 0 18 1 62 0 19 1 62 0 20 1 62 0 21 1 62 0 22 1 62 0 23 1 62 0 25 1 62 0 26 1 62 0 28 1 62 0 35 1 65 0 99 0 53 0 100 2 113 0 101 1 62 0 108 1 62 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 97 0 13 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 117 0 41 0 141 0 42 0 145 0 43 2 121 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 2 125 0 106 1 33 0 107 1 66 0 108 1 37 0 109] 
#[0 1 70 0 108] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 129 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 74 0 108 1 37 0 109] 
#[0 1 78 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 133 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 2 137 0 106 1 33 0 107 1 82 0 108 1 37 0 109] 
#[0 1 86 0 22 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 90 0 22 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 141 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 90 0 108 0 35 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 94 0 22 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 145 0 53 2 145 0 54 2 145 0 55 2 145 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 94 0 108 0 39 0 109] 
#[1 0 21 0 4 1 221 0 25 2 149 0 59 2 149 0 62 1 229 0 63 1 233 0 64 2 149 0 67 2 149 0 70 2 165 0 99 0 53 0 100 1 241 0 101] 
#[0 1 98 0 21 0 22 0 23 0 28 0 108 0 109] 
#[0 1 102 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[1 1 106 0 21 1 106 0 22 1 106 0 23 1 205 0 26 1 106 0 28 2 169 0 57 1 106 0 108 1 106 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 173 0 68 2 177 0 69 2 173 0 71 2 173 0 72 2 173 0 73 2 173 0 76 2 173 0 80 2 173 0 81 2 173 0 82 2 173 0 83 2 173 0 86 2 173 0 89 2 173 0 90 2 173 0 91 2 173 0 92 1 1 0 93 2 173 0 95 2 173 0 96 2 173 0 97 2 173 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 37 0 109] 
#[0 1 110 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[0 1 114 0 4 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[1 0 21 0 4 1 118 0 21 1 118 0 22 1 118 0 23 1 118 0 26 1 118 0 28 2 185 0 63 1 65 0 99 0 53 0 100 1 241 0 101 1 118 0 108 1 118 0 109] 
#[0 1 122 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 189 0 65 2 193 0 66 0 197 0 68 2 177 0 69 0 197 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 197 0 95 0 197 0 96 0 197 0 97 0 197 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 37 0 109] 
#[0 1 126 0 21 0 22 0 23 0 28 0 108 0 109] 
#[0 1 130 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 1 134 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 1 138 0 21 0 22 0 23 0 28 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 197 0 54 2 197 0 55 2 197 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 37 0 109] 
#[1 1 142 0 1 1 142 0 2 1 142 0 3 1 142 0 4 1 142 0 7 1 142 0 8 1 142 0 9 1 142 0 10 1 142 0 11 1 142 0 18 1 142 0 19 1 142 0 20 1 142 0 21 1 142 0 25 1 142 0 26 1 142 0 28 1 142 0 35 2 201 0 84 1 142 0 109] 
#[0 1 146 0 22 0 108 0 109] 
#[0 1 150 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 154 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 158 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 162 0 4 0 6 0 32 0 33 0 34] 
#[0 1 166 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 170 0 4 0 14] 
#[0 1 174 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 178 0 4 0 14] 
#[0 1 182 0 4 0 14] 
#[0 1 186 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 13 0 15 0 16 0 18 0 19 0 20 0 28 0 32 0 33 0 34 0 35 0 108 0 109] 
#[0 1 190 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[1 2 205 0 23 2 209 0 28 2 213 0 74] 
#[0 1 194 0 6 0 17 0 22] 
#[0 1 198 0 1 0 2 0 3 0 4 0 6 0 7 0 8 0 9 0 10 0 12 0 15 0 16 0 18 0 19 0 20 0 22 0 28 0 32 0 33 0 34 0 35 0 109] 
#[0 1 202 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 1 206 0 6 0 17 0 22] 
#[1 2 217 0 22 2 221 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 110 0 22 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 1 193 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 197 0 106 1 33 0 107 0 43 0 109] 
#[0 1 210 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 1 214 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 1 218 0 9 0 10 0 22 0 109] 
#[0 1 222 0 9 0 10 0 22 0 109] 
#[0 1 226 0 9 0 10 0 22 0 109] 
#[1 1 230 0 1 1 230 0 2 1 230 0 3 1 230 0 4 1 230 0 7 1 230 0 8 1 230 0 9 1 230 0 10 1 230 0 11 1 230 0 14 2 225 0 17 1 230 0 18 1 230 0 19 1 230 0 20 1 230 0 21 1 230 0 22 1 230 0 23 1 230 0 25 1 230 0 26 1 230 0 28 1 230 0 35 2 229 0 103 1 230 0 108 1 230 0 109] 
#[0 1 234 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 1 33 0 28 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 233 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 2 237 0 106 1 33 0 107 1 238 0 108 1 37 0 109] 
#[0 1 242 0 108] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 241 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 246 0 108 1 37 0 109] 
#[0 1 250 0 108] 
#[0 1 254 0 108] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 2 245 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 2 2 0 108 1 37 0 109] 
#[0 2 6 0 22 0 108 0 109] 
#[0 2 10 0 22 0 28 0 108 0 109] 
#[0 2 14 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[0 2 18 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[0 2 22 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[0 2 26 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[1 1 73 0 17 1 134 0 21 1 134 0 22 1 134 0 23 1 134 0 26 1 134 0 28 1 134 0 108 1 134 0 109] 
#[0 2 30 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[1 0 47 0 4 2 34 0 21 2 34 0 22 2 34 0 23 2 34 0 25 2 34 0 26 2 34 0 28 1 249 0 70 1 253 0 99 0 53 0 100 2 34 0 108 2 34 0 109] 
#[0 0 154 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 0 158 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 2 38 0 4 0 21 0 22 0 23 0 26 0 28 0 108 0 109] 
#[1 2 42 0 4 2 42 0 21 2 42 0 22 2 42 0 23 1 221 0 25 2 42 0 26 2 42 0 28 1 237 0 67 2 42 0 108 2 42 0 109] 
#[0 0 146 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 2 46 0 21 0 22 0 23 0 28 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 2 249 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 2 253 0 11 3 1 0 18 0 6 0 19 0 113 0 20 2 50 0 21 3 5 0 25 3 9 0 26 3 13 0 28 0 133 0 35 3 21 0 80 3 21 0 81 3 21 0 82 3 21 0 83 3 21 0 85 3 21 0 86 3 21 0 89 3 21 0 90 3 21 0 91 3 21 0 92 1 1 0 93 3 25 0 94 1 25 0 102 3 29 0 109] 
#[0 2 54 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 3 33 0 23 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 3 37 0 54 3 37 0 55 3 37 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 1 37 0 109] 
#[0 2 58 0 23 0 28] 
#[0 2 62 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 2 66 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 3 41 0 17] 
#[0 2 70 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 2 74 0 108] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 0 21 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 0 93 0 12 0 101 0 15 0 105 0 16 0 109 0 18 0 6 0 19 0 113 0 20 0 121 0 32 0 125 0 33 0 129 0 34 0 133 0 35 3 45 0 51 0 165 0 52 0 169 0 53 0 169 0 54 0 169 0 55 0 169 0 60 0 185 0 61 0 189 0 65 0 193 0 66 0 197 0 68 0 201 0 69 0 205 0 71 0 197 0 72 0 197 0 73 0 197 0 76 0 197 0 80 0 197 0 81 0 197 0 82 0 197 0 83 0 197 0 86 0 197 0 89 0 197 0 90 0 197 0 91 0 197 0 92 1 1 0 93 0 205 0 95 0 205 0 96 0 205 0 97 0 205 0 98 1 21 0 99 0 53 0 100 1 25 0 102 2 78 0 108 1 37 0 109] 
#[0 2 82 0 108] 
#[0 2 86 0 108] 
#[0 2 90 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109] 
#[0 2 94 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109] 
#[1 1 142 0 1 1 142 0 2 1 142 0 3 1 142 0 4 1 142 0 7 1 142 0 8 1 142 0 9 1 142 0 10 1 142 0 11 1 142 0 18 1 142 0 19 1 142 0 20 1 142 0 21 1 142 0 25 1 142 0 26 1 142 0 28 1 142 0 35 3 49 0 84 1 142 0 109] 
#[0 2 98 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109] 
#[0 2 102 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109] 
#[0 2 106 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109] 
#[0 2 110 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109] 
#[0 2 114 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109] 
#[0 3 53 0 21] 
#[0 2 118 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109] 
#[0 2 122 0 4 0 21 0 22 0 23 0 25 0 26 0 28 0 108 0 109] 
#[0 2 126 0 23 0 28] 
#[1 0 21 0 4 3 57 0 99 0 53 0 100] 
#[0 2 130 0 108] 
#[1 0 61 0 1 0 65 0 2 0 69 0 3 2 249 0 4 0 77 0 7 0 81 0 8 0 85 0 9 0 89 0 10 2 253 0 11 3 1 0 18 0 6 0 19 0 113 0 20 3 61 0 21 3 5 0 25 3 9 0 26 3 13 0 28 0 133 0 35 3 21 0 80 3 21 0 81 3 21 0 82 3 21 0 83 3 21 0 85 3 21 0 86 3 21 0 89 3 21 0 90 3 21 0 91 3 21 0 92 1 1 0 93 1 25 0 102 3 29 0 109] 
#[0 2 134 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 2 138 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 14 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 25 0 26 0 28 0 35 0 108 0 109] 
#[0 2 142 0 1 0 2 0 3 0 4 0 7 0 8 0 9 0 10 0 11 0 18 0 19 0 20 0 21 0 25 0 26 0 28 0 35 0 109]
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
	result addToken: (nodes at: 2) to: result periods.
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
	result addToken: (nodes at: 4) to: result periods.
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
GtPharoParser >> reduceActionForArrayLiteralValue7: nodes [
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
GtPharoParser >> reduceActionForKeyword1: nodes [
	| result |
	result := GtPharoKeywordNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result addObject: (nodes at: 2) to: result selectorParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForKeywordMessage1: nodes [
	| result |
	result := GtPharoKeywordMessageNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result selectorParts.
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
	result addObject: (nodes at: 1) to: result selectorParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern2: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern3: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern4: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addObject: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern6: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addObjects: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result addObject: (nodes at: 2) to: result selectorParts.
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
	result addToken: (nodes at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodSequence12: nodes [
	| result |
	result := GtPharoMethodSequenceNode new.
	result addNodes: (nodes at: 1) to: result pragmas.
	result addToken: (nodes at: 2) to: result periods.
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
	result addToken: (nodes at: 3) to: result periods.
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
	result addToken: (nodes at: 3) to: result periods.
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
	result addToken: (nodes at: 4) to: result periods.
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
	result addToken: (nodes at: 4) to: result periods.
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
	result addToken: (nodes at: 3) to: result periods.
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
	result addToken: (nodes at: 3) to: result periods.
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
GtPharoParser >> reduceActionForName1: nodes [
	| result |
	result := GtPharoNameNode new.
	result addTokens: (nodes at: 1) to: result nameParts.
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
	result addNode: (nodes at: 2) to: result selectorParts.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma2: nodes [
	| result |
	result := GtPharoPragmaNode new.
	result lessThan: (nodes at: 1).
	result addNodes: ((nodes at: 2) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 2) at: 2) to: result values.
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma3: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForPragma4: nodes [
	| result |
	result := GtPharoPragmaErrorNode new.
	result lessThan: (nodes at: 1).
	result smaccError: (nodes at: 2).
	result greaterThan: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSelfVariable1: nodes [
	| result |
	result := GtPharoSelfVariableNode new.
	result name: (nodes at: 1).
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
	result addToken: (nodes at: 1) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence4: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result addToken: (nodes at: 1) to: result periods.
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
	result addToken: (nodes at: 2) to: result periods.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSequence8: nodes [
	| result |
	result := GtPharoSequenceNode new.
	result leftBar: ((nodes at: 1) at: 1).
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	result rightBar: ((nodes at: 1) at: 3).
	result addToken: (nodes at: 2) to: result periods.
	result addNodes: ((nodes at: 3) at: 1) to: result statements.
	result addTokens: ((nodes at: 3) at: 2) to: result periods.
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
	self add: (nodes at: 2) to: (result at: 2).
	self add: (nodes at: 3) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForStatements2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 2).
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
GtPharoParser >> reduceActionForSuperVariable1: nodes [
	| result |
	result := GtPharoSuperVariableNode new.
	result name: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSwitchToLiteralArray1: nodes [
	self scope: #literalArray.
	^ #array
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbol1: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObject: (nodes at: 2) to: result symbolParts.
	result addObjects: (nodes at: 3) to: result symbolParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbol3: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObjects: (nodes at: 2) to: result symbolParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbol4: nodes [
	| result |
	result := GtPharoSymbolNode new.
	result _hash: (nodes at: 1).
	result addObject: (nodes at: 2) to: result symbolParts.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForSymbolLiteral1: nodes [
	| result |
	result := GtPharoSymbolLiteralNode new.
	result value: (nodes at: 1).
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
GtPharoParser >> reduceActionForThisContextVariable1: nodes [
	| result |
	result := GtPharoThisContextVariableNode new.
	result name: (nodes at: 1).
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
	result := GtPharoErrorNode new.
	result smaccError: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForVariable__variable__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_Keyword__selectorPart__Variable__variable__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_Keyword__selectorPart__Variable__variable___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: ((nodes at: 1) at: 1) to: (result at: 1).
	self add: ((nodes at: 1) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_Keyword__selectorPart__Variable__variable___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	self add: (nodes at: 2) to: result.
	self add: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__colon__symbolPart__colon___symbolPart_Name_symbolPart___2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor__period___period__Assignment__value___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_name___namePart___1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionFor_name___namePart___2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

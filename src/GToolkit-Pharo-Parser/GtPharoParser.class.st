Class {
	#name : #GtPharoParser,
	#superclass : #SmaCCGLRParser,
	#category : 'GToolkit-Pharo-Parser-Parser'
}

{ #category : #generated }
GtPharoParser class >> ambiguousTransitions [
^#(
#[ 0 38 1 137] 
#[ 0 38 0 97] 
#[ 0 50 1 137] 
#[ 0 50 0 97] 
#[ 0 142 1 69] 
#[ 0 190 2 133] 
#[ 0 97 0 190] 
#[ 1 62 1 137] 
#[ 0 97 1 62] 
#[ 0 10 1 69] 
#[ 1 69 1 130] 
#[ 1 69 1 138] 
#[ 0 150 1 69] 
#[ 2 126 2 133] 
#[ 0 97 2 126]
	).
]

{ #category : #'generated-accessing' }
GtPharoParser class >> cacheId [
	^'2021-09-09T12:35:48.964308-05:00'
]

{ #category : #generated }
GtPharoParser class >> definitionComment [
"%glr;
%prefix GtPharo;
%suffix Node;
%root Program;
%start Method MethodSequence Statement MethodPattern KeywordMessageSend Variable Pragma;
%id <bar> <binary> <doubleLeftBrace> <doubleRightBrace> <templateNamePart> <doubleLeftBraceStart> <templateKeyword>
	<number> <negativeNumber> <bar> <name> <keyword> <nameAssignment> <leftBrace> <rightBrace>;
%hierarchy Value (
	Array
	Assignment
	Block
	Cascade
	Error
	Literal
	MessageSend
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
Method
	: MethodPattern 'pattern' MethodSequence 'body' {{}}
	;
MethodPattern
	: <name> 'selectorPart' {{}}
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
	: (<keyword> 'selectorPart' Variable 'variable')+
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
	: (<keyword> 'selectorPart' BinaryMessageSend 'value')+ {{}}
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
	| <name> 'value' {{SymbolLiteral}}
	| <binary> 'value' {{SymbolLiteral}}
	| <period> 'value' {{SymbolLiteral}}
	| <return> 'value' {{SymbolLiteral}}
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
	: [self scope: #literalArray. #array]
	;
EndLiteralArray
	: [self endLiteralArray. nil]
	;"
]

{ #category : #generated }
GtPharoParser class >> reduceTable [
^#(
	#(117 0 #reduceActionForSwitchToLiteralArray1: 9074689 true) 
	#(64 0 #reduceActionForSequence1: 4841473 false) 
	#(38 1 #reduceActionForMethodPattern1: 2848769 false) 
	#(51 1 #reduceActionForTemplateNamePart1: 3833857 false) 
	#(40 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 3123201 false) 
	#(61 1 #reduceActionForKeywordPattern1: 4546561 false) 
	#(38 1 #liftFirstValue: 2848772 false) 
	#(43 1 #reduceActionForKeywordPattern1: 3299329 false) 
	#(41 1 #reduceActionForTemplatePattern2: 3237890 false) 
	#(41 1 #reduceActionForTemplatePattern1: 3237889 false) 
	#(42 1 #reduceActionFor_TemplateKeywordPattern_KeywordPattern__1: 3299329 false) 
	#(38 1 #reduceActionForMethodPattern3: 2848771 false) 
	#(47 0 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: 3518465 false) 
	#(91 1 #reduceActionForVariable1: 6639617 false) 
	#(91 1 #reduceActionForVariable2: 6639618 false) 
	#(91 1 #reduceActionForVariable3: 6639619 false) 
	#(115 1 #reduceActionForBooleanLiteral1: 8971265 false) 
	#(115 1 #reduceActionForBooleanLiteral1: 8971266 false) 
	#(116 1 #reduceActionForNilLiteral1: 9037825 false) 
	#(92 1 #reduceActionForNamedVariable1: 6810625 false) 
	#(66 0 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: 4940801 false) 
	#(105 1 #reduceActionForStringLiteral1: 8002561 false) 
	#(114 1 #reduceActionForSymbolLiteral1: 8928257 false) 
	#(113 1 #reduceActionForCharacterLiteral1: 8879105 false) 
	#(106 1 #reduceActionForNumberLiteral1: 8045569 false) 
	#(106 1 #reduceActionForNumberLiteral1: 8045570 false) 
	#(103 0 #reduceActionForBlockArgs1: 7776257 false) 
	#(111 0 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: 8735745 false) 
	#(63 1 #reduceActionFor_period___period__1: 4664321 false) 
	#(93 1 #reduceActionForTemplateVariable1: 6863873 false) 
	#(62 1 #reduceActionForMethodSequence9: 4617225 false) 
	#(52 1 #reduceActionForKeywordPattern1: 3893249 false) 
	#(53 1 #reduceActionFor_period___period__1: 3904513 false) 
	#(54 1 #liftFirstValue: 3924995 false) 
	#(64 1 #reduceActionForSequence3: 4841475 false) 
	#(62 1 #liftFirstValue: 4617233 false) 
	#(64 1 #reduceActionForSequence5: 4841477 false) 
	#(64 1 #reduceActionForSequence2: 4841474 false) 
	#(67 1 #reduceActionForKeywordPattern1: 4982785 false) 
	#(68 1 #reduceActionForStatementList1: 5035009 false) 
	#(69 1 #liftFirstValue: 5137410 false) 
	#(70 1 #liftFirstValue: 5218306 false) 
	#(71 1 #liftFirstValue: 5319684 false) 
	#(76 1 #reduceActionForKeywordMessageSend1: 5647361 false) 
	#(76 1 #liftFirstValue: 5647362 false) 
	#(84 1 #reduceActionForKeywordMessageSend1: 6122497 false) 
	#(84 1 #liftFirstValue: 6122498 false) 
	#(87 1 #reduceActionForKeywordMessageSend1: 6366209 false) 
	#(96 1 #liftFirstValue: 7158785 false) 
	#(91 1 #liftFirstValue: 6639620 false) 
	#(91 1 #liftFirstValue: 6639621 false) 
	#(87 1 #liftFirstValue: 6366210 false) 
	#(96 1 #liftFirstValue: 7158787 false) 
	#(96 1 #liftFirstValue: 7158788 false) 
	#(96 1 #liftFirstValue: 7158786 false) 
	#(104 1 #liftFirstValue: 7848961 false) 
	#(104 1 #liftFirstValue: 7848962 false) 
	#(104 1 #liftFirstValue: 7848963 false) 
	#(104 1 #liftFirstValue: 7848964 false) 
	#(104 1 #liftFirstValue: 7848965 false) 
	#(104 1 #liftFirstValue: 7848966 false) 
	#(104 1 #liftFirstValue: 7848967 false) 
	#(104 1 #liftFirstValue: 7848968 false) 
	#(96 1 #reduceActionForValue6: 7158790 false) 
	#(39 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 3123201 false) 
	#(38 2 #reduceActionForMethodPattern6: 2848774 false) 
	#(38 2 #reduceActionForMethodPattern2: 2848770 false) 
	#(38 2 #reduceActionForMethodPattern6: 2848773 false) 
	#(37 2 #reduceActionForMethod1: 2783233 false) 
	#(40 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 3123202 false) 
	#(43 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 3299330 false) 
	#(49 2 #reduceActionForTemplateKeyword2: 3648514 false) 
	#(49 2 #reduceActionForTemplateKeyword2: 3648513 false) 
	#(42 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern__2: 3299330 false) 
	#(48 2 #reduceActionForTemplateKeywordPattern1: 3581953 false) 
	#(46 1 #reduceActionForKeywordPattern1: 3395585 false) 
	#(44 2 #reduceActionForTemplateWithName1: 3350529 false) 
	#(45 1 #reduceActionFor_period___period__1: 3395585 false) 
	#(41 2 #reduceActionForTemplatePattern3: 3237891 false) 
	#(44 2 #reduceActionForTemplateWithName1: 3350530 false) 
	#(50 1 #reduceActionForTemplateNamePart1: 3749889 false) 
	#(69 2 #reduceActionForStatement1: 5137409 false) 
	#(56 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 4019201 false) 
	#(60 1 #reduceActionForKeywordPattern1: 4439041 false) 
	#(54 2 #reduceActionForPragma4: 3924996 false) 
	#(97 2 #reduceActionForArray1: 7318529 false) 
	#(99 0 #reduceActionFor__period___period___Assignment__value___1: 7372801 false) 
	#(102 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 7604225 false) 
	#(62 2 #reduceActionForMethodSequence11: 4617227 false) 
	#(62 2 #reduceActionForMethodSequence13: 4617229 false) 
	#(62 2 #reduceActionForMethodSequence10: 4617226 false) 
	#(53 2 #reduceActionForPragma__pragma__2: 3904514 false) 
	#(63 2 #reduceActionForPragma__pragma__2: 4664322 false) 
	#(64 2 #reduceActionForSequence4: 4841476 false) 
	#(62 2 #reduceActionForMethodSequence5: 4617221 false) 
	#(64 2 #reduceActionForSequence7: 4841479 false) 
	#(64 2 #reduceActionForSequence6: 4841478 false) 
	#(67 2 #reduceActionForStatements2: 4982786 false) 
	#(71 2 #reduceActionForCascade1: 5319681 false) 
	#(74 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5518337 false) 
	#(72 1 #reduceActionForKeywordPattern1: 5497857 false) 
	#(77 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5734401 false) 
	#(80 1 #reduceActionFor__keyword___selectorPart__Variable__variable___1: 5838849 false) 
	#(78 1 #reduceActionForKeywordMessage1: 5820417 false) 
	#(78 1 #liftFirstValue: 5820418 false) 
	#(83 1 #reduceActionForKeywordPattern1: 6011905 false) 
	#(81 1 #reduceActionForTemplateKeywordMessage1: 5928961 false) 
	#(85 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 6206465 false) 
	#(71 2 #reduceActionForCascade1: 5319682 false) 
	#(89 1 #reduceActionForUnaryMessage1: 6517761 false) 
	#(90 1 #reduceActionForTemplateUnaryMessage1: 6589441 false) 
	#(88 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 6436865 false) 
	#(89 1 #liftFirstValue: 6517762 false) 
	#(71 2 #reduceActionForCascade1: 5319683 false) 
	#(108 0 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____1: 8194049 false) 
	#(38 3 #reduceActionForMethodPattern7: 2848775 false) 
	#(46 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: 3395586 false) 
	#(45 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part___2: 3395586 false) 
	#(47 2 #reduceActionFor_MidTemplate__part__TemplateNameContinuationPart__part____2: 3518466 false) 
	#(44 3 #reduceActionForTemplateWithName3: 3350531 false) 
	#(95 3 #reduceActionForStartTemplate1: 7030785 false) 
	#(65 3 #reduceActionForTemporaries1: 4908033 false) 
	#(66 2 #reduceActionForPragma__pragma__2: 4940802 false) 
	#(54 3 #reduceActionForPragma1: 3924993 false) 
	#(55 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 4019201 false) 
	#(57 1 #liftFirstValue: 4239362 false) 
	#(57 1 #liftFirstValue: 4239361 false) 
	#(58 3 #reduceActionForTemplatePragma1: 4297729 false) 
	#(59 2 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: 4439041 false) 
	#(54 3 #reduceActionForPragma2: 3924994 false) 
	#(56 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 4019202 false) 
	#(58 3 #reduceActionForTemplatePragma2: 4297730 false) 
	#(60 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 4439042 false) 
	#(54 3 #reduceActionForPragma5: 3924997 false) 
	#(97 3 #reduceActionForArray2: 7318530 false) 
	#(101 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 7604225 false) 
	#(103 2 #reduceActionForBlockArgs2: 7776258 false) 
	#(100 3 #reduceActionForBlock2: 7472130 false) 
	#(102 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 7604226 false) 
	#(96 3 #reduceActionForValue5: 7158789 false) 
	#(110 3 #reduceActionForByteArrayLiteral1: 8684545 false) 
	#(112 1 #liftFirstValue: 8803329 false) 
	#(111 2 #reduceActionForPragma__pragma__2: 8735746 false) 
	#(112 1 #reduceActionForValue6: 8803330 false) 
	#(62 3 #reduceActionForMethodSequence12: 4617228 false) 
	#(62 3 #reduceActionForMethodSequence1: 4617217 false) 
	#(62 3 #reduceActionForMethodSequence15: 4617231 false) 
	#(62 3 #reduceActionForMethodSequence14: 4617230 false) 
	#(62 3 #reduceActionForMethodSequence7: 4617223 false) 
	#(62 3 #reduceActionForMethodSequence6: 4617222 false) 
	#(64 3 #reduceActionForSequence8: 4841480 false) 
	#(68 3 #reduceActionForStatementList2: 5035010 false) 
	#(73 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5518337 false) 
	#(75 1 #liftFirstValue: 5575681 false) 
	#(75 1 #liftFirstValue: 5575682 false) 
	#(75 1 #liftFirstValue: 5575683 false) 
	#(74 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5518338 false) 
	#(79 2 #reduceActionFor__keyword___selectorPart__Variable__variable__1: 5838849 false) 
	#(86 2 #reduceActionForBinaryMessage1: 6290433 false) 
	#(82 2 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____1: 6011905 false) 
	#(80 2 #reduceActionFor__keyword___selectorPart__Variable__variable___2: 5838850 false) 
	#(81 2 #reduceActionForTemplateKeywordMessage2: 5928962 false) 
	#(83 2 #reduceActionFor_TemplateKeywordPattern_KeywordPattern___2: 6011906 false) 
	#(70 3 #reduceActionForAssignment1: 5218305 false) 
	#(118 0 #reduceActionForEndLiteralArray1: 9139201 true) 
	#(94 3 #reduceActionForStartTemplate1: 6909953 false) 
	#(59 3 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: 4439042 false) 
	#(58 4 #reduceActionForTemplatePragma3: 4297731 false) 
	#(97 4 #reduceActionForArray3: 7318531 false) 
	#(99 2 #reduceActionFor__period___period___Assignment__value___2: 7372802 false) 
	#(100 4 #reduceActionForBlock1: 7472129 false) 
	#(100 4 #reduceActionForBlock3: 7472131 false) 
	#(62 4 #reduceActionForMethodSequence3: 4617219 false) 
	#(62 4 #reduceActionForMethodSequence2: 4617218 false) 
	#(62 4 #reduceActionForMethodSequence16: 4617232 false) 
	#(62 4 #reduceActionForMethodSequence8: 4617224 false) 
	#(82 3 #reduceActionFor_TemplateKeyword_PragmaArgument___keyword___selectorPart__PragmaArgument____2: 6011906 false) 
	#(109 1 #reduceActionForSymbolLiteral1: 8271875 false) 
	#(109 1 #reduceActionForSymbolLiteral1: 8271874 false) 
	#(109 1 #reduceActionForSymbolLiteral1: 8271878 false) 
	#(109 1 #reduceActionForSymbolLiteral1: 8271876 false) 
	#(109 1 #reduceActionForSymbolLiteral1: 8271879 false) 
	#(109 1 #reduceActionForSymbolLiteral1: 8271877 false) 
	#(109 1 #liftFirstValue: 8271873 false) 
	#(108 2 #reduceActionForPragma__pragma__2: 8194050 false) 
	#(109 1 #reduceActionForValue6: 8271881 false) 
	#(97 5 #reduceActionForArray4: 7318532 false) 
	#(98 2 #reduceActionForTemplateKeyword2: 7372801 false) 
	#(62 5 #reduceActionForMethodSequence4: 4617220 false) 
	#(107 5 #reduceActionForArrayLiteral1: 8122369 false) 
	#(109 3 #reduceActionForArrayLiteralValue8: 8271880 false)
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
	^ #('"self"' '"super"' '"thisContext"' '<true>' '<false>' '<nil>' '<name>' '<nameAssignment>' '<bar>' '<string>' '<symbol>' '<character>' '<number>' '<negativeNumber>' '<literalArrayKeyword>' '<return>' '<lt>' '<gt>' '<leftBrace>' '<leftBracket>' '<colon>' '<leftParen>' '<literalArrayStart>' '<byteArrayStart>' '<rightParen>' '<rightBracket>' '<rightBrace>' '<keyword>' '<binary>' '<semicolon>' '<assign>' '<period>' '<comment>' '<whitespace>' '<patternToken>' 'B e g i n' 'Method' 'MethodPattern' '(<keyword> ''selectorPart'' Variable ''variable'')' '(<keyword> ''selectorPart'' Variable ''variable'')+' 'TemplatePattern' '(TemplateKeywordPattern KeywordPattern?)' '(TemplateKeywordPattern KeywordPattern?)+' 'TemplateWithName' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)+' '(MidTemplate ''part'' TemplateNameContinuationPart ''part''?)*' 'TemplateKeywordPattern' 'TemplateKeyword' 'TemplateNameContinuationPart' 'TemplateNamePart' 'Pragmas' 'Pragma ''pragma''+' 'Pragma' '(<keyword> ''selectorPart'' PragmaArgument)' '(<keyword> ''selectorPart'' PragmaArgument)+' 'PragmaArgument' 'TemplatePragma' '(TemplateKeyword PragmaArgument (<keyword> ''selectorPart'' PragmaArgument)+?)' '(TemplateKeyword PragmaArgument (<keyword> ''selectorPart'' PragmaArgument)+?)+' 'KeywordPattern' 'MethodSequence' '<period> ''period''+' 'Sequence' 'Temporaries' 'Variable ''variable''*' 'Statements' 'StatementList' 'Statement' 'Assignment' 'Cascade' 'CascadedMessages' '(<semicolon> ''semicolon'' CascadedMessage ''message'')' '(<semicolon> ''semicolon'' CascadedMessage ''message'')+' 'CascadedMessage' 'KeywordMessageSend' 'KeywordMessageSendVars' 'KeywordMessage' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')' '(<keyword> ''selectorPart'' BinaryMessageSend ''value'')+' 'TemplateKeywordMessage' '(TemplateKeyword BinaryMessageSend ''value'' (<keyword> ''selectorPart'' BinaryMessageSend ''value'')+?)' '(TemplateKeyword BinaryMessageSend ''value'' (<keyword> ''selectorPart'' BinaryMessageSend ''value'')+?)+' 'BinaryMessageSend' 'BinaryMessageSendVars' 'BinaryMessage' 'UnaryMessageSend' 'UnaryMessageSendVars' 'UnaryMessage' 'TemplateUnaryMessage' 'Variable' 'NamedVariable' 'TemplateVariable' 'MidTemplate' 'StartTemplate' 'Value' 'Array' '(<period> ''period''+ Assignment ''value'')' '(<period> ''period''+ Assignment ''value'')*' 'Block' '(<colon> ''colon'' Variable ''variable'')' '(<colon> ''colon'' Variable ''variable'')+' 'BlockArgs' 'Literal' 'StringLiteral' 'NumberLiteral' 'ArrayLiteral' 'ArrayLiteralValue ''value''*' 'ArrayLiteralValue' 'ByteArrayLiteral' 'ByteArrayLiteralValue ''value''*' 'ByteArrayLiteralValue' 'CharacterLiteral' 'SymbolLiteral' 'BooleanLiteral' 'NilLiteral' 'SwitchToLiteralArray' 'EndLiteralArray' '<doubleLeftBrace>' '<doubleLeftBraceStart>' '<doubleRightBrace>' '<templateKeyword>' '<templateNamePart>' 'E O F' 'error')
]

{ #category : #generated }
GtPharoParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #GtPharoMethodNode #GtPharoMethodNode #GtPharoMethodPatternNode #OrderedCollection #OrderedCollection #GtPharoTemplatePatternNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoTemplateNamePartNode #GtPharoTemplateNamePartNode #OrderedCollection #OrderedCollection #GtPharoPragmaNode #OrderedCollection #OrderedCollection #GtPharoValueNode #GtPharoTemplatePragmaNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoSequenceNode #OrderedCollection #GtPharoSequenceNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoProgramNode #GtPharoValueNode #GtPharoValueNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoMessageNode #GtPharoValueNode #OrderedCollection #GtPharoKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoTemplateKeywordMessageNode #OrderedCollection #OrderedCollection #GtPharoValueNode #OrderedCollection #GtPharoBinaryMessageNode #GtPharoValueNode #OrderedCollection #GtPharoUnaryMessageNode #GtPharoTemplateUnaryMessageNode #GtPharoValueNode #GtPharoNamedVariableNode #GtPharoTemplateVariableNode #GtPharoTemplateNode #GtPharoTemplateNode #GtPharoValueNode #GtPharoArrayNode #OrderedCollection #OrderedCollection #GtPharoBlockNode #OrderedCollection #OrderedCollection #OrderedCollection #GtPharoLiteralNode #GtPharoStringLiteralNode #GtPharoNumberLiteralNode #GtPharoArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoByteArrayLiteralNode #OrderedCollection #GtPharoValueNode #GtPharoCharacterLiteralNode #GtPharoSymbolLiteralNode #GtPharoBooleanLiteralNode #GtPharoNilLiteralNode #ByteSymbol nil #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
GtPharoParser class >> transitionTable [
^#(
#[1 0 33 0 7 0 37 0 28 0 41 0 29 0 45 0 37 0 49 0 38 0 53 0 39 0 57 0 40 0 49 0 41 0 65 0 42 0 69 0 43 0 73 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 89 0 61 0 93 0 95 0 97 0 120] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 129 0 9 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 157 0 17 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 177 0 32 0 181 0 44 0 85 0 51 0 185 0 52 0 189 0 53 0 193 0 54 0 193 0 58 0 201 0 62 0 205 0 63 0 201 0 64 0 213 0 65 0 217 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 0 10 0 124 1 69 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 1 73 0 69 1 73 0 70 1 73 0 71 1 73 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 0 33 0 7 0 37 0 28 0 41 0 29 1 77 0 38 0 53 0 39 0 57 0 40 1 77 0 41 0 65 0 42 0 69 0 43 0 73 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 89 0 61 0 93 0 95 0 97 0 120] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 1 81 0 76 1 85 0 77 0 245 0 84 1 89 0 85 0 253 0 87 1 93 0 88 0 253 0 91 0 253 0 92 0 253 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 125 0 7 0 181 0 44 0 85 0 51 1 101 0 91 1 101 0 92 1 101 0 93 0 93 0 95 0 97 0 120] 
#[1 0 157 0 17 1 105 0 54 1 105 0 58] 
#[1 0 14 0 1 0 14 0 2 0 14 0 3 0 14 0 4 0 14 0 5 0 14 0 6 0 14 0 7 0 14 0 9 0 14 0 10 0 14 0 11 0 14 0 12 0 14 0 13 0 14 0 14 0 14 0 16 0 14 0 17 0 14 0 19 0 14 0 20 0 14 0 22 0 14 0 23 0 14 0 24 0 14 0 32 0 18 0 119 0 14 0 120 0 14 0 124 0 14 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 125 0 7 0 181 0 44 0 85 0 51 1 109 0 91 1 109 0 92 1 109 0 93 0 93 0 95 0 97 0 120 1 113 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 125 0 7 0 181 0 44 0 85 0 51 1 117 0 91 1 117 0 92 1 117 0 93 0 93 0 95 0 97 0 120 1 121 0 125] 
#[0 0 0 0 124] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 129 0 9 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 157 0 17 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 177 0 32 0 181 0 44 0 85 0 51 0 185 0 52 0 189 0 53 0 193 0 54 0 193 0 58 1 125 0 62 0 205 0 63 1 125 0 64 0 213 0 65 0 217 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 0 10 0 124 1 69 0 125] 
#[0 0 22 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 120 0 124 0 125] 
#[1 0 26 0 1 0 26 0 2 0 26 0 3 0 26 0 4 0 26 0 5 0 26 0 6 0 26 0 7 0 26 0 9 0 26 0 10 0 26 0 11 0 26 0 12 0 26 0 13 0 26 0 14 0 26 0 16 0 26 0 17 0 26 0 19 0 26 0 20 0 26 0 22 0 26 0 23 0 26 0 24 1 129 0 28 0 26 0 32 1 133 0 39 0 26 0 120 0 26 0 124 0 26 0 125] 
#[0 0 30 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 0 34 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[1 0 38 0 1 0 38 0 2 0 38 0 3 0 38 0 4 0 38 0 5 0 38 0 6 0 7 0 7 0 38 0 9 0 38 0 10 0 38 0 11 0 38 0 12 0 38 0 13 0 38 0 14 0 38 0 16 0 38 0 17 0 38 0 19 0 38 0 20 0 38 0 22 0 38 0 23 0 38 0 24 0 38 0 32 1 141 0 42 1 145 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 93 0 95 0 11 0 120 0 38 0 124 0 38 0 125] 
#[1 0 42 0 1 0 42 0 2 0 42 0 3 0 42 0 4 0 42 0 5 0 42 0 6 0 42 0 7 0 42 0 9 0 42 0 10 0 42 0 11 0 42 0 12 0 42 0 13 0 42 0 14 0 42 0 16 0 42 0 17 0 42 0 19 0 42 0 20 1 149 0 21 0 42 0 22 0 42 0 23 0 42 0 24 0 42 0 32 0 42 0 120 1 153 0 122 0 42 0 124 0 42 0 125] 
#[1 0 46 0 1 0 46 0 2 0 46 0 3 0 46 0 4 0 46 0 5 0 46 0 6 0 46 0 7 0 46 0 9 0 46 0 10 0 46 0 11 0 46 0 12 0 46 0 13 0 46 0 14 0 46 0 16 0 46 0 17 0 46 0 19 0 46 0 20 0 46 0 22 0 46 0 23 0 46 0 24 1 157 0 28 0 46 0 32 0 53 0 39 1 161 0 40 1 165 0 61 0 46 0 120 0 46 0 124 0 46 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 125 0 7 0 181 0 44 0 85 0 51 1 169 0 91 1 169 0 92 1 169 0 93 0 93 0 95 0 97 0 120] 
#[1 1 173 0 45 1 177 0 46 1 181 0 94 1 185 0 119] 
#[1 0 50 0 1 0 50 0 2 0 50 0 3 0 50 0 4 0 50 0 5 0 50 0 6 0 15 0 7 0 50 0 9 0 50 0 10 0 50 0 11 0 50 0 12 0 50 0 13 0 50 0 14 0 50 0 16 0 50 0 17 0 50 0 19 0 50 0 20 0 50 0 22 0 50 0 23 0 50 0 24 0 50 0 32 0 65 0 42 1 189 0 43 1 145 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 93 0 95 0 19 0 120 0 50 0 124 0 50 0 125] 
#[1 0 54 0 1 0 54 0 2 0 54 0 3 0 54 0 4 0 54 0 5 0 54 0 6 0 54 0 7 0 54 0 9 0 54 0 10 0 54 0 11 0 54 0 12 0 54 0 13 0 54 0 14 0 54 0 16 0 54 0 17 0 54 0 18 0 54 0 19 0 54 0 20 0 54 0 21 0 54 0 22 0 54 0 23 0 54 0 24 0 54 0 25 0 54 0 26 0 54 0 27 0 54 0 28 0 54 0 29 0 54 0 30 0 54 0 31 0 54 0 32 1 193 0 47 1 197 0 50 0 54 0 119 0 54 0 120 0 54 0 121 0 54 0 122 1 201 0 123 0 54 0 124 0 54 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 1 205 0 70 1 205 0 71 1 205 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[0 0 58 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 120 0 121 0 124 0 125] 
#[0 0 62 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 120 0 121 0 124 0 125] 
#[0 0 66 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 120 0 121 0 124 0 125] 
#[0 0 70 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 74 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 78 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 0 82 0 1 0 82 0 2 0 82 0 3 0 82 0 4 0 82 0 5 0 82 0 6 0 82 0 7 0 82 0 9 0 82 0 10 0 82 0 11 0 82 0 12 0 82 0 13 0 82 0 14 0 82 0 16 0 82 0 17 0 82 0 18 0 82 0 19 0 82 0 20 0 82 0 21 0 82 0 22 0 82 0 23 0 82 0 24 0 82 0 25 0 82 0 26 0 82 0 27 0 82 0 28 0 82 0 29 0 82 0 30 0 82 0 31 0 82 0 32 0 18 0 119 0 82 0 120 0 82 0 121 0 82 0 124 0 82 0 125] 
#[1 0 86 0 1 0 86 0 2 0 86 0 3 0 86 0 7 0 86 0 9 1 209 0 66 0 86 0 120] 
#[0 0 90 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 94 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 98 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 102 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 106 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 1 213 0 70 1 213 0 71 1 213 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 1 217 0 7 1 221 0 28 1 225 0 44 1 229 0 49 0 85 0 51 1 233 0 55 1 237 0 56 1 241 0 59 1 245 0 60 0 93 0 95 0 97 0 120 1 249 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 1 253 0 27 0 177 0 32 0 181 0 44 0 85 0 51 2 1 0 63 2 5 0 70 2 5 0 71 2 5 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 0 110 0 1 0 110 0 2 0 110 0 3 0 110 0 4 0 110 0 5 0 110 0 6 0 110 0 7 0 110 0 9 0 110 0 10 0 110 0 11 0 110 0 12 0 110 0 13 0 110 0 14 0 110 0 16 0 110 0 19 0 110 0 20 2 9 0 21 0 110 0 22 0 110 0 23 0 110 0 24 0 110 0 26 0 110 0 32 2 13 0 101 2 17 0 102 2 21 0 103 0 110 0 120 0 110 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 2 25 0 70 2 25 0 71 2 25 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 0 114 0 13 0 114 0 14 0 114 0 26 2 29 0 111 0 114 0 125] 
#[0 0 118 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 120 0 124 0 125] 
#[0 0 122 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 120 0 121 0 124 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 129 0 9 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 177 0 32 0 181 0 44 0 85 0 51 2 33 0 63 2 37 0 65 2 41 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 0 126 0 124 1 69 0 125] 
#[1 0 130 0 1 0 130 0 2 0 130 0 3 0 130 0 4 0 130 0 5 0 130 0 6 0 130 0 7 0 130 0 9 0 130 0 10 0 130 0 11 0 130 0 12 0 130 0 13 0 130 0 14 0 130 0 16 0 157 0 17 0 130 0 19 0 130 0 20 0 130 0 22 0 130 0 23 0 130 0 24 0 130 0 32 2 45 0 54 2 45 0 58 0 130 0 120 0 130 0 124 0 130 0 125] 
#[0 0 134 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 0 138 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 0 0 0 124] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 142 0 26 2 49 0 32 0 181 0 44 0 85 0 51 2 53 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 0 142 0 124 0 23 0 125] 
#[0 0 146 0 124] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 157 0 17 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 177 0 32 0 181 0 44 0 85 0 51 2 57 0 52 0 189 0 53 0 193 0 54 0 193 0 58 2 61 0 63 2 65 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 0 150 0 124 1 69 0 125] 
#[0 0 154 0 26 0 124 0 125] 
#[1 0 158 0 26 0 177 0 32 2 69 0 63 0 158 0 124 0 158 0 125] 
#[0 0 162 0 26 0 32 0 124 0 125] 
#[0 0 166 0 26 0 32 0 124 0 125] 
#[0 0 170 0 25 0 26 0 27 0 32 0 121 0 124 0 125] 
#[0 0 174 0 25 0 26 0 27 0 32 0 121 0 124 0 125] 
#[1 0 178 0 25 0 178 0 26 0 178 0 27 2 73 0 30 0 178 0 32 2 77 0 72 2 81 0 73 2 85 0 74 0 178 0 121 0 178 0 124 0 178 0 125] 
#[1 1 137 0 7 0 182 0 25 0 182 0 26 0 182 0 27 2 89 0 28 2 93 0 29 0 182 0 32 1 145 0 44 2 97 0 49 0 85 0 51 2 101 0 78 2 105 0 79 2 109 0 80 2 101 0 81 2 117 0 82 2 121 0 83 2 125 0 86 0 93 0 95 0 97 0 120 0 182 0 121 0 182 0 124 0 182 0 125] 
#[1 0 186 0 7 0 186 0 25 0 186 0 26 0 186 0 27 0 186 0 28 0 186 0 29 2 73 0 30 0 186 0 32 2 129 0 72 2 81 0 73 2 85 0 74 0 186 0 120 0 186 0 121 0 186 0 124 0 186 0 125] 
#[1 0 27 0 7 0 190 0 25 0 190 0 26 0 190 0 27 0 190 0 28 0 190 0 29 0 190 0 30 0 190 0 32 2 137 0 44 0 85 0 51 2 141 0 89 2 141 0 90 0 93 0 95 0 31 0 120 0 190 0 121 0 190 0 124 0 190 0 125] 
#[1 0 194 0 7 0 194 0 25 0 194 0 26 0 194 0 27 0 194 0 28 0 194 0 29 2 73 0 30 0 194 0 32 2 149 0 72 2 81 0 73 2 85 0 74 0 194 0 120 0 194 0 121 0 194 0 124 0 194 0 125] 
#[1 0 198 0 7 0 198 0 25 0 198 0 26 0 198 0 27 0 198 0 28 0 198 0 29 2 153 0 31 0 198 0 32 0 198 0 120 0 198 0 121 0 198 0 124 0 198 0 125] 
#[0 0 202 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 120 0 121 0 124 0 125] 
#[0 0 206 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 120 0 121 0 124 0 125] 
#[0 0 210 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 214 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 218 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 222 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 226 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 230 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 234 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 238 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 242 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 246 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 250 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 254 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 2 157 0 23] 
#[0 1 2 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 0 0 124] 
#[0 0 0 0 124] 
#[0 0 0 0 124] 
#[0 0 178 0 124] 
#[0 0 186 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 194 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 198 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 0 0 0 124] 
#[0 0 0 0 124] 
#[0 1 6 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 120 0 124 0 125] 
#[0 1 10 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 1 14 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 1 18 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 1 22 0 124] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 125 0 7 0 181 0 44 0 85 0 51 1 109 0 91 1 109 0 92 1 109 0 93 0 93 0 95 0 97 0 120 2 161 0 125] 
#[0 1 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 120 0 124 0 125] 
#[0 0 18 0 119] 
#[0 1 30 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[1 1 149 0 21 1 153 0 122] 
#[0 1 34 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 19 0 20 0 22 0 23 0 24 0 120 0 125] 
#[0 1 38 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 19 0 20 0 22 0 23 0 24 0 120 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 125 0 7 0 181 0 44 0 85 0 51 1 109 0 91 1 109 0 92 1 109 0 93 0 93 0 95 0 97 0 120] 
#[1 0 26 0 1 0 26 0 2 0 26 0 3 0 26 0 4 0 26 0 5 0 26 0 6 0 26 0 7 0 26 0 9 0 26 0 10 0 26 0 11 0 26 0 12 0 26 0 13 0 26 0 14 0 26 0 16 0 26 0 17 0 26 0 19 0 26 0 20 0 26 0 22 0 26 0 23 0 26 0 24 1 157 0 28 0 26 0 32 1 133 0 39 0 26 0 120 0 26 0 124 0 26 0 125] 
#[0 1 42 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 1 46 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 28 0 32 0 120 0 124 0 125] 
#[0 1 50 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 119 0 120 0 121 0 122 0 124 0 125] 
#[1 1 54 0 1 1 54 0 2 1 54 0 3 1 54 0 4 1 54 0 5 1 54 0 6 1 54 0 7 1 54 0 9 1 54 0 10 1 54 0 11 1 54 0 12 1 54 0 13 1 54 0 14 1 54 0 16 1 54 0 17 1 54 0 18 1 54 0 19 1 54 0 20 1 54 0 21 1 54 0 22 1 54 0 23 1 54 0 24 1 54 0 25 1 54 0 26 1 54 0 27 1 54 0 28 1 54 0 29 1 54 0 30 1 54 0 31 1 54 0 32 2 165 0 45 1 181 0 94 1 185 0 119 1 54 0 120 1 54 0 121 1 54 0 122 1 54 0 124 1 54 0 125] 
#[1 1 58 0 1 1 58 0 2 1 58 0 3 1 58 0 4 1 58 0 5 1 58 0 6 1 58 0 7 1 58 0 9 1 58 0 10 1 58 0 11 1 58 0 12 1 58 0 13 1 58 0 14 1 58 0 16 1 58 0 17 1 58 0 18 1 58 0 19 1 58 0 20 1 58 0 21 1 58 0 22 1 58 0 23 1 58 0 24 1 58 0 25 1 58 0 26 1 58 0 27 1 58 0 28 1 58 0 29 1 58 0 30 1 58 0 31 1 58 0 32 2 169 0 50 1 58 0 119 1 58 0 120 1 58 0 121 1 58 0 122 1 201 0 123 1 58 0 124 1 58 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 2 173 0 70 2 173 0 71 2 173 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 1 62 0 1 1 62 0 2 1 62 0 3 1 62 0 4 1 62 0 5 1 62 0 6 0 35 0 7 1 62 0 9 1 62 0 10 1 62 0 11 1 62 0 12 1 62 0 13 1 62 0 14 1 62 0 16 1 62 0 17 1 62 0 19 1 62 0 20 1 62 0 22 1 62 0 23 1 62 0 24 1 62 0 32 1 141 0 42 1 145 0 44 0 77 0 48 0 81 0 49 0 85 0 51 0 93 0 95 0 39 0 120 1 62 0 124 1 62 0 125] 
#[1 1 66 0 1 1 66 0 2 1 66 0 3 1 66 0 4 1 66 0 5 1 66 0 6 1 66 0 7 1 66 0 9 1 66 0 10 1 66 0 11 1 66 0 12 1 66 0 13 1 66 0 14 1 66 0 16 1 66 0 17 1 66 0 18 1 66 0 19 1 66 0 20 1 66 0 21 1 66 0 22 1 66 0 23 1 66 0 24 1 66 0 25 1 66 0 26 1 66 0 27 1 66 0 28 1 66 0 29 1 66 0 30 1 66 0 31 1 66 0 32 2 177 0 45 1 181 0 94 1 185 0 119 1 66 0 120 1 66 0 121 1 66 0 122 1 66 0 124 1 66 0 125] 
#[1 0 54 0 1 0 54 0 2 0 54 0 3 0 54 0 4 0 54 0 5 0 54 0 6 0 54 0 7 0 54 0 9 0 54 0 10 0 54 0 11 0 54 0 12 0 54 0 13 0 54 0 14 0 54 0 16 0 54 0 17 0 54 0 18 0 54 0 19 0 54 0 20 0 54 0 21 0 54 0 22 0 54 0 23 0 54 0 24 0 54 0 25 0 54 0 26 0 54 0 27 0 54 0 28 0 54 0 29 0 54 0 30 0 54 0 31 0 54 0 32 2 181 0 47 0 54 0 119 0 54 0 120 0 54 0 121 0 54 0 122 0 54 0 124 0 54 0 125] 
#[0 1 70 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 119 0 120 0 121 0 122 0 124 0 125] 
#[0 2 185 0 121] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 125 0 7 2 189 0 9 0 181 0 44 0 85 0 51 2 193 0 91 2 193 0 92 2 193 0 93 0 93 0 95 0 97 0 120] 
#[0 1 74 0 26 0 32 0 124 0 125] 
#[1 2 197 0 18 0 18 0 119] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 2 201 0 57 2 201 0 91 2 201 0 92 2 201 0 93 0 93 0 95 2 201 0 104 2 201 0 105 2 201 0 106 2 201 0 107 2 201 0 110 2 201 0 113 2 201 0 114 2 201 0 115 2 201 0 116 1 65 0 117 0 97 0 120] 
#[1 2 213 0 18 1 149 0 21 1 153 0 122] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 2 217 0 57 2 217 0 91 2 217 0 92 2 217 0 93 0 93 0 95 2 217 0 104 2 217 0 105 2 217 0 106 2 217 0 107 2 217 0 110 2 217 0 113 2 217 0 114 2 217 0 115 2 217 0 116 1 65 0 117 0 97 0 120] 
#[0 1 78 0 7 0 18 0 28 0 120] 
#[1 1 137 0 7 2 221 0 18 1 221 0 28 1 145 0 44 1 229 0 49 0 85 0 51 2 225 0 55 1 241 0 59 2 229 0 60 0 93 0 95 0 97 0 120] 
#[0 1 82 0 7 0 18 0 120] 
#[1 1 137 0 7 2 233 0 18 1 145 0 44 1 229 0 49 0 85 0 51 2 237 0 59 0 93 0 95 0 97 0 120] 
#[1 1 86 0 1 1 86 0 2 1 86 0 3 1 86 0 4 1 86 0 5 1 86 0 6 1 86 0 7 1 86 0 9 1 86 0 10 1 86 0 11 1 86 0 12 1 86 0 13 1 86 0 14 1 86 0 16 1 86 0 17 2 241 0 18 1 86 0 19 1 86 0 20 1 86 0 22 1 86 0 23 1 86 0 24 1 86 0 32 1 86 0 120 1 86 0 124 1 86 0 125] 
#[0 1 90 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 2 245 0 27 2 49 0 32] 
#[1 1 94 0 27 1 94 0 32 2 249 0 99] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 125 0 7 0 181 0 44 0 85 0 51 2 253 0 91 2 253 0 92 2 253 0 93 0 93 0 95 0 97 0 120] 
#[0 1 98 0 9 0 21 0 26] 
#[1 3 1 0 9 2 9 0 21 3 5 0 26 3 9 0 101] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 129 0 9 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 10 0 26 0 177 0 32 0 181 0 44 0 85 0 51 0 205 0 63 3 13 0 64 3 17 0 65 0 217 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 0 43 0 125] 
#[0 3 21 0 25] 
#[1 0 145 0 13 0 149 0 14 3 25 0 26 3 33 0 106 3 33 0 112 3 37 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 2 49 0 32 0 181 0 44 0 85 0 51 3 41 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 102 0 124 1 69 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 157 0 17 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 177 0 32 0 181 0 44 0 85 0 51 3 45 0 52 0 189 0 53 0 193 0 54 0 193 0 58 3 49 0 63 3 53 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 106 0 124 1 69 0 125] 
#[0 1 110 0 124] 
#[0 1 114 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 1 118 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 27 0 32 0 120 0 124 0 125] 
#[0 1 122 0 26 0 124 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 177 0 32 0 181 0 44 0 85 0 51 3 57 0 63 3 61 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 126 0 124 1 69 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 1 130 0 26 2 49 0 32 0 181 0 44 0 85 0 51 3 65 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 130 0 124 0 47 0 125] 
#[0 1 134 0 26 0 124 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 1 138 0 26 2 49 0 32 0 181 0 44 0 85 0 51 3 69 0 69 3 69 0 70 3 69 0 71 3 69 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 138 0 124 0 51 0 125] 
#[1 2 133 0 7 2 89 0 28 2 93 0 29 3 73 0 44 2 97 0 49 0 85 0 51 3 77 0 75 3 77 0 78 2 105 0 79 2 109 0 80 3 77 0 81 2 117 0 82 2 121 0 83 3 77 0 86 3 77 0 89 3 77 0 90 0 93 0 95 0 97 0 120] 
#[0 1 142 0 25 0 26 0 27 0 32 0 121 0 124 0 125] 
#[0 1 146 0 25 0 26 0 27 0 30 0 32 0 121 0 124 0 125] 
#[1 1 150 0 25 1 150 0 26 1 150 0 27 2 73 0 30 1 150 0 32 3 93 0 73 1 150 0 121 1 150 0 124 1 150 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 3 97 0 84 1 89 0 85 0 253 0 87 1 93 0 88 0 253 0 91 0 253 0 92 0 253 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 3 101 0 87 1 93 0 88 3 101 0 91 3 101 0 92 3 101 0 93 0 93 0 95 3 101 0 96 3 101 0 97 3 101 0 100 3 101 0 104 3 101 0 105 3 101 0 106 3 101 0 107 3 101 0 110 3 101 0 113 3 101 0 114 3 101 0 115 3 101 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 3 105 0 84 1 89 0 85 0 253 0 87 1 93 0 88 0 253 0 91 0 253 0 92 0 253 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[0 1 154 0 25 0 26 0 27 0 30 0 32 0 121 0 124 0 125] 
#[0 1 158 0 7 0 25 0 26 0 27 0 28 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 1 137 0 7 1 162 0 25 1 162 0 26 1 162 0 27 2 89 0 28 1 162 0 30 1 162 0 32 1 145 0 44 2 97 0 49 0 85 0 51 3 109 0 79 2 117 0 82 3 113 0 83 0 93 0 95 0 97 0 120 1 162 0 121 1 162 0 124 1 162 0 125] 
#[0 1 166 0 25 0 26 0 27 0 30 0 32 0 121 0 124 0 125] 
#[0 1 170 0 7 0 25 0 26 0 27 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 1 137 0 7 1 174 0 25 1 174 0 26 1 174 0 27 1 174 0 30 1 174 0 32 1 145 0 44 2 97 0 49 0 85 0 51 3 117 0 82 0 93 0 95 0 97 0 120 1 174 0 121 1 174 0 124 1 174 0 125] 
#[0 1 178 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 1 182 0 25 0 26 0 27 0 32 0 121 0 124 0 125] 
#[1 1 186 0 7 1 186 0 25 1 186 0 26 1 186 0 27 1 186 0 28 1 186 0 29 1 186 0 30 1 186 0 32 0 18 0 119 1 186 0 120 1 186 0 121 1 186 0 124 1 186 0 125] 
#[0 1 190 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 1 194 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 1 198 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 1 202 0 25 0 26 0 27 0 32 0 121 0 124 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 181 0 44 0 85 0 51 3 121 0 70 3 121 0 71 3 121 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[1 1 206 0 4 1 206 0 5 1 206 0 6 1 206 0 7 1 206 0 10 1 206 0 11 1 206 0 12 1 206 0 13 1 206 0 14 1 206 0 15 1 206 0 16 1 206 0 22 1 206 0 23 1 206 0 24 1 206 0 25 1 206 0 29 1 206 0 30 1 206 0 32 3 125 0 108 1 206 0 125] 
#[0 1 210 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 1 214 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 119 0 120 0 121 0 122 0 124 0 125] 
#[0 1 218 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 119 0 120 0 121 0 122 0 124 0 125] 
#[0 3 129 0 121] 
#[0 1 222 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 119 0 120 0 121 0 122 0 124 0 125] 
#[1 1 226 0 1 1 226 0 2 1 226 0 3 1 226 0 4 1 226 0 5 1 226 0 6 1 226 0 7 1 226 0 9 1 226 0 10 1 226 0 11 1 226 0 12 1 226 0 13 1 226 0 14 1 226 0 16 1 226 0 17 1 226 0 18 1 226 0 19 1 226 0 20 1 226 0 21 1 226 0 22 1 226 0 23 1 226 0 24 1 226 0 25 1 226 0 26 1 226 0 27 1 226 0 28 1 226 0 29 1 226 0 30 1 226 0 31 1 226 0 32 2 177 0 45 1 181 0 94 1 185 0 119 1 226 0 120 1 226 0 121 1 226 0 122 1 226 0 124 1 226 0 125] 
#[0 1 230 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 119 0 120 0 121 0 122 0 123 0 124 0 125] 
#[0 1 234 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 26 0 32 0 120 0 124 0 125] 
#[0 1 238 0 1 0 2 0 3 0 7 0 9 0 120] 
#[0 1 242 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 1 246 0 7 0 18 0 28 0 120] 
#[0 1 250 0 7 0 18 0 28 0 120] 
#[0 1 254 0 7 0 18 0 28 0 120] 
#[0 2 2 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[1 2 6 0 7 2 6 0 18 1 221 0 28 1 233 0 55 3 133 0 56 2 6 0 120] 
#[0 2 10 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 2 14 0 7 0 18 0 28 0 120] 
#[1 1 137 0 7 3 137 0 18 1 145 0 44 1 229 0 49 0 85 0 51 2 237 0 59 0 93 0 95 0 97 0 120] 
#[0 2 18 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 2 22 0 7 0 18 0 120] 
#[0 2 26 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 2 30 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 3 141 0 27 0 177 0 32 3 145 0 63 3 149 0 98] 
#[0 2 34 0 9 0 21 0 26] 
#[0 2 38 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 19 0 20 0 22 0 23 0 24 0 26 0 32 0 120 0 125] 
#[0 2 42 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 2 46 0 9 0 21 0 26] 
#[1 3 153 0 26 3 157 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 150 0 26 0 177 0 32 0 181 0 44 0 85 0 51 2 61 0 63 2 65 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 0 55 0 125] 
#[0 2 50 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 2 54 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 2 58 0 13 0 14 0 26 0 125] 
#[0 2 62 0 13 0 14 0 26 0 125] 
#[0 2 66 0 13 0 14 0 26 0 125] 
#[0 2 70 0 124] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 0 177 0 32 0 181 0 44 0 85 0 51 3 161 0 63 3 165 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 2 74 0 124 1 69 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 2 49 0 32 0 181 0 44 0 85 0 51 3 169 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 2 78 0 124 1 69 0 125] 
#[0 2 82 0 124] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 2 49 0 32 0 181 0 44 0 85 0 51 3 173 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 2 86 0 124 1 69 0 125] 
#[0 2 90 0 124] 
#[0 2 94 0 26 0 124 0 125] 
#[0 2 98 0 26 0 32 0 124 0 125] 
#[1 1 149 0 21 1 190 0 25 1 190 0 26 1 190 0 27 1 190 0 30 1 190 0 32 1 190 0 121 1 153 0 122 1 190 0 124 1 190 0 125] 
#[0 2 102 0 25 0 26 0 27 0 30 0 32 0 121 0 124 0 125] 
#[0 2 106 0 25 0 26 0 27 0 30 0 32 0 121 0 124 0 125] 
#[0 2 110 0 25 0 26 0 27 0 30 0 32 0 121 0 124 0 125] 
#[0 2 114 0 25 0 26 0 27 0 30 0 32 0 121 0 124 0 125] 
#[0 2 118 0 25 0 26 0 27 0 30 0 32 0 121 0 124 0 125] 
#[1 2 122 0 7 2 122 0 25 2 122 0 26 2 122 0 27 2 122 0 28 2 93 0 29 2 122 0 30 2 122 0 32 2 125 0 86 2 122 0 120 2 122 0 121 2 122 0 124 2 122 0 125] 
#[1 0 59 0 7 2 126 0 25 2 126 0 26 2 126 0 27 2 126 0 28 2 126 0 29 2 126 0 30 2 126 0 32 2 137 0 44 0 85 0 51 2 141 0 89 2 141 0 90 0 93 0 95 0 63 0 120 2 126 0 121 2 126 0 124 2 126 0 125] 
#[1 2 130 0 7 2 130 0 25 2 130 0 26 2 130 0 27 2 89 0 28 2 93 0 29 2 130 0 30 2 130 0 32 2 105 0 79 3 177 0 80 2 125 0 86 2 130 0 120 2 130 0 121 2 130 0 124 2 130 0 125] 
#[0 2 134 0 7 0 25 0 26 0 27 0 28 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 1 137 0 7 2 138 0 25 2 138 0 26 2 138 0 27 2 138 0 30 2 138 0 32 1 145 0 44 2 97 0 49 0 85 0 51 3 117 0 82 0 93 0 95 0 97 0 120 2 138 0 121 2 138 0 124 2 138 0 125] 
#[0 2 142 0 7 0 25 0 26 0 27 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 2 146 0 25 0 26 0 27 0 32 0 121 0 124 0 125] 
#[1 0 113 0 4 0 117 0 5 0 121 0 6 3 181 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 3 185 0 15 3 189 0 16 3 193 0 22 0 6 0 23 0 173 0 24 2 150 0 25 3 197 0 29 3 201 0 30 3 205 0 32 3 213 0 104 3 213 0 105 3 213 0 106 3 213 0 107 3 213 0 109 3 213 0 110 3 213 0 113 3 213 0 114 3 213 0 115 3 213 0 116 1 65 0 117 3 217 0 118 3 221 0 125] 
#[0 2 154 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 18 0 19 0 20 0 21 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 119 0 120 0 121 0 122 0 123 0 124 0 125] 
#[1 2 158 0 7 2 158 0 18 1 221 0 28 2 225 0 55 2 158 0 120] 
#[0 2 162 0 1 0 2 0 3 0 4 0 5 0 6 0 7 0 9 0 10 0 11 0 12 0 13 0 14 0 16 0 17 0 19 0 20 0 22 0 23 0 24 0 32 0 120 0 124 0 125] 
#[0 2 166 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 3 225 0 27 2 49 0 32 0 181 0 44 0 85 0 51 3 229 0 70 3 229 0 71 3 229 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 1 69 0 125] 
#[0 2 170 0 27 0 32] 
#[0 2 174 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 2 178 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[1 0 101 0 1 0 105 0 2 0 109 0 3 0 113 0 4 0 117 0 5 0 121 0 6 0 125 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 0 153 0 16 0 161 0 19 0 165 0 20 0 169 0 22 0 6 0 23 0 173 0 24 2 49 0 32 0 181 0 44 0 85 0 51 3 233 0 67 0 221 0 68 0 225 0 69 0 225 0 70 0 225 0 71 0 225 0 76 0 241 0 77 0 245 0 84 0 249 0 85 0 253 0 87 1 1 0 88 1 5 0 91 1 5 0 92 1 5 0 93 0 93 0 95 0 253 0 96 0 253 0 97 0 253 0 100 0 253 0 104 0 253 0 105 0 253 0 106 0 253 0 107 0 253 0 110 0 253 0 113 0 253 0 114 0 253 0 115 0 253 0 116 1 65 0 117 0 97 0 120 2 182 0 124 1 69 0 125] 
#[0 2 186 0 124] 
#[0 2 190 0 124] 
#[0 2 194 0 124] 
#[1 2 198 0 7 2 198 0 25 2 198 0 26 2 198 0 27 2 89 0 28 2 198 0 30 2 198 0 32 3 109 0 79 2 198 0 120 2 198 0 121 2 198 0 124 2 198 0 125] 
#[0 2 202 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[0 2 206 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[0 2 210 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[1 1 206 0 4 1 206 0 5 1 206 0 6 1 206 0 7 1 206 0 10 1 206 0 11 1 206 0 12 1 206 0 13 1 206 0 14 1 206 0 15 1 206 0 16 1 206 0 22 1 206 0 23 1 206 0 24 1 206 0 25 1 206 0 29 1 206 0 30 1 206 0 32 3 237 0 108 1 206 0 125] 
#[0 2 214 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[0 2 218 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[0 2 222 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[0 2 226 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[0 2 230 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[0 3 241 0 25] 
#[0 2 234 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125] 
#[0 2 238 0 7 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 2 242 0 27 0 32] 
#[0 2 246 0 124] 
#[1 0 113 0 4 0 117 0 5 0 121 0 6 3 181 0 7 0 133 0 10 0 137 0 11 0 141 0 12 0 145 0 13 0 149 0 14 3 185 0 15 3 189 0 16 3 193 0 22 0 6 0 23 0 173 0 24 3 245 0 25 3 197 0 29 3 201 0 30 3 205 0 32 3 213 0 104 3 213 0 105 3 213 0 106 3 213 0 107 3 213 0 109 3 213 0 110 3 213 0 113 3 213 0 114 3 213 0 115 3 213 0 116 1 65 0 117 3 221 0 125] 
#[0 2 250 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 18 0 22 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 32 0 120 0 121 0 124 0 125] 
#[0 2 254 0 4 0 5 0 6 0 7 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 22 0 23 0 24 0 25 0 29 0 30 0 32 0 125]
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
GtPharoParser >> reduceActionForArrayLiteralValue8: nodes [
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
GtPharoParser >> reduceActionForMethodPattern2: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result addNode: (nodes at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern3: nodes [
	| result |
	result := GtPharoMethodPatternNode new.
	result addTokens: ((nodes at: 1) at: 1) to: result selectorParts.
	result addNodes: ((nodes at: 1) at: 2) to: result variables.
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern6: nodes [
	| result |
	result := GtPharoErrorPatternNode new.
	result addToken: (nodes at: 1) to: result selectorParts.
	result smaccError: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
GtPharoParser >> reduceActionForMethodPattern7: nodes [
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
GtPharoParser >> reduceActionFor__keyword___selectorPart__Variable__variable__1: nodes [
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

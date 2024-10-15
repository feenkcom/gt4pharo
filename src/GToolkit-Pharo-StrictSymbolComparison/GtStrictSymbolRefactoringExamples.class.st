Class {
	#name : #GtStrictSymbolRefactoringExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'GToolkit-Pharo-StrictSymbolComparison-Examples'
}

{ #category : #'private - support' }
GtStrictSymbolRefactoringExamples >> logMessages: aCollection [
	| scenario logger signalState |

	scenario := GtStrictSymbolScenarios new.
	logger := GtStrictSymbolComparisonSummaryLogger new.
	logger start.
	[ signalState := GtStrictSymbolEqualityArgumentSignal clearLogStringOnly.
	GtStrictSymbolEqualityArgumentSignal start.
	aCollection do: [ :message |
		message sendTo: scenario ] ]
			ensure: 
				[ GtStrictSymbolEqualityArgumentSignal stop.
				GtStrictSymbolEqualityArgumentSignal setFrom: signalState.
				logger stop ].
	^ logger
]

{ #category : #examples }
GtStrictSymbolRefactoringExamples >> refactorMixedParameterToStringLiteral [
	"Demonstrate refactoring an equality comparison of a variable to a string
	where the variable is always a string."
	<gtExample>
	| signalGroup refactoredAst signalSummary strictSymbolRefactor |

	signalGroup := self logMessages: {
		Message selector: #compareParameterToString: argument: 'a'.
		Message selector: #compareParameterToString: argument: #a. }.
	signalSummary := (signalGroup byMethod at:
		'GtStrictSymbolScenarios>>#compareParameterToString:') first.
	strictSymbolRefactor := signalSummary strictSymbolRefactor.
	refactoredAst := strictSymbolRefactor refactoredAst.
	self assert: strictSymbolRefactor isChanged.
	self assert: refactoredAst  newSource equals:
'compareParameterToString: aString
	"aString = ''a''"

	^ aString sameContentAs: ''a''' withInternalLineEndings.
	^ refactoredAst
]

{ #category : #examples }
GtStrictSymbolRefactoringExamples >> refactorObjectParameters [
	"Demonstrate refactoring an equality comparison of two variables
	where."
	<gtExample>
	| signalGroup refactoredAst signalSummary strictSymbolRefactor |

	signalGroup := self logMessages: {
		Message selector: #compareParameter:to: arguments: { 'p2'. Object new. } }.
	signalSummary := (signalGroup byMethod at:
		'GtStrictSymbolScenarios>>#compareParameter:to:') first.
	strictSymbolRefactor := signalSummary strictSymbolRefactor.
	refactoredAst := strictSymbolRefactor refactoredAst.
	self assert: strictSymbolRefactor isChanged.
	self assert: refactoredAst  newSource equals:
'compareParameter: param1 to: param2
	"param1 = param2"

	^ param1 sameContentAs: param2' withInternalLineEndings.
	^ refactoredAst
]

{ #category : #examples }
GtStrictSymbolRefactoringExamples >> refactorStringLiteralToMixedParameter [
	"Demonstrate refactoring an equality comparison of a variable to a string
	where the variable is always a string."
	<gtExample>
	| signalGroup refactoredAst signalSummary strictSymbolRefactor |

	signalGroup := self logMessages: {
		Message selector: #compareStringToParameter: argument: 'a'.
		Message selector: #compareStringToParameter: argument: #a. }.
	signalSummary := (signalGroup byMethod at:
		'GtStrictSymbolScenarios>>#compareStringToParameter:') first.
	strictSymbolRefactor := signalSummary strictSymbolRefactor.
	refactoredAst := strictSymbolRefactor refactoredAst.
	self assert: strictSymbolRefactor isChanged.
	self assert: refactoredAst  newSource equals:
'compareStringToParameter: aString
	"''a'' = aString"

	^ ''a'' sameContentAs: aString' withInternalLineEndings.
	^ refactoredAst
]

{ #category : #examples }
GtStrictSymbolRefactoringExamples >> refactorStringLiteralToStringParameter [
	"Demonstrate refactoring an equality comparison of a variable to a string
	where the variable is always a string."
	<gtExample>
	| signalGroup refactoredAst signalSummary strictSymbolRefactor |

	signalGroup := self logMessages: {
		Message selector: #compareStringToParameter: argument: 'a'. }.
	signalSummary := (signalGroup byMethod at:
		'GtStrictSymbolScenarios>>#compareStringToParameter:') first.
	strictSymbolRefactor := signalSummary strictSymbolRefactor.
	refactoredAst := strictSymbolRefactor refactoredAst.
	self deny: strictSymbolRefactor isChanged.
	self assert: refactoredAst newSource equals:
'compareStringToParameter: aString
	"''a'' = aString"

	^ ''a'' = aString' withInternalLineEndings.
	^ refactoredAst
]

{ #category : #examples }
GtStrictSymbolRefactoringExamples >> refactorStringParameterToStringLiteral [
	"Demonstrate refactoring an equality comparison of a variable to a string
	where the variable is always a string."
	<gtExample>
	| signalGroup refactoredAst signalSummary strictSymbolRefactor |

	signalGroup := self logMessages: {
		Message selector: #compareParameterToString: argument: 'a'. }.
	signalSummary := (signalGroup byMethod at:
		'GtStrictSymbolScenarios>>#compareParameterToString:') first.
	strictSymbolRefactor := signalSummary strictSymbolRefactor.
	refactoredAst := strictSymbolRefactor refactoredAst.
	self deny: strictSymbolRefactor isChanged.
	self assert: refactoredAst newSource equals:
'compareParameterToString: aString
	"aString = ''a''"

	^ aString = ''a''' withInternalLineEndings.
	^ refactoredAst
]

{ #category : #examples }
GtStrictSymbolRefactoringExamples >> refactorStringParameterToSymbolLiteral [
	"Demonstrate refactoring an equality comparison of a variable to a string
	where the variable is always a string."
	<gtExample>
	| signalGroup refactoredAst signalSummary strictSymbolRefactor |

	signalGroup := self logMessages: {
		Message selector: #compareParameterToSymbol: argument: 'a'. }.
	signalSummary := (signalGroup byMethod at:
		'GtStrictSymbolScenarios>>#compareParameterToSymbol:') first.
	strictSymbolRefactor := signalSummary strictSymbolRefactor.
	refactoredAst := strictSymbolRefactor refactoredAst.
	self assert: strictSymbolRefactor isChanged.
	self assert: refactoredAst newSource equals: 
'compareParameterToSymbol: aSymbol
	"aSymbol = #a"

	<gtSymbolStrictComparison>
	^ aSymbol = ''a''' withInternalLineEndings.
	^ refactoredAst
]

{ #category : #examples }
GtStrictSymbolRefactoringExamples >> refactorStringParameters [
	"Demonstrate refactoring an equality comparison of two variables
	where the variables are always a string."
	<gtExample>
	| signalGroup refactoredAst signalSummary strictSymbolRefactor |

	signalGroup := self logMessages: {
		Message selector: #compareParameter:to: arguments: { 'p1'. 'p2'. } }.
	signalSummary := (signalGroup byMethod at:
		'GtStrictSymbolScenarios>>#compareParameter:to:') first.
	strictSymbolRefactor := signalSummary strictSymbolRefactor.
	refactoredAst := strictSymbolRefactor refactoredAst.
	self deny: strictSymbolRefactor isChanged.
	self assert: refactoredAst  newSource equals:
'compareParameter: param1 to: param2
	"param1 = param2"

	^ param1 = param2' withInternalLineEndings.
	^ refactoredAst
]

{ #category : #examples }
GtStrictSymbolRefactoringExamples >> refactorSymbolParameterToStringLiteral [
	"Demonstrate refactoring an equality comparison of a variable to a string
	where the variable is always a string."
	<gtExample>
	| signalGroup refactoredAst signalSummary strictSymbolRefactor |

	signalGroup := self logMessages: {
		Message selector: #compareParameterToString: argument: #a. }.
	signalSummary := (signalGroup byMethod at:
		'GtStrictSymbolScenarios>>#compareParameterToString:') first.
	strictSymbolRefactor := signalSummary strictSymbolRefactor.
	refactoredAst := strictSymbolRefactor refactoredAst.
	self assert: strictSymbolRefactor isChanged.
	self assert: refactoredAst newSource equals:
'compareParameterToString: aString
	"aString = ''a''"

	<gtSymbolStrictComparison>
	^ aString = #a' withInternalLineEndings.
	^ refactoredAst
]

"
# Source coder
I am a coder for the source code. I know about the `sourceCode` ({{gtClass:GtCoderTextSource}}) and `completionStrategy` ({{gtClass:GtCompletionStrategy}}).
## Actions
All source coders know about basic actions such as code evaluation (`do it all, do it and go, do it selection and go`) or different browsing abilities. Those actions can only be executed in a presence of a text editor UI element that is passed as an argument. It is required to provide a text editor element in order to get information about cursor position or current selection, in addition to being able to have a UI context to notify user or provide her with a feedback of the executed action. All actions are always performed on the current source code text (expanded/collapsed state is not taken into account).
## Add-ons
The source coder extends the addons ({{gtClass:GtCoderAddOns}}) with extra stylers (see {{gtClass:GtTextualCoderAddOns}}) that allows users to add extra contextual information within the text editor via text attributes.
## Implementation details
It is important to notice that I do not directly reference a text editor and I should not store any UI related information such as cursor position or selection.


"
Class {
	#name : #GtPharoSourceCoder,
	#superclass : #GtSmalltalkSourceCoder,
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'private - actions' }
GtPharoSourceCoder class >> debug: aCompiledMethod receiver: anObject in: evalContext coderEvaluationContext: aCoderEvaluationContext [
	| guineaPig suspendedContext debugSession |
	guineaPig := aCompiledMethod isDoIt
			ifTrue: [ [ aCompiledMethod
					valueWithReceiver: anObject
					arguments: (evalContext
							ifNil: [ #() ]
							ifNotNil: [ aCompiledMethod numArgs = 0 ifTrue: [ #() ] ifFalse: [ {evalContext} ] ]) ]
					newProcess ]
			ifFalse: [ | evaluationArguments |
				evaluationArguments := GtPharoMethodArgumentsCollector new
						evaluationContext: aCoderEvaluationContext;
						compiledMethod: aCompiledMethod;
						collect.

				[ aCompiledMethod 
					valueWithReceiver: anObject 
					arguments: evaluationArguments ]
						newProcess ].
	suspendedContext := guineaPig suspendedContext.
	GtProcessStackOverflowChecker currentCheckerClass startForProcess: guineaPig.
	debugSession := guineaPig
			newDebugSessionNamed: 'debug it'
			startedAt: suspendedContext.
	debugSession
		stepIntoUntil: [ :currentContext | currentContext method == aCompiledMethod ].

	Smalltalk tools debugger openOn: debugSession withFullView: true
]

{ #category : #'api - accessing' }
GtPharoSourceCoder >> behavior [
	"Return an optional Behavior in context of which this coder operates.
	Behavior (class, metaclass or trait) helps various add-ons and styler to provide users with better
	contextual information"
	<return: #Behavior>
	
	^ UndefinedObject
]

{ #category : #'api - actions examples' }
GtPharoSourceCoder >> canExecuteExample [
	<return: #Boolean>

	^ false
]

{ #category : #private }
GtPharoSourceCoder >> classOrMetaClass [
	self
		deprecated: 'Use #behavior instead.'
		transformWith: '`@receiver classOrMetaClass' -> '`@receiver behavior'.
		
	^ self behavior
]

{ #category : #'private - actions' }
GtPharoSourceCoder >> compilerErrorsToHandle [
	^ self 
		forPharo12AndNewer: [OCUndeclaredVariableWarning, #CodeError asClass] 
		forPharo11: [OCSemanticWarning]
]

{ #category : #'private - ast' }
GtPharoSourceCoder >> detectReferencesFilterAt: aTextPosition ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self 
		detectReferencesFilterAt: aTextPosition 
		withBehavior: self behavior
		ifFound: aFoundBlock 
		ifNone: aNoneBlock
]

{ #category : #'private - ast' }
GtPharoSourceCoder >> detectReferencesFilterIn: aSourceString ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self 
		detectReferencesFilterIn: aSourceString 
		withBehavior: self behavior
		ifFound: aFoundBlock 
		ifNone: aNoneBlock
]

{ #category : #'api - actions' }
GtPharoSourceCoder >> format [
	self formatWithRequesterObject: nil
]

{ #category : #'api - actions' }
GtPharoSourceCoder >> formatWithRequesterObject: aRequester [
	| ast |
	ast := [ RBParser parseExpression: self currentSourceString ]
			on: RBParser gtParseErrorClass
			do: [ :ex | ^ self notifyParseError: ex requesterObject: aRequester ].

	self currentSourceString: ast formattedCode
]

{ #category : #'private - actions' }
GtPharoSourceCoder >> handleCompilerErrorsDuring: aBlock inContext: aGtPharoSourceCoderEvaluationContext [
	^ [ aBlock value.
	true ]
		on: self compilerErrorsToHandle
		do: [ :ex | 
			self
				notifyParseError: ex
				requesterObject: aGtPharoSourceCoderEvaluationContext requesterObject.
			ex return: false ]
]

{ #category : #testing }
GtPharoSourceCoder >> hasObjectAttribute [
	<return: #Boolean>

	^ false
]

{ #category : #testing }
GtPharoSourceCoder >> isForMethod [
	^ false
]

{ #category : #'api - accessing' }
GtPharoSourceCoder >> methodBehavior [
	"Return an optional method behavior in context of which this coder operates.
	The method behavior (class, metaclass or trait) helps various add-ons and styler to provide users with better
	contextual information"

	<return: #GtPharoCoderBehavior>
	^ GtPharoCoderBehavior unspecified
]

{ #category : #'private - actions' }
GtPharoSourceCoder >> newEvaluationContext [
	^ GtPharoSourceCoderEvaluationContext new
]

{ #category : #'private - ast rb' }
GtPharoSourceCoder >> newRbAST: aString [
	| ast |
	ast := self parseExpression: aString requestor: nil.
	ast doSemanticAnalysis.
	^ ast
]

{ #category : #'private - refactorings' }
GtPharoSourceCoder >> nodeDescription: aNode [
	| description |
	description := aNode source asString.
	description size > 40
		ifTrue: [ description := (description first: 40) , '...' ].
	^ ((description copyReplaceAll: String cr with: ' ')
		copyReplaceAll: String lf
		with: ' ') copyReplaceAll: '	' with: ' '
]

{ #category : #'api - accessing' }
GtPharoSourceCoder >> object [
	"Deprecated! Use GtPharoSourceCoderViewModel>>#selfObject: instead"
	<return: #Object or: nil>

	self deprecated: 'Use GtPharoSourceCoderViewModel>>#selfObject instead'.

	^ nil
]

{ #category : #'api - accessing' }
GtPharoSourceCoder >> object: anObject [
	"Set an object in the context of which the source code should be modified (may influence self binding)"

	self deprecated: 'Use GtPharoSourceCoderViewModel>>#selfObject: instead'.
]

{ #category : #accessing }
GtPharoSourceCoder >> package [
	^ self attributeNamed: #package
]

{ #category : #accessing }
GtPharoSourceCoder >> packageTag [
	^ self attributeNamed: #packageTag
]

{ #category : #'private - ast rb' }
GtPharoSourceCoder >> parse: aString asExpression: isExpression requestor: aRequestor [
	^ (self behavior ifNil: [ UndefinedObject ]) compiler
		source: aString;
		isScripting: isExpression;
		options: #(+ optionParseErrors + optionSkipSemanticWarnings);
		requestor: aRequestor;
		parse
]

{ #category : #'private - ast rb' }
GtPharoSourceCoder >> parseExpression: aString requestor: aRequestor [
	^ self parse: aString asExpression: true requestor: aRequestor
]

{ #category : #'private - ast rb' }
GtPharoSourceCoder >> parseMethod: aString [
	^ self parse: aString asExpression: false requestor: nil
]

{ #category : #'private - actions' }
GtPharoSourceCoder >> primitiveCompile: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	<return: #CompiledMethod>
	| isForMethod methodClass |
	isForMethod := self isForMethod
			and: [ aGtPharoSourceCoderEvaluationContext evaluatedInterval
					= (1 to: aGtPharoSourceCoderEvaluationContext sourceString size) ].

	(isForMethod not
		and: [ aGtPharoSourceCoderEvaluationContext receiverObject isNil
				and: [ aGtPharoSourceCoderEvaluationContext runtimeContext isNil ] ])
		ifTrue: [ aGtPharoSourceCoderEvaluationContext withSnippetBindingStrategy ].

	methodClass := aGtPharoSourceCoderEvaluationContext runtimeContext
			ifNil: [ aGtPharoSourceCoderEvaluationContext receiverObject class ]
			ifNotNil: [ :aContext | aContext methodClass ].

	^ GtPharoCodeModifier current
		critical: [ | compiler |
			compiler := self class compiler.
			compiler source: aSourceString.
			compiler class: methodClass.
			(isForMethod not
				and: [ aGtPharoSourceCoderEvaluationContext receiverObject notNil ])
				ifTrue: [ compiler receiver: aGtPharoSourceCoderEvaluationContext receiverObject ].
			compiler context: aGtPharoSourceCoderEvaluationContext runtimeContext.
			compiler requestor: aGtPharoSourceCoderEvaluationContext.
			compiler isScripting: isForMethod not.
			compiler failBlock: anEvaluationFailBlock.
			compiler compile ]
]

{ #category : #'private - actions' }
GtPharoSourceCoder >> primitiveDebug: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| aCompiledMethodToDebug |
	aCompiledMethodToDebug := self
			primitiveCompile: aSourceString
			inContext: aGtPharoSourceCoderEvaluationContext
			onFailDo: [ ^ anEvaluationFailBlock value ].

	self class
		debug: aCompiledMethodToDebug
		receiver: aGtPharoSourceCoderEvaluationContext receiverObject
		in: aGtPharoSourceCoderEvaluationContext runtimeContext
		coderEvaluationContext: aGtPharoSourceCoderEvaluationContext
]

{ #category : #'private - actions' }
GtPharoSourceCoder >> primitiveEvaluate: aSourceString inContext: aGtPharoSourceCoderEvaluationContext onFailDo: anEvaluationFailBlock [
	| aCompiledMethodToEvaluate methodArguments |

	(self
		handleCompilerErrorsDuring: [ aCompiledMethodToEvaluate := self
					primitiveCompile: aSourceString
					inContext: aGtPharoSourceCoderEvaluationContext
					onFailDo: [ ^ anEvaluationFailBlock value ] ]
		inContext: aGtPharoSourceCoderEvaluationContext)
		ifFalse: [ ^ anEvaluationFailBlock value ].

	methodArguments := #().

	aGtPharoSourceCoderEvaluationContext evaluatedCode: (
		GtPharoEvaluatedCode new 
			receiverObject: aGtPharoSourceCoderEvaluationContext receiverObject;
			compiledMethod: aCompiledMethodToEvaluate;
			methodArguments: methodArguments).
					
	^ GtProcessStackOverflowChecker currentCheckerClass checkDuring:		[
		aGtPharoSourceCoderEvaluationContext receiverObject
			withArgs: methodArguments
			executeMethod: aCompiledMethodToEvaluate ].
]

{ #category : #accessing }
GtPharoSourceCoder >> protocol [
	"Ideally, it would return a protocol object
	and #protocolName a protocol name string."

	<return: #String or: nil>
	^ self protocolName
]

{ #category : #accessing }
GtPharoSourceCoder >> protocolName [
	"Exists as in Pharo 12 CompiledMethod>>protocol returns a protocol Object"
	^ #accessing
]

{ #category : #'private - ast rb' }
GtPharoSourceCoder >> rbAST [
	| source |

	"The AST should be built out of the `characters` of the source text.
	This is needed to support `crlf` and logical items
	see https://github.com/feenkcom/gtoolkit/issues/593"
	source := self currentSourceString.
	^ [ self newRbAST: source ]
		on: Error
		do: [ :ex | ex return: nil ]
]

{ #category : #accessing }
GtPharoSourceCoder >> selector: aSymbol [
	"default to ignore selector changes"
]

{ #category : #'api - accessing' }
GtPharoSourceCoder >> source [
	<return: #String>

	self
		deprecated: 'Use #currentSourceString instead'
		transformWith: '`@receiver source' -> '`@receiver currentSourceString'.
		
	^ self currentSourceString
]

{ #category : #accessing }
GtPharoSourceCoder >> targetAstParserClass [
	^ GtPharoParser
]

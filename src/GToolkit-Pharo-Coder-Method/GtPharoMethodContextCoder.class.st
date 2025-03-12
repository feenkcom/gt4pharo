Class {
	#name : #GtPharoMethodContextCoder,
	#superclass : #GtPharoMethodCoder,
	#instVars : [
		'context',
		'session',
		'originalCompiledCode'
	],
	#category : #'GToolkit-Pharo-Coder-Method-Coder'
}

{ #category : #'instance creation' }
GtPharoMethodContextCoder class >> forContext: aContext session: aDebugSession [

	^ self new
		  forContext: aContext session: aDebugSession;
		  yourself
]

{ #category : #'debugger access' }
GtPharoMethodContextCoder >> close [
	self notifyDebugger.
	
	"self flag: 'check why this is needed'.
	self updateSelection"
]

{ #category : #'api - actions' }
GtPharoMethodContextCoder >> compileInContext: aGtPharoSourceCoderEvaluationContext [
	| withoutErrors compiledSuccesfully |
	self session
		ifNil: [ ^ super compileInContext: aGtPharoSourceCoderEvaluationContext ].

	compiledSuccesfully := false.
	withoutErrors := self
			handleCompilerErrorsDuring: [ | aSourceString previousMethod |
				aSourceString := self currentSourceString.

				aGtPharoSourceCoderEvaluationContext
					sourceString: aSourceString;
					evaluatedInterval: (1 to: aSourceString size);
					evaluatedSourceString: aSourceString.

				previousMethod := self installedMethod.
				compiledSuccesfully := self session
						gtRecompileMethodTo: aSourceString
						inContext: aGtPharoSourceCoderEvaluationContext runtimeContext
						notifying: aGtPharoSourceCoderEvaluationContext.
				previousMethod ~~ self installedMethod
					ifTrue: [ self sourceCode: (GtCoderExplicitStringSource new source: aSourceString) ] ]
			inContext: aGtPharoSourceCoderEvaluationContext.

	^ withoutErrors and: [ compiledSuccesfully ]
]

{ #category : #accessing }
GtPharoMethodContextCoder >> compiledMethod [

	"The context coder should allways return the compiled method from the context 
	as the method from the class can be changed. In that case the context will 
	use its own method."

	^ context compiledCode method
		  
	"^ context isBlockContext
		  ifTrue: [ context home compiledCode ]
		  ifFalse: [ context compiledCode ]"
]

{ #category : #accessing }
GtPharoMethodContextCoder >> context [
	<return: #Context>

	^ context
]

{ #category : #'debugger access' }
GtPharoMethodContextCoder >> currentContext [
	^ self context
]

{ #category : #'accessing variables' }
GtPharoMethodContextCoder >> debuggerVariableNodes [
	| variablesList |
	
	variablesList := OrderedCollection new.
	self instanceVariableNodesDo: [ :aNode | variablesList add: aNode ].
	self temporaryVariableNodesDo: [ :aNode | variablesList add: aNode ].
	self workspaceDoItNodesDo: [ :aNode | variablesList add: aNode ].
	
	variablesList sort: [:node1 :node2 | node1 key < node2 key].
	variablesList 
		addFirst: (GtInspectorSelfNode hostObject: self receiver);
		addLast: (GtInspectorDynamicNode 
			hostObject: self context 
			label: 'thisContext' 
			value: self context
			tag: 'stack').
	self stackVariableNodesDo: [ :aNode | variablesList add: aNode ].
	
	^ variablesList
]

{ #category : #accessing }
GtPharoMethodContextCoder >> explicitProviderClass [
	^ self receiverClass
]

{ #category : #'instance creation' }
GtPharoMethodContextCoder >> forContext: aContext session: aDebugSession [

	context := aContext.
	session := aDebugSession.
	originalCompiledCode := context compiledCode.
	self forMethod: self compiledMethod.
	self behavior: context receiver class
]

{ #category : #'api - actions' }
GtPharoMethodContextCoder >> gtUpdateContextWithCurrentMethod [
	| currentMethod |
	self existsInTheSystem ifFalse: [^self].
	currentMethod := self behavior >> self selector.
	self session gtUpdateContext: self context withMethod: currentMethod.
	
	self notifyDebugger.
]

{ #category : #initialize }
GtPharoMethodContextCoder >> initializeAddOns: addOns [
	super initializeAddOns: addOns.

"	addOns addStyler: (GtCoderContextVariableButtonStyler new methodCoder: self)."
"	addOns addStyler: (GtCoderContextVariableValueStyler new methodCoder: self)"
]

{ #category : #accessing }
GtPharoMethodContextCoder >> installedMethod [
	^ super compiledMethod
]

{ #category : #'accessing variables' }
GtPharoMethodContextCoder >> instanceVariableNamesAndValuesDo: aBlock [
	| receiver |
	receiver := self receiver.
	receiver class allInstVarNames doWithIndex: [ :each :i | 
		aBlock value: each value: (receiver instVarAt: i) ]
]

{ #category : #'accessing variables' }
GtPharoMethodContextCoder >> instanceVariableNodesDo: aBloc [
	self receiver class allSlots do: [ :aSlot | 
		aBloc value: (GtInspectorSlotNode 
			hostObject: self receiver 
			slot: aSlot) ]
]

{ #category : #'debugger access' }
GtPharoMethodContextCoder >> interruptedContext [
	^ self session context
]

{ #category : #testing }
GtPharoMethodContextCoder >> isDead [
	^ context isDead
]

{ #category : #testing }
GtPharoMethodContextCoder >> needsUpdate [
	^  originalCompiledCode ~~ self context compiledCode
		or: [ self selector ~~ self compiledMethod selector ]
]

{ #category : #private }
GtPharoMethodContextCoder >> notifyDebugger [
	announcer announce: GtCoderRefreshStackAnnouncement new.
]

{ #category : #'event handling' }
GtPharoMethodContextCoder >> onMethodModified: aMethodModified [
	| method |
	method := self compiledMethod.
	aMethodModified newMethod selector = method selector ifFalse: [ ^ self ].
	aMethodModified classAffected = method methodClass ifFalse: [ ^ self ].
	self notifyMethodModified
]

{ #category : #accessing }
GtPharoMethodContextCoder >> originalCompiledMethod [
	^ originalCompiledCode
]

{ #category : #printing }
GtPharoMethodContextCoder >> printOn: aStream [
	super printOn: aStream.
	self context ifNotNil: [ 
		aStream nextPut: $(.
		self context printOn: aStream. 
		aStream nextPut: $) ]
]

{ #category : #accessing }
GtPharoMethodContextCoder >> programCounterRange [
	self session
		ifNil: [ ^ context pcRangeContextIsActive: false ].

	(self session process isNil or: [ context isDead ])
		ifTrue: [ ^ nil ].
	^ self session pcRangeForContext: context
]

{ #category : #accessing }
GtPharoMethodContextCoder >> receiver [
	^ self context receiver
]

{ #category : #accessing }
GtPharoMethodContextCoder >> receiverClass [
	^ self receiver class
]

{ #category : #'api - actions' }
GtPharoMethodContextCoder >> saveInContext: aGtPharoSourceCoderEvaluationContext [
	(super saveInContext: aGtPharoSourceCoderEvaluationContext)
		ifFalse: [ ^ false ].

	"If compilation succedded notify the debugger. The current context is now in an 
	invalid state, as it contains the code of the old compiled method object; the context 
	has a new compiled method objects. The debugger should properly update this context if
	the context still need to be displayed on the stack."
	self notifyDebugger.

	^ true
]

{ #category : #'debugger access' }
GtPharoMethodContextCoder >> session [
	^ session
]

{ #category : #private }
GtPharoMethodContextCoder >> stackDebuggingActionsPragmas [
	^ #(gt2ContextDebuggingAction)
]

{ #category : #'accessing variables' }
GtPharoMethodContextCoder >> stackVariableNamesAndValuesDo: aBlock [
	| stackPosition |
	self context stackPtr isNil
		ifTrue: [ ^ self ].
	stackPosition := 0.
	self context stackPtr to: self context numTemps + 1 by: -1 do: [ :i | 
		aBlock
			value:
				'stack top'
					,
						(stackPosition > 0
							ifTrue: [ ' - ' , stackPosition printString ]
							ifFalse: [ '' ])
			value: (self context at: i).
		stackPosition := stackPosition + 1 ]
]

{ #category : #'accessing variables' }
GtPharoMethodContextCoder >> stackVariableNodesDo: aBlock [
	| stackPosition |
	self context stackPtr isNil
		ifTrue: [ ^ self ].
	stackPosition := 0.
	self context stackPtr to: self context numTemps + 1 by: -1 do: [ :i | 
		aBlock value: (GtInspectorDynamicNode 
			hostObject: self context
			label: ('stack top' ,
				(stackPosition > 0
					ifTrue: [ ' - ' , stackPosition printString ]
					ifFalse: [ '' ])) 
			value: (self context at: i)
			tag: 'stack').
		stackPosition := stackPosition + 1 ]
]

{ #category : #accessing }
GtPharoMethodContextCoder >> startingStateForAstComputation [
	^ self 
		forPharo11AndPharo12: [
			self compiledMethod isDoIt
				ifTrue: [ GtPharoParser startingStateForDoItMethod ]
				ifFalse: [ GtPharoParser startingStateForMethod ] ]
		forPharo10: [
			GtPharoParser startingStateForMethod]
]

{ #category : #subscriptions }
GtPharoMethodContextCoder >> subscribeToSystem [
	self unsubscribeFromSystem.

	SystemAnnouncer uniqueInstance weak
		when: MethodModified
		send: #onMethodModified:
		to: self
]

{ #category : #'accessing variables' }
GtPharoMethodContextCoder >> tempNamesAndValuesDo: aBlock [
	self context tempNames doWithIndex: [ :each :i | 
		| value |
		value := nil.
		[ value := self context namedTempAt: i ] on: Error do: [
			value := 'error obtaining field value' ].
		aBlock value: each value: value ]
]

{ #category : #'accessing variables' }
GtPharoMethodContextCoder >> temporaryVariableNodesDo: aBloc [
	self context tempNames withIndexCollect: [ :tempName :tempIndex |
		aBloc value: (GtInspectorContextNamedTempNode 
			hostObject: self context 
			tempName: tempName 
			tempIndex: tempIndex) ]
]

{ #category : #updating }
GtPharoMethodContextCoder >> updateSelection [
	"Still here as it is called from the SmaCC debugger.
	Remove after updating the SmaCC debugger."
]

{ #category : #updating }
GtPharoMethodContextCoder >> updateSourceFromContext [

	self needsUpdate ifFalse: [ ^ self ].
	self forContext: context session: session
]

{ #category : #'accessing variables' }
GtPharoMethodContextCoder >> workspaceDoItNodesDo: aBloc [
	self context gtDebuggerDoItBindings do: [:aBinding |
		aBloc value: (GtInspectorDynamicNode 
			hostObject: self context 
			label: aBinding key 
			value: aBinding value
			tag: 'temporary') ]
]

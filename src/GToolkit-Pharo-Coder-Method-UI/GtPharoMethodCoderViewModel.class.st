Class {
	#name : #GtPharoMethodCoderViewModel,
	#superclass : #GtPharoSourceCoderViewModel,
	#instVars : [
		'savePreventors',
		'contextualBehavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

{ #category : #'api - debugging' }
GtPharoMethodCoderViewModel >> addBreakpointAtCursorLocation [
	| node breakpoint |
	
	self cursors allCursors ifNotEmpty: 
			[:currentCursors |
			| position |
			position := currentCursors first position.
			node := self compiledMethod ast
						bestNodeForPosition: position].
						
	node hasBreakpoint ifTrue: [^self].
	node isMessage | node isVariable | node isLiteralNode ifFalse: [^self].
	
	breakpoint := Breakpoint new.
	breakpoint node: node.
	breakpoint once: true.
	breakpoint install.
	
	self coderModel requestStyleSourceText
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> allowSave [
	"Remove all save prventors and recompute the updated save availability"

	savePreventors removeAll.
	self notifySaveEnabled
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> allowSaveDueTo: aSavePreventor [
	savePreventors
		remove: aSavePreventor
		ifAbsent: [ ^ self ].
		
	savePreventors
		ifNotEmpty: [ ^ self ].
		
	self notifySaveEnabled
]

{ #category : #private }
GtPharoMethodCoderViewModel >> availableCompilationBehaviors [
	"Return a list of behaviors in which the method can be compiled.
	For example, a trait method can be compile in a trait itself, or in a behavior that uses that trait.
	Superclass methods that are displayed in a methods coder can be compiled in a context of that methods coder
	or in the origin superclass"
	<return: #TAsyncStream of: #Behavior>
	
	^ ({ 
		contextualBehavior asAsyncFuture asAsyncStream.
		self coderModel methodBehavior asyncSubclasses.
		self behavior asAsyncFuture asAsyncStream.
		(self coderModel methodOrigin behaviorDo: [ :aBehavior | aBehavior ]) asAsyncFuture asAsyncStream.
	
	} asAsyncStream flatten select: [ :eachBehavior | eachBehavior notNil ]) withoutDuplicates
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> behavior [
	^ self coderModel behavior
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> behavior: aBehavior [
	^ self coderModel behavior: aBehavior
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> compile [
	<return: #Boolean>

	^ self coderModel compileInContext: self evaluationContext
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> compiledMethod [
	<return: #CompiledMethod>

	^ self coderModel compiledMethod
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> computeHeaderBreadcrumbModel [
	^ GtPharoMethodCoderHeaderModel new 
		initializeForCoderViewModel: self.
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> contextualBehavior: aBehavior [
	contextualBehavior := aBehavior
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> debugAll [
	self isModified ifTrue: [ self save ifFalse: [ ^ self ] ].
	^ super debugAll
]

{ #category : #private }
GtPharoMethodCoderViewModel >> defaultCompilationBehavior [
	<return: #Behavior>
	
	^ contextualBehavior ifNil: [ self sourceBehavior ]
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> discardChanges [
	super discardChanges.
	self allowSave
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> elementClass [
	^ GtExpandableMethodCoderElement
]

{ #category : #'private - evaluation' }
GtPharoMethodCoderViewModel >> evaluationContext [
	^ super evaluationContext
		receiverObject: (self selfObjectIfNone: [ self behavior instanceSide ]);
		targetBehavior: self defaultCompilationBehavior
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> example [
	<return: #GtExampleWithResult or: nil>
	^ self coderModel example
]

{ #category : #'api - accessing' }
GtPharoMethodCoderViewModel >> explicitProviderClass [
	^ self coderModel explicitProviderClass
]

{ #category : #'gt-extension' }
GtPharoMethodCoderViewModel >> gtInfo [
	^ super gtInfo, (Array streamContents: [ :aStream |
		aStream nextPut: #behavior -> self behavior.
		aStream nextPut: #sourceBehavior -> self sourceBehavior.
		aStream nextPut: #compiledMethod -> self compiledMethod.
		aStream nextPut: #selector -> self selector.
		aStream nextPut: #protocol -> self protocol.
		aStream nextPut: #methodOrigin -> self methodOrigin.
		aStream nextPut: #explicitProviderClass -> self explicitProviderClass.
	
		aStream nextPut: #isMeta -> self isMeta.
		aStream nextPut: #isFromTrait -> self isFromTrait.
		
		aStream nextPut: #isOverridden -> self isOverridden.
		aStream nextPut: #isOverriding -> self isOverriding.
		
		aStream nextPut: (#isSaveEnabled -> self isSaveEnabled).
		self isSaveEnabled
			ifFalse: [ aStream nextPut: (#savePreventors -> savePreventors asArray) ].
		
		aStream nextPut: #parentCoderViewModel -> self parentCoderViewModel.
		aStream nextPut: #parentExample -> self parentExample.
		aStream nextPut: #parentTestCase -> self parentTestCase.
		aStream nextPut: (#availableCompilationBehaviors -> self availableCompilationBehaviors) ])
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> hasDeclaredVariableNamed: aVariableName [
	"Return true if a variable with a given name is declared"
	<return: #Boolean>
	
	(super hasDeclaredVariableNamed: aVariableName)
		ifTrue: [ ^ true ].
		
	(self behavior classThatDefinesInstVarNamed: aVariableName)
		 ifNotNil: [ ^ true ].
		
	(self behavior instanceSide classThatDefinesClassVariable: aVariableName)
		 ifNotNil: [ ^ true ].

	^ self behavior instanceSide allSharedPools
		anySatisfy: [ :each | each classPool includesKey: aVariableName asSymbol ]
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> headerElementClass [
	^ GtPharoMethodCoderHeaderElement
]

{ #category : #initialization }
GtPharoMethodCoderViewModel >> initialize [
	super initialize.
	
	savePreventors := OrderedCollection new
]

{ #category : #testing }
GtPharoMethodCoderViewModel >> isFromTrait [
	^ self coderModel isFromTrait
]

{ #category : #testing }
GtPharoMethodCoderViewModel >> isMeta [
	"Return true if the method is implemented in a pharo metaclass (~ class side)"
	<return: #Boolean>

	^ self coderModel isMeta
]

{ #category : #testing }
GtPharoMethodCoderViewModel >> isOverridden [
	^ self coderModel isOverridden
]

{ #category : #testing }
GtPharoMethodCoderViewModel >> isOverriding [
	^ self coderModel isOverriding
]

{ #category : #testing }
GtPharoMethodCoderViewModel >> isSaveEnabled [
	^ savePreventors isEmpty
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> methodOrigin [
	<return: #GtPharoMethodOrigin>

	^ coderModel methodOrigin
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> methodReference [
	<return: #RGMethodDefinition or: nil>

	^ self coderModel methodReference
]

{ #category : #'private - notifying' }
GtPharoMethodCoderViewModel >> notifySaveDisabled [
	self announce: (GtMethodCoderSaveDisabled new preventors: savePreventors asArray)
]

{ #category : #'private - notifying' }
GtPharoMethodCoderViewModel >> notifySaveEnabled [
	self announce: (GtMethodCoderSaveEnabled new)
]

{ #category : #'private - notifying' }
GtPharoMethodCoderViewModel >> notifySaved: aCompiledMethod [
	self announce: (GtMethodCoderSaved new method: aCompiledMethod)
]

{ #category : #'private - evaluation' }
GtPharoMethodCoderViewModel >> objectVariableBindingsTo: theBindings [
	super objectVariableBindingsTo: theBindings.
	
	"Avoid #isNil #notNil in case we are dealing with a proxy"
	self 
		ifSelfObject: [ :aSelfObject | ] 
		ifNone: [ 
			self defaultCompilationBehavior isClassSide ifTrue: [ 
				theBindings addBindings: (GtSlotVariablesBindings new 
					object: self defaultCompilationBehavior instanceSide) ] ].
]

{ #category : #'private - event handling' }
GtPharoMethodCoderViewModel >> onBehaviorChanged: aBehaviorChangedAnnouncement [
	self announce: ((GtTextualCoderViewModelBehaviorChanged new newBehavior: (aBehaviorChangedAnnouncement newBehavior)))
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> parentCoderViewModel [
	<return: #GtPharoMethodCoderViewModel or: nil>
	^ self
		optionAt: #parentCoderViewModel
		ifPresent: [ :aWeak | aWeak at: 1 ]
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> parentCoderViewModel: aCoderViewModel [
	"In case of method coders expanded inside of another method coder,
	the parent-method-coder view model is set, to be able to get an extra information."

	self optionAt: #parentCoderViewModel put: aCoderViewModel asWeakReference
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> parentExample [
	<return: #GtExampleWithResult or: nil>
	^ self
		optionAt: #parentExample
		ifPresent: [ :aWeak | aWeak at: 1 ]
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> parentExample: anExample [
	"In case of method coders expanded inside of another method coder,
	the parent-method-coder example is set, to be able to highlight failing code
	in those expanded method coders."

	self optionAt: #parentExample put: anExample asWeakReference
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> parentTestCase [
	<return: #GtPharoMethodTestCase or: nil>
	^ self
		optionAt: #parentTestCase
		ifPresent: [ :aWeak | aWeak at: 1 ]
		ifAbsent: [ nil ]
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> parentTestCase: aTestCase [
	"In case of method coders expanded inside of another method coder,
	the parent-method-coder test case is set, to be able to highlight failing code
	in those expanded method coders."

	self optionAt: #parentTestCase put: aTestCase asWeakReference
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> playAll [
	"Evaluate the whole source code and inspect the result"

	^ self coder playAllInContext: (self evaluationContext all; receiverObject: self receiverObjectToPlay)
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> playAllAndInspect [
	"Evaluate the whole source code and inspect the result"
	
	^ self coder playAllAndInspectInContext: (self evaluationContext all; receiverObject: self receiverObjectToPlay)
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> preventSaveDueTo: aSavePreventor [
	(savePreventors includes: aSavePreventor)
		ifTrue: [ ^ self ].

	savePreventors add: aSavePreventor.

	savePreventors size > 1
		ifTrue: [ ^ self ].
		
	self notifySaveDisabled
]

{ #category : #printing }
GtPharoMethodCoderViewModel >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: self behavior asString;
		nextPutAll: '>>#';
		nextPutAll: self selector asString;
		nextPut: $)
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> protocol [
	<return: #String>

	^ self coderModel protocol
]

{ #category : #private }
GtPharoMethodCoderViewModel >> receiverObjectToPlay [
	self isMeta ifTrue: [ ^ self behavior instanceSide ].
	^ self selfObjectIfNone: [ self behavior new ].
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> save [
	| aSaveResult |
	<return: #Boolean>
	
	self isSaveEnabled
		ifFalse: [ ^ false ].

	aSaveResult := self coderModel saveInContext: self evaluationContext.
	aSaveResult ifTrue: [ self notifySaved: self compiledMethod ].

	^ aSaveResult
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> saveIn: aBehavior [
	| aSaveResult |
	<return: #Boolean>
	
	self isSaveEnabled
		ifFalse: [ ^ false ].

	aSaveResult := self coderModel saveInContext: (self evaluationContext targetBehavior: aBehavior).
	aSaveResult ifTrue: [ self notifySaved: self compiledMethod ].

	^ aSaveResult
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> selector [
	^ self coderModel selector
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> sourceBehavior [
	"Returns a behavior in which the method is compiled."
	<return: #Behavior or: nil>
	
	^ coderModel traitSource
		ifNil: [ coderModel behavior ]
		ifNotNil: [ :aTraitCompositionElement |
			(aTraitCompositionElement
				traitDefining: coderModel selector
				ifNone: [ nil ]) innerClass ]
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> subscribeToCoderModel [
	super subscribeToCoderModel.

	self coderModel weak
		when: GtCoderBehaviorChanged
		send: #onBehaviorChanged:
		to: self
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> testCase [
	<return: #GtPharoMethodTestCase or: nil>
	^ self coderModel testCase
]

{ #category : #'api - header' }
GtPharoMethodCoderViewModel >> wantsHeader [
	<return: #Boolean>
	^ super wantsHeader or: [ self isFromTrait ]
]

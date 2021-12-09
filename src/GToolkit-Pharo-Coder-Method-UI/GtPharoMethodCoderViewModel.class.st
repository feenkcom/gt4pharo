Class {
	#name : #GtPharoMethodCoderViewModel,
	#superclass : #GtPharoSourceCoderViewModel,
	#instVars : [
		'savePreventors',
		'contextualBehavior'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

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
		self behavior asAsyncFuture asAsyncStream.
		(self coderModel methodOrigin map: [ :aMethodOrigin | aMethodOrigin behaviorDo: [ :aBehavior | aBehavior ] ]) asAsyncStream.
	
	} asAsyncStream flatten select: [ :eachBehavior | eachBehavior notNil ]) withoutDuplicates
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> behavior [
	^ self coderModel behavior
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
GtPharoMethodCoderViewModel >> contextualBehavior: aBehavior [
	contextualBehavior := aBehavior
]

{ #category : #private }
GtPharoMethodCoderViewModel >> defaultCompilationBehavior [
	<return: #Behavior>
	
	^ contextualBehavior ifNil: [
		(self methodOrigin
			map: [ :aMethodOrigin |
				aMethodOrigin
					behaviorDo: [ :aBehavior | aBehavior ]
					ifUnknown: [ nil ] ]) wait ]
]

{ #category : #'api - actions' }
GtPharoMethodCoderViewModel >> discardChanges [
	super discardChanges.
	self allowSave
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> elementClass [
	^ GtExpandableMethodCoderForBehaviorElement
]

{ #category : #'private - evaluation' }
GtPharoMethodCoderViewModel >> evaluationContext [
	^ super evaluationContext
		receiverObject: (self selfObject ifNil: [ self behavior instanceSide ]);
		targetBehavior: self defaultCompilationBehavior
]

{ #category : #'gt-extension' }
GtPharoMethodCoderViewModel >> gtInfo [
	^ super gtInfo, (Array streamContents: [ :aStream |
		aStream nextPut: (#saveEnabled -> self isSaveEnabled).
		self isSaveEnabled
			ifFalse: [ aStream nextPut: (#savePreventors -> savePreventors asArray) ] ])
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> hasDeclaredVariableNamed: aVariableName [
	"Return true if a variable with a given name is declared"
	<return: #Boolean>
	
	(super hasDeclaredVariableNamed: aVariableName)
		ifTrue: [ ^ true ].
		
	(self behavior allSlots anySatisfy: [ :eachSlot | eachSlot name =  aVariableName ])
		 ifTrue: [ ^ true ].
		
	(self behavior allClassVariables anySatisfy: [ :eachSlot | eachSlot name = aVariableName ])
		 ifTrue: [ ^ true ].

	^ false
]

{ #category : #accessing }
GtPharoMethodCoderViewModel >> headerElementClass [
	"Return an class of an element that should represent a header of the coder.
	The used element must implement {{gtClass:TGtWithTextualCoderViewModel}} trait."
	<return: #TGtWithTextualCoderViewModel or: nil>
	
	^ GtPharoMethodCoderHeaderElement
]

{ #category : #initialization }
GtPharoMethodCoderViewModel >> initialize [
	super initialize.
	
	savePreventors := OrderedCollection new
]

{ #category : #'api - testing' }
GtPharoMethodCoderViewModel >> isFromTrait [
	^ self coderModel isFromTrait
]

{ #category : #'api - testing' }
GtPharoMethodCoderViewModel >> isMeta [
	"Return true if the method is implemented in a pharo metaclass (~ class side)"
	<return: #Boolean>

	^ self coderModel isMeta
]

{ #category : #'api - testing' }
GtPharoMethodCoderViewModel >> isSaveEnabled [
	^ savePreventors isEmpty
]

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> methodOrigin [
	<return: #TAsyncFuture of: #GtPharoMethodOrigin>
	
	^ self coderModel methodOrigin
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

{ #category : #'api - coder model' }
GtPharoMethodCoderViewModel >> protocol [
	<return: #String>

	^ self coderModel protocol
]

{ #category : #private }
GtPharoMethodCoderViewModel >> receiverObjectToPlay [
	"Return an object that should play a role of the receiver when executing code within a method"
	<return: #Object>
	
	^ self selfObject
		ifNil: [
			contextualBehavior ifNotNil: [ :aBehavior |
				self isMeta
					ifTrue: [ aBehavior instanceSide ]
					ifFalse: [ aBehavior instanceSide new ] ] ]
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

{ #category : #'api - header' }
GtPharoMethodCoderViewModel >> wantsHeader [
	<return: #Boolean>
	
	^ super wantsHeader or: [ self isFromTrait ]
]

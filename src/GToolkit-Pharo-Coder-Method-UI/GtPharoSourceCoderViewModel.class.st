Class {
	#name : #GtPharoSourceCoderViewModel,
	#superclass : #GtSourceCoderViewModel,
	#instVars : [
		'selfObject',
		'localBindings',
		'hasSelfObject',
		'highlighter'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-! View Models'
}

{ #category : #'api - bindings' }
GtPharoSourceCoderViewModel >> addLocalBindings: aLocalBindings [
	aLocalBindings bindingNamesAndValuesDo: [ :aName :aVariable | 
		localBindings localAt: aName putVariable: aVariable ]
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> behavior [
	"Return a class (or trait) in the context of which the coder is opened"

	^ self subclassResponsibility
]

{ #category : #'private - bindings' }
GtPharoSourceCoderViewModel >> bindingStrategy [
	"Private. Return the underlying bindings strategy. Do not modify the object from the outside!"
	<return: #TGtVariablesBindings>

	self deprecated: 'Use localBindings instead'.

	^ self localBindings
]

{ #category : #'private - bindings' }
GtPharoSourceCoderViewModel >> compositeVariableBindings [
	| theBindings |

	theBindings := GtCompositeVariablesBindings new.
	theBindings addBindings: GtReservedVariablesBindings new.
	theBindings addBindings: GtGlobalVariablesBindings new.
	
	"Avoid #isNil #notNil in case we are dealing with a proxy"
	self selfObject == nil
		ifFalse: [ theBindings addBindings: (GtSlotVariablesBindings new object: self selfObject) ].

	theBindings addBindings: localBindings.
	
	^ theBindings
]

{ #category : #'private - evaluation' }
GtPharoSourceCoderViewModel >> evaluationContext [
	^ super evaluationContext
		bindingStrategy: self compositeVariableBindings;
		receiverObject: self selfObject
]

{ #category : #'gt-extension' }
GtPharoSourceCoderViewModel >> gtInfo [
	^ super gtInfo, {
		#bindings -> self compositeVariableBindings.
		#selfObject -> self selfObject
	}
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> hasDeclaredGlobalNamed: aVariableName [
	^ self class environment includesKey: aVariableName
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> hasDeclaredVariableNamed: aVariableName [
	"Return true if a variable with a given name is declared"
	<return: #Boolean>

	^ false
]

{ #category : #'api - testing' }
GtPharoSourceCoderViewModel >> hasSelfObject [

	^ hasSelfObject ifNil: [ false ]
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModel >> highlighter [
	<return: #GtSourceReferenceHighlighter>

	^ highlighter
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModel >> highlighter: aGtSourceReferenceHighlighter [
	"Set a source reference highlighter thhat should be used tp highlight or mark some parts
	of the source code. If a given highlighter is nil, it means that no highlighter should be used"

	self highlighter == aGtSourceReferenceHighlighter
		ifTrue: [ ^ self ].

	highlighter := aGtSourceReferenceHighlighter.
	self coderModel requestUpdateAddOns
]

{ #category : #initialization }
GtPharoSourceCoderViewModel >> initialize [
	super initialize.

	localBindings := GtLocalVariablesBindings new.
	hasSelfObject := false.
	highlighter := nil
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> isDeprecatedGlobalNamed: aVariableName [
	^ self class environment
		at: aVariableName
		ifPresent: [ :anObject | anObject isBehavior and: [ anObject isDeprecated ] ]
		ifAbsent: [ false ]
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModel >> localBindings [
	<return: #GtLocalVariablesBindings>

	^ localBindings
]

{ #category : #accessing }
GtPharoSourceCoderViewModel >> newCompletionStrategy [
	^ GtPharoCompletionStrategy new
		classOrMetaClass: self behavior;
		selfObject: self selfObject;
		yourself
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModel >> selfObject [
	"Return an object that should be bound to `self` during code evaluation"

	^ selfObject
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModel >> selfObject: anObject [
	"Assign an object that should be bound to `self` during code evaluation"

	selfObject := anObject.
	completionStrategy
		ifNotNil: [ completionStrategy
				classOrMetaClass: self behavior;
				selfObject: anObject ]
]

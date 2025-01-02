Class {
	#name : #GtPharoSourceCoderViewModel,
	#superclass : #GtSourceCoderViewModel,
	#traits : 'TGtCoderWithSelfObjectHolder',
	#classTraits : 'TGtCoderWithSelfObjectHolder classTrait',
	#instVars : [
		'localBindings',
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
	
	self objectVariableBindingsTo: theBindings.

	theBindings addBindings: localBindings.
	
	^ theBindings
]

{ #category : #'private - bindings' }
GtPharoSourceCoderViewModel >> compositeVariableBindingsForStyling [
	"Subclasses may add extra variable bindings to style source code."

	^ self compositeVariableBindings
]

{ #category : #'private - evaluation' }
GtPharoSourceCoderViewModel >> evaluationContext [
	^ super evaluationContext
		bindingStrategy: self compositeVariableBindings;
		receiverObject: self selfObject
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> example [
	<return: #GtExampleWithResult or: nil>
	^ nil
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModel >> explicitProviderClass [
	^ nil
]

{ #category : #'gt-extension' }
GtPharoSourceCoderViewModel >> gtInfo [
	^ super gtInfo, {
		#bindings -> self compositeVariableBindings.
		#selfObjectHolder -> self selfObjectHolder.
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
	highlighter := nil.
	selfObjectHolder := GtCoderUndefinedObject default.
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

{ #category : #'private - bindings' }
GtPharoSourceCoderViewModel >> objectVariableBindingsTo: theBindings [
	"Avoid #isNil #notNil in case we are dealing with a proxy"

	self
		ifSelfObject: [ :aSelfObject | 
			theBindings addBindings: (GtSlotVariablesBindings new object: aSelfObject) ]
		ifNone: [  ].
]

{ #category : #'api - self object' }
GtPharoSourceCoderViewModel >> onSelfObjectHolderChanged [
	completionStrategy
		ifNotNil: [ completionStrategy
				classOrMetaClass: self behavior;
				selfObject: self selfObject ].
	self coderModel requestStyleSourceText
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> parentCoderViewModel [
	<return: #GtPharoMethodCoderViewModel or: nil>
	^ nil
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> parentExample [
	<return: #GtExampleWithResult or: nil>
	^ nil
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> parentTestCase [
	<return: #GtPharoMethodTestCase or: nil>
	^ nil
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModel >> testCase [
	<return: #GtPharoMethodTestCase or: nil>
	^ nil
]

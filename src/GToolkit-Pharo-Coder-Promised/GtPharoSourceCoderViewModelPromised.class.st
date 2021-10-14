Class {
	#name : #GtPharoSourceCoderViewModelPromised,
	#superclass : #GtSourceCoderViewModelPromised,
	#instVars : [
		'selfObject',
		'localBindings'
	],
	#category : #'GToolkit-Pharo-Coder-Promised'
}

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModelPromised >> behavior [
	"Return a class (or trait) in the context of which the coder is opened"

	^ self subclassResponsibility
]

{ #category : #'private - bindings' }
GtPharoSourceCoderViewModelPromised >> bindingStrategy [
	"Private. Return the underlying bindings strategy. Do not modify the object from the outside!"
	<return: #TGtVariablesBindings>

	self deprecated: 'Use localBindings instead'.

	^ self localBindings
]

{ #category : #'private - bindings' }
GtPharoSourceCoderViewModelPromised >> compositeVariableBindings [
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
GtPharoSourceCoderViewModelPromised >> evaluationContext [
	^ super evaluationContext
		bindingStrategy: self compositeVariableBindings;
		receiverObject: self selfObject
]

{ #category : #'gt-extension' }
GtPharoSourceCoderViewModelPromised >> gtInfo [
	^ super gtInfo, {
		#bindings -> self compositeVariableBindings.
		#selfObject -> self selfObject
	}
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModelPromised >> hasDeclaredGlobalNamed: aVariableName [
	^ self class environment includesKey: aVariableName
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModelPromised >> hasDeclaredVariableNamed: aVariableName [
	"Return true if a variable with a given name is declared"
	<return: #Boolean>

	^ false
]

{ #category : #initialization }
GtPharoSourceCoderViewModelPromised >> initialize [
	super initialize.

	localBindings := GtLocalVariablesBindings new
]

{ #category : #'api - coder model' }
GtPharoSourceCoderViewModelPromised >> isDeprecatedGlobalNamed: aVariableName [
	^ self class environment
		at: aVariableName
		ifPresent: [ :anObject | anObject isBehavior and: [ anObject isDeprecated ] ]
		ifAbsent: [ false ]
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModelPromised >> localBindings [
	<return: #GtLocalVariablesBindings>

	^ localBindings
]

{ #category : #'api - actions' }
GtPharoSourceCoderViewModelPromised >> renameLocalVariableAt: aTextIndex [
	GtRenameAction2
		pharoRenameLocalVariableAt: aTextIndex
		textualCoderViewModel: self
]

{ #category : #'api - actions' }
GtPharoSourceCoderViewModelPromised >> renameLocalVariableAtCursor [
	self cursors do: [ :aCursor |
		^ GtRenameAction2
			pharoRenameLocalVariableAt: aCursor position
			textualCoderViewModel: self ]
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModelPromised >> selfObject [
	"Return an object that should be bound to `self` during code evaluation"

	^ selfObject
]

{ #category : #'api - accessing' }
GtPharoSourceCoderViewModelPromised >> selfObject: anObject [
	"Assign an object that should be bound to `self` during code evaluation"

	selfObject := anObject
]

Class {
	#name : 'GtPharoMethodContextCoderViewModel',
	#superclass : 'GtPharoMethodCoderViewModel',
	#category : 'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : 'private - bindings' }
GtPharoMethodContextCoderViewModel >> compositeVariableBindings [
	| theBindings |

	theBindings := super compositeVariableBindings.

	self context ifNotNil: [ :aContext | theBindings addBindings: (GtContextVariablesBindings new context: aContext) ].
	
	^ theBindings
]

{ #category : 'accessing' }
GtPharoMethodContextCoderViewModel >> context [
	^ self coderModel context
]

{ #category : 'private - evaluation' }
GtPharoMethodContextCoderViewModel >> evaluationContext [
	^ super evaluationContext
		runtimeContext: self context
]

{ #category : 'initialization' }
GtPharoMethodContextCoderViewModel >> initialize [
	super initialize.
	
	expanded := false
]

{ #category : 'notifications' }
GtPharoMethodContextCoderViewModel >> notifyContextPCRangeChangedTo: anInterval [
	self announcerUIModel
		announce: (GtMethodCoderContextPCRangeChanged new
			pcRange: anInterval)
]

{ #category : 'accessing' }
GtPharoMethodContextCoderViewModel >> programCounterRange [
	^ self coderModel programCounterRange
]

{ #category : 'updating' }
GtPharoMethodContextCoderViewModel >> updateProgramCounterRange [
	self notifyContextPCRangeChangedTo: self programCounterRange
]

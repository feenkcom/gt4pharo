Class {
	#name : #GtPharoBehaviorCoderViewModel,
	#superclass : #GtSingleCoderViewModel,
	#instVars : [
		'definitionCoderUIModel',
		'methodsCoderUIModel'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> behavior [
	^ self coderModel behavior
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> definitionCoderUIModel [
	^ definitionCoderUIModel ifNil: [ self coder definitionCoder asCoderUIModel ]
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> elementClass [
	^ GtPharoBehaviorCoderElement
]

{ #category : #accessing }
GtPharoBehaviorCoderViewModel >> methodsCoderUIModel [
	^ methodsCoderUIModel ifNil: [ self coder methodsCoder asCoderUIModel ]
]

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> protocols [
	^ self coderModel behavior protocols
]

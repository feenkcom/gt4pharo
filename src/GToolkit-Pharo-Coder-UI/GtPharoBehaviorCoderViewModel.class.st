Class {
	#name : #GtPharoBehaviorCoderViewModel,
	#superclass : #GtSingleCoderViewModel,
	#instVars : [
		'definitionCoderUIModel'
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
GtPharoBehaviorCoderViewModel >> onCoderModelChanged [

	super onCoderModelChanged.
]

{ #category : #'api - coder model' }
GtPharoBehaviorCoderViewModel >> protocols [
	^ self coderModel behavior protocols
]

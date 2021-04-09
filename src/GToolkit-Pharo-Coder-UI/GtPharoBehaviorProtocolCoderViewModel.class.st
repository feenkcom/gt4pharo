Class {
	#name : #GtPharoBehaviorProtocolCoderViewModel,
	#superclass : #GtSingleCoderViewModel,
	#instVars : [
		'methodViewModels'
	],
	#category : #'GToolkit-Pharo-Coder-UI-! View Models'
}

{ #category : #accessing }
GtPharoBehaviorProtocolCoderViewModel >> elementClass [
	^ self shouldNotImplement
]

{ #category : #'gt-extension' }
GtPharoBehaviorProtocolCoderViewModel >> gtLiveFor: aView [
	^ aView empty
]

{ #category : #accessing }
GtPharoBehaviorProtocolCoderViewModel >> methodViewModels [
	^ methodViewModels
]

{ #category : #'api - coder model' }
GtPharoBehaviorProtocolCoderViewModel >> onCoderModelChanged [
	super onCoderModelChanged.

	methodViewModels := self coderModel methodCoders
		collect: [ :eachMethodCoder | eachMethodCoder asCoderViewModel ]
]

{ #category : #'api - coder model' }
GtPharoBehaviorProtocolCoderViewModel >> protocol [
	^ self coderModel protocol
]

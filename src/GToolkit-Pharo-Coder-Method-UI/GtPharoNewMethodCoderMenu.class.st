Class {
	#name : #GtPharoNewMethodCoderMenu,
	#superclass : #BrMenu,
	#instVars : [
		'coder',
		'valueHolder',
		'onMethodCoderSaved',
		'onObjectToSpawn'
	],
	#category : #'GToolkit-Pharo-Coder-Method-UI-Support'
}

{ #category : #visiting }
GtPharoNewMethodCoderMenu >> acceptVisitor: aVisitor [
	^ aVisitor visitPharoNewMethodCoderMenu: self
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> behavior [
	^ self coder behavior
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> coder [
	^ coder 
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> coder: aCoder [
	coder := aCoder.
	valueHolder contents: aCoder asCoderViewModel.
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> coderViewModel [
	^ valueHolder contents
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> coderViewModel: aCoderViewModel [
	coder := aCoderViewModel coderModel.
	valueHolder contents: aCoderViewModel
]

{ #category : #private }
GtPharoNewMethodCoderMenu >> ensureCoderViewModel [
	self coderViewModel ifNotNil: [ ^ self ].
	self coder: GtPharoMethodCoder new
]

{ #category : #'api - initialization' }
GtPharoNewMethodCoderMenu >> forClass: aBehavior source: aSource [
	self coder: (GtPharoMethodCoder forClass: aBehavior source: aSource)
]

{ #category : #initialization }
GtPharoNewMethodCoderMenu >> initialize [
	super initialize.

	onMethodCoderSaved := [ :anAnnouncement :aCoderViewModel :anElement |  ].
	onObjectToSpawn := [ :aSpawnEvent | ].
	valueHolder := ValueHolder new.
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> onMethodCoderSaved [
	^ onMethodCoderSaved
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> onMethodCoderSaved: aBlock [
	"Set a block that is evaluated when a method is saved.
	The block can have two arguments [ :anAnnouncement :aCoderViewModel :anElement | ]."

	onMethodCoderSaved := aBlock
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> onObjectToSpawn [
	^ onObjectToSpawn
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> onObjectToSpawn: aBlock [
	"Set a block that is evaluated to handle GtPhlowObjectToSpawn events.
	The block can have one arguments [ :aSpawnEvent | ]."

	onObjectToSpawn := aBlock
]

{ #category : #'api - initialization' }
GtPharoNewMethodCoderMenu >> protocol: aProtocolName [
	self coder protocol: aProtocolName
]

{ #category : #'api - initialization' }
GtPharoNewMethodCoderMenu >> shouldHaveHeader: aBoolean [
	self coderViewModel shouldHaveHeader: aBoolean
]

{ #category : #accessing }
GtPharoNewMethodCoderMenu >> valueHolder [
	^ valueHolder
]
